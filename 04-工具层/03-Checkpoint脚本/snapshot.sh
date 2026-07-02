#!/usr/bin/env bash
# snapshot.sh — 部署前/节点出口 快照工具
# 配合 QG-B/QG-Ship 部署门禁使用，详见 ../../01-标准层/03-质量门禁QG-D/S/B/Ship.md
#
# 用法：
#   ./snapshot.sh --type {deploy|node} --node {B|B|Ship|...} --tag <tag-name>
#   ./snapshot.sh test                  # 创建测试快照（验证工具可运行）
#   ./snapshot.sh --help
#
# 输出：snapshots/{tag}-{timestamp}/ 目录，含 DB dump + 配置 + AI context + sha256

set -euo pipefail

# ============ 默认配置 ============
ROOT_DIR="${PROJECT_ROOT:-$(pwd)}"
SNAPSHOT_DIR="${ROOT_DIR}/snapshots"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)

# 可被环境变量覆盖
DB_TYPE="${DB_TYPE:-mysql}"           # mysql | postgres | none
DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-3306}"
DB_USER="${DB_USER:-root}"
DB_NAME="${DB_NAME:-app}"
DB_PASSWORD="${DB_PASSWORD:-}"

CONFIG_PATHS=("config/" ".env" ".env.production")  # 配置文件位置
AI_CONTEXT_PATHS=("项目文档/" "ai-context/" "CLAUDE.md")  # AI 上下文位置

# ============ 参数解析 ============
SNAPSHOT_TYPE=""
NODE=""
TAG=""

print_help() {
  cat <<EOF
snapshot.sh — Checkpoint 快照工具

用法：
  ./snapshot.sh --type deploy --node Ship --tag pre-deploy-2026-07-01
  ./snapshot.sh --type node --node B --tag feature-auth-done
  ./snapshot.sh test

选项：
  --type <deploy|node>   快照类型（deploy=生产部署前 / node=N 节点出口）
  --node <NX>            N 节点编号（全程）
  --tag <name>           快照标签（人类可读）
  --help                 显示帮助

环境变量：
  PROJECT_ROOT           项目根目录（默认当前路径）
  DB_TYPE                数据库类型（mysql/postgres/none）
  DB_HOST/PORT/USER/NAME 数据库连接
  DB_PASSWORD            数据库密码（建议从 .env 读）

输出：
  snapshots/{tag}-{timestamp}/
    ├── db-backup.sql                # 数据库 dump
    ├── config-backup.tar.gz         # 配置文件备份
    ├── ai-context-backup.json       # AI 上下文备份
    └── manifest.sha256              # sha256 校验

退出码：
  0 = 成功
  1 = 参数错误
  2 = 依赖缺失
  3 = 备份失败
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --type) SNAPSHOT_TYPE="$2"; shift 2 ;;
    --node) NODE="$2"; shift 2 ;;
    --tag)  TAG="$2"; shift 2 ;;
    test)   SNAPSHOT_TYPE="test"; NODE="TEST"; TAG="smoke-test-$(date +%s)"; shift 1 ;;
    --help|-h) print_help; exit 0 ;;
    *) echo "未知参数：$1"; print_help; exit 1 ;;
  esac
done

if [[ -z "$SNAPSHOT_TYPE" || -z "$NODE" || -z "$TAG" ]]; then
  echo "❌ 缺少必要参数"
  print_help
  exit 1
fi

# ============ 前置检查 ============
command -v sha256sum >/dev/null 2>&1 || { echo "❌ 缺少 sha256sum"; exit 2; }
command -v tar >/dev/null 2>&1 || { echo "❌ 缺少 tar"; exit 2; }

# ============ 创建快照目录 ============
SNAP_PATH="${SNAPSHOT_DIR}/${TAG}-${TIMESTAMP}"
mkdir -p "$SNAP_PATH"
echo "📁 Snapshot directory: $SNAP_PATH"

