#!/usr/bin/env bash
# rollback.sh — 回滚到指定 Checkpoint
# 配合 snapshot.sh 使用，详见 ../../01-标准层/03-质量门禁QG-D/S/B/Ship.md §六
#
# 用法：
#   ./rollback.sh --to <tag-timestamp>
#   ./rollback.sh --to pre-deploy-20260701-1430
#   ./rollback.sh --to pre-deploy-20260701-1430 --skip-db   # 不回滚数据库
#   ./rollback.sh --list                                     # 列出可用快照
#   ./rollback.sh --help
#
# ⚠ Ship 部署场景：生产环境不可逆 L4，回滚必须双签（运维 + 业务）

set -euo pipefail

ROOT_DIR="${PROJECT_ROOT:-$(pwd)}"
SNAPSHOT_DIR="${ROOT_DIR}/snapshots"

TARGET=""
SKIP_DB=0
LIST_MODE=0

print_help() {
  cat <<EOF
rollback.sh — 回滚工具

用法：
  ./rollback.sh --to <tag-timestamp>
  ./rollback.sh --to <tag-timestamp> --skip-db
  ./rollback.sh --list
  ./rollback.sh --help

选项：
  --to <tag>             目标快照（snapshot.sh 输出的 tag-timestamp）
  --skip-db              跳过数据库回滚（仅恢复配置 + AI 上下文）
  --list                 列出所有可用快照
  --yes                  跳过交互确认（危险，仅 CI/自动化用）
  --help                 显示帮助

⚠ 回滚是高风险操作：
  - 数据库回滚会丢失快照后的数据变更
  - 配置回滚会覆盖当前配置
  - 生产环境必须双签（运维 + 业务）

退出码：
  0 = 成功
  1 = 参数错误
  2 = 依赖缺失
  3 = 回滚失败
  4 = 用户取消
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --to) TARGET="$2"; shift 2 ;;
    --skip-db) SKIP_DB=1; shift ;;
    --list) LIST_MODE=1; shift ;;
    --yes) export CONFIRM_YES=1; shift ;;
    --help|-h) print_help; exit 0 ;;
    *) echo "未知参数：$1"; print_help; exit 1 ;;
  esac
done