# ============ 1. 数据库备份 ============
backup_db() {
  if [[ "$DB_TYPE" == "none" ]]; then
    echo "⏭️  DB_TYPE=none, 跳过数据库备份"
    return 0
  fi

  local dump_file="${SNAP_PATH}/db-backup.sql"
  echo "📦 Backing up database ($DB_TYPE)..."

  case "$DB_TYPE" in
    mysql)
      command -v mysqldump >/dev/null 2>&1 || { echo "❌ 缺少 mysqldump"; return 3; }
      mysqldump -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USER" \
        ${DB_PASSWORD:+-p"$DB_PASSWORD"} \
        --single-transaction --routines --triggers \
        "$DB_NAME" > "$dump_file" || return 3
      ;;
    postgres)
      command -v pg_dump >/dev/null 2>&1 || { echo "❌ 缺少 pg_dump"; return 3; }
      PGPASSWORD="$DB_PASSWORD" pg_dump -h"$DB_HOST" -p"$DB_PORT" -U"$DB_USER" \
        -Fc -f "$dump_file" "$DB_NAME" || return 3
      ;;
    *) echo "❌ 未知 DB_TYPE: $DB_TYPE"; return 1 ;;
  esac

  local size=$(du -h "$dump_file" | cut -f1)
  echo "✓ DB dump: db-backup.sql ($size)"
}

# ============ 2. 配置文件备份 ============
backup_config() {
  local config_file="${SNAP_PATH}/config-backup.tar.gz"
  echo "⚙️  Backing up config files..."

  local found=()
  for p in "${CONFIG_PATHS[@]}"; do
    if [[ -e "$ROOT_DIR/$p" ]]; then
      found+=("$p")
    fi
  done

  if [[ ${#found[@]} -eq 0 ]]; then
    echo "⏭️  未找到配置文件，跳过"
    return 0
  fi

  tar -czf "$config_file" -C "$ROOT_DIR" "${found[@]}" || return 3
  local size=$(du -h "$config_file" | cut -f1)
  echo "✓ Config: config-backup.tar.gz ($size)"
}

# ============ 3. AI 上下文备份 ============
backup_ai_context() {
  local ctx_file="${SNAP_PATH}/ai-context-backup.json"
  echo "🤖 Backing up AI context..."

  local found=()
  for p in "${AI_CONTEXT_PATHS[@]}"; do
    if [[ -e "$ROOT_DIR/$p" ]]; then
      found+=("$p")
    fi
  done

  if [[ ${#found[@]} -eq 0 ]]; then
    echo "⏭️  未找到 AI 上下文，跳过"
    return 0
  fi

  cat > "$ctx_file" <<EOF
{
  "snapshot_type": "$SNAPSHOT_TYPE",
  "node": "$NODE",
  "tag": "$TAG",
  "timestamp": "$TIMESTAMP",
  "created_by": "$(whoami)",
  "project_root": "$ROOT_DIR",
  "context_paths": $(printf '%s\n' "${found[@]}" | python3 -c 'import sys, json; print(json.dumps([l.strip() for l in sys.stdin if l.strip()]))')
}
EOF
  # 同时打包实际内容
  local archive="${SNAP_PATH}/ai-context-backup.tar.gz"
  tar -czf "$archive" -C "$ROOT_DIR" "${found[@]}" || return 3
  echo "✓ AI context: ai-context-backup.json + ai-context-backup.tar.gz"
}

# ============ 4. 生成 manifest ============
gen_manifest() {
  local manifest="${SNAP_PATH}/manifest.sha256"
  echo "🔐 Generating sha256 manifest..."

  cd "$SNAP_PATH"
  : > "$manifest"
  for f in *; do
    [[ "$f" == "manifest.sha256" ]] && continue
    [[ -f "$f" ]] && sha256sum "$f" >> "$manifest"
  done

  # 追加元数据
  cat >> "$manifest" <<EOF

# Snapshot metadata
# type: $SNAPSHOT_TYPE
# node: $NODE
# tag: $TAG
# timestamp: $TIMESTAMP
# created_by: $(whoami)
# host: $(hostname)
EOF
  echo "✓ Manifest: manifest.sha256"
}

# ============ 主流程 ============
echo ""
echo "═══════════════════════════════════════════════════════════"
echo "  snapshot.sh — $SNAPSHOT_TYPE / $NODE / $TAG"
echo "═══════════════════════════════════════════════════════════"
echo ""

backup_db
backup_config
backup_ai_context
gen_manifest

echo ""
echo "✅ Snapshot created successfully!"
echo "   Path: $SNAP_PATH"
echo "   Type: $SNAPSHOT_TYPE | Node: $NODE | Tag: $TAG"
echo ""
echo "📌 回滚命令："
echo "   ./rollback.sh --to ${TAG}-${TIMESTAMP}"
echo ""
echo "📌 验证完整性："
echo "   cd $SNAP_PATH && sha256sum -c manifest.sha256"