# ============ 列出快照模式 ============
if [[ $LIST_MODE -eq 1 ]]; then
  echo "📋 Available snapshots in: $SNAPSHOT_DIR"
  echo ""
  if [[ ! -d "$SNAPSHOT_DIR" ]]; then
    echo "  (无快照目录)"
    exit 0
  fi
  for d in "$SNAPSHOT_DIR"/*/; do
    [[ ! -d "$d" ]] && continue
    local_name=$(basename "$d")
    local_manifest="$d/manifest.sha256"
    if [[ -f "$local_manifest" ]]; then
      local_meta=$(grep -E "^# (type|node|tag|timestamp):" "$local_manifest" | head -4)
      echo "  ▸ $local_name"
      echo "$local_meta" | sed 's/^#/      /'
    else
      echo "  ▸ $local_name (无 manifest)"
    fi
    echo ""
  done
  exit 0
fi

if [[ -z "$TARGET" ]]; then
  echo "❌ 缺少 --to 参数"
  print_help
  exit 1
fi

# ============ 验证目标快照 ============
SNAP_PATH="${SNAPSHOT_DIR}/${TARGET}"
if [[ ! -d "$SNAP_PATH" ]]; then
  echo "❌ 快照不存在: $SNAP_PATH"
  echo ""
  echo "可用快照（./rollback.sh --list）："
  ls -1 "$SNAPSHOT_DIR" 2>/dev/null | sed 's/^/  /'
  exit 1
fi

MANIFEST="${SNAP_PATH}/manifest.sha256"
if [[ ! -f "$MANIFEST" ]]; then
  echo "❌ 快照缺少 manifest，无法验证"
  exit 1
fi

# ============ 依赖检查 ============
command -v sha256sum >/dev/null 2>&1 || { echo "❌ 缺少 sha256sum"; exit 2; }
command -v tar >/dev/null 2>&1 || { echo "❌ 缺少 tar"; exit 2; }

# ============ 验证快照完整性 ============
echo "🔐 验证快照完整性..."
cd "$SNAP_PATH"
if ! sha256sum -c "$MANIFEST" --quiet 2>/dev/null; then
  echo "❌ 快照完整性校验失败"
  sha256sum -c "$MANIFEST" 2>&1 | head -5
  exit 3
fi
echo "✓ 完整性校验通过"

# ============ 显示回滚计划 ============
echo ""
echo "═══════════════════════════════════════════════════════════"
echo "  回滚计划"
echo "═══════════════════════════════════════════════════════════"
echo "  目标快照: $TARGET"
echo "  路径: $SNAP_PATH"
echo ""
echo "  将要执行："
[[ -f "${SNAP_PATH}/db-backup.sql" ]] && [[ $SKIP_DB -eq 0 ]] && \
  echo "  ▸ 恢复数据库（⚠ 数据丢失风险）"
[[ -f "${SNAP_PATH}/config-backup.tar.gz" ]] && \
  echo "  ▸ 恢复配置文件"
[[ -f "${SNAP_PATH}/ai-context-backup.tar.gz" ]] && \
  echo "  ▸ 恢复 AI 上下文"
echo ""

# ============ 双重确认 ============
if [[ -z "${CONFIRM_YES:-}" ]]; then
  echo "⚠ 此操作不可逆！请确认："
  echo ""
  read -p "输入快照名以确认 ($TARGET): " CONFIRM_INPUT
  if [[ "$CONFIRM_INPUT" != "$TARGET" ]]; then
    echo "❌ 输入不匹配，取消"
    exit 4
  fi
  echo ""
  read -p "运维签字（输入姓名）: " OPS_SIGN
  read -p "业务签字（输入姓名）: " BIZ_SIGN
  echo ""
  echo "签字记录：运维=$OPS_SIGN / 业务=$BIZ_SIGN / 时间=$(date -Iseconds)"
fi

# ============ 执行回滚 ============
echo ""
echo "▶ 开始回滚..."

# 1. 数据库
restore_db() {
  if [[ $SKIP_DB -eq 1 ]]; then
    echo "⏭️  --skip-db, 跳过数据库回滚"
    return 0
  fi
  local dump_file="${SNAP_PATH}/db-backup.sql"
  [[ ! -f "$dump_file" ]] && { echo "⏭️  无数据库备份"; return 0; }

  echo "📦 恢复数据库..."
  DB_TYPE="${DB_TYPE:-mysql}"
  DB_HOST="${DB_HOST:-localhost}"
  DB_PORT="${DB_PORT:-3306}"
  DB_USER="${DB_USER:-root}"
  DB_NAME="${DB_NAME:-app}"
  DB_PASSWORD="${DB_PASSWORD:-}"

  case "$DB_TYPE" in
    mysql)
      mysql -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USER" \
        ${DB_PASSWORD:+-p"$DB_PASSWORD"} \
        "$DB_NAME" < "$dump_file" || return 3
      ;;
    postgres)
      PGPASSWORD="$DB_PASSWORD" pg_restore -h"$DB_HOST" -p"$DB_PORT" -U"$DB_USER" \
        -d "$DB_NAME" -c "$dump_file" || return 3
      ;;
  esac
  echo "✓ 数据库已恢复"
}

# 2. 配置文件
restore_config() {
  local archive="${SNAP_PATH}/config-backup.tar.gz"
  [[ ! -f "$archive" ]] && return 0
  echo "⚙️  恢复配置文件..."
  tar -xzf "$archive" -C "$ROOT_DIR" || return 3
  echo "✓ 配置已恢复"
}

# 3. AI 上下文
restore_ai_context() {
  local archive="${SNAP_PATH}/ai-context-backup.tar.gz"
  [[ ! -f "$archive" ]] && return 0
  echo "🤖 恢复 AI 上下文..."
  tar -xzf "$archive" -C "$ROOT_DIR" || return 3
  echo "✓ AI 上下文已恢复"
}

restore_db
restore_config
restore_ai_context

# ============ 回滚后冒烟测试钩子 ============
SMOKE_HOOK="${ROOT_DIR}/scripts/smoke-after-rollback.sh"
if [[ -x "$SMOKE_HOOK" ]]; then
  echo ""
  echo "▶ 运行回滚后冒烟测试..."
  if "$SMOKE_HOOK"; then
    echo "✓ 冒烟测试通过"
  else
    echo "⚠️  冒烟测试失败，请人工检查"
    exit 3
  fi
fi

echo ""
echo "═══════════════════════════════════════════════════════════"
echo "  ✅ 回滚成功！"
echo "═══════════════════════════════════════════════════════════"
echo "  目标: $TARGET"
echo "  时间: $(date -Iseconds)"
echo ""
echo "📌 后续动作："
echo "  1. 验证服务状态（健康检查）"
echo "  2. 通知干系人（业务/客户）"
echo "  3. 记录回滚原因到项目文档"
echo "  4. 若问题已修复，重新走部署流程（不可跳过 Checkpoint）"
