#!/usr/bin/env bash
# =============================================================================
# AI Project Engineering - Install Script (v1.0, DSBL × 工具中立)
#
# 体系标准层 + 产物层模板（工具中立）始终部署；参考实现按 --adapter 可选。
#
# Usage:
#   ./install.sh                                # 默认：部署模板 + schema + QG checklist
#   ./install.sh --adapter claude-code          # 部署参考实现到 ~/.claude/skills/
#   ./install.sh --adapter codex                # 生成 AGENTS.md 部署到项目根 .codex/
#   ./install.sh --adapter cursor               # 生成 .cursorrules 部署到项目根 .cursor/
#   ./install.sh --adapter custom               # 只部署模板+schema+QG checklist（=默认）
#   ./install.sh --templates-only               # 只部署产物层模板（最小化）
#   ./install.sh --tools                        # 部署 snapshot/rollback/validate-handoff 到 ~/bin/
#   ./install.sh --check-neutral                # 工具中立性校验（grep 标准层不应有具体工具名）
#   ./install.sh --dry-run                      # 预览不复制
# =============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 默认目标目录（可改环境变量 AIPE_HOME）
TARGET_HOME="${AIPE_HOME:-$HOME/ai-project-engineering}"
TEMPLATES_DIR="$TARGET_HOME/templates"
SCHEMA_DIR="$TARGET_HOME/schema"

# Claude-Code 适配目标
CLAUDE_DIR="$HOME/.claude"
CLAUDE_SKILLS_DIR="$CLAUDE_DIR/skills"

# 参考实现源
REF_IMPL_DIR="$SCRIPT_DIR/06-参考实现"

# --- Helpers ---
info()  { echo -e "\033[1;34m[INFO]\033[0m  $*"; }
ok()    { echo -e "\033[1;32m[OK]\033[0m    $*"; }
warn()  { echo -e "\033[1;33m[WARN]\033[0m  $*"; }
error() { echo -e "\033[1;31m[ERROR]\033[0m $*" >&2; }

# --- 部署：体系标准层 + 产物层模板（工具中立，所有 adapter 都做）---
deploy_templates() {
    local target="${1:-$TEMPLATES_DIR}"
    mkdir -p "$target"
    info "部署体系标准层 + 产物层模板到 $target/"

    # 标准层（6 份权威源）
    mkdir -p "$target/01-标准层"
    cp -r "$SCRIPT_DIR/01-标准层"/* "$target/01-标准层"/ 2>/dev/null || true
    ok "01-标准层/ (6 份权威源)"

    # 产物层（模板）
    mkdir -p "$target/02-产物层"
    cp -r "$SCRIPT_DIR/02-产物层"/* "$target/02-产物层"/ 2>/dev/null || true
    ok "02-产物层/ (DSBL 模板)"

    # 执行层（角色 Playbook + HITL 规则）
    mkdir -p "$target/03-执行层"
    cp -r "$SCRIPT_DIR/03-执行层"/* "$target/03-执行层"/ 2>/dev/null || true
    ok "03-执行层/ (5 角色 Playbook + HITL 规则)"

    # 理论层
    mkdir -p "$target/00-理论层"
    cp -r "$SCRIPT_DIR/00-理论层"/* "$target/00-理论层"/ 2>/dev/null || true
    ok "00-理论层/ (4 份原理)"

    # Schema 单独一份（便于工具读取）
    mkdir -p "$SCHEMA_DIR"
    cp "$SCRIPT_DIR/01-标准层/04-阶段交接契约Schema.md" "$SCHEMA_DIR/" 2>/dev/null || true
    cp "$SCRIPT_DIR/04-工具层/04-交接契约工具/handoff-template.yaml" "$SCHEMA_DIR/" 2>/dev/null || true
    ok "schema/handoff-template.yaml"

    echo ""
    info "模板部署完成：$target/"
    echo "    使用方式：让 AI 工具读 $target/02-产物层/{阶段}/*.md 填字段"
}

# --- 部署：Claude-Code 参考实现 ---
deploy_claude_code() {
    mkdir -p "$CLAUDE_SKILLS_DIR"
    info "部署 Claude-Code 参考实现到 $CLAUDE_SKILLS_DIR/"

    # 6 copilot
    local copilots=(pre-sales-copilot product-copilot dev-copilot testing-copilot delivery-copilot project-copilot)
    for cp_name in "${copilots[@]}"; do
        local src="$REF_IMPL_DIR/copilots/$cp_name"
        local tgt="$CLAUDE_SKILLS_DIR/$cp_name"
        if [ -d "$src" ]; then
            rm -rf "$tgt"
            cp -r "$src" "$tgt"
            ok "copilot: $cp_name/"
        else
            warn "copilot 源缺失：$src"
        fi
    done

    # 18 skills（spec/build/ship/learn）
    for group in spec build ship learn; do
        local src="$REF_IMPL_DIR/skills/$group"
        if [ -d "$src" ]; then
            for skill_path in "$src"/*/; do
                [ -d "$skill_path" ] || continue
                local sname
                sname="$(basename "$skill_path")"
                rm -rf "$CLAUDE_SKILLS_DIR/$sname"
                cp -r "$skill_path" "$CLAUDE_SKILLS_DIR/$sname"
                ok "skill: $group/$sname"
            done
        fi
    done

    echo ""
    info "Claude-Code 参考实现部署完成（6 copilot + 18 skills）"
    echo "    详见：05-适配层/Claude-Code适配指南.md"
}

# --- 部署：Codex（生成 AGENTS.md）---
deploy_codex() {
    local project_root="${1:-$PWD}"
    info "部署 Codex 适配到 $project_root/.codex/ + AGENTS.md"

    mkdir -p "$project_root/.codex/roles"
    mkdir -p "$project_root/.codex/workflows"

    # 主入口 AGENTS.md
    cat > "$project_root/AGENTS.md" <<'EOF'
# AGENTS.md — 本项目 AI 协作约定（基于 ai-project-engineering 体系）

## 强制契约
- 阶段定义：见 01-标准层/01-DSBL五阶段定义.md
- Loop 微循环：见 01-标准层/02-Loop微循环规范.md
- 质量门禁：见 01-标准层/03-质量门禁QG-D至QG-Ship.md
- 交接契约：见 01-标准层/04-阶段交接契约Schema.md
- HITL 规则：见 03-执行层/03-HITL规则表.md

## 角色路由
| 用户意图 | 角色 | 加载 |
|---------|------|------|
| 需求/方案/PRD | Spec-Writer | .codex/roles/spec-writer.md |
| 架构/编码/审查 | Builder | .codex/roles/builder.md |
| 门禁/评审 | Reviewer | .codex/roles/reviewer.md |
| 测试/部署/验收 | Shipper | .codex/roles/shipper.md |
| 项目管理/复盘 | Keeper | .codex/roles/keeper.md |

## HITL 强制点
- D（需求共识）：L3 → HITL-In
- S（方案/架构）：L3 → HITL-In
- Ship（生产部署）：L4 → HITL-In + 多人签

## 阶段切换
每完成一个 DSBL 阶段：跑 QG checklist → 写 handoff.yaml → git 提交 → 通知下游。
EOF
    ok "AGENTS.md"

    # 5 角色 placeholder（指向体系 Playbook）
    for role in spec-writer builder reviewer shipper keeper; do
        local playbook="$SCRIPT_DIR/03-执行层/01-角色Playbook/$(echo $role | sed 's/.*/\u&/' | sed 's/-//' | sed 's/specwriter/Spec-Writer/;s/builder/Builder/;s/reviewer/Reviewer/;s/shipper/Shipper/;s/keeper/Keeper/')-Playbook.md"
        cat > "$project_root/.codex/roles/$role.md" <<EOF
# $role 角色约定（Codex 适配）

本角色完整 Playbook 见：
$SCRIPT_DIR/03-执行层/01-角色Playbook/

按 DSBL 阶段执行：
1. 加载上游 handoff.yaml
2. 按 02-产物层/{阶段}/ 模板生成产物
3. 跑 QG checklist
4. 写下游 handoff.yaml
EOF
    done

    # handoff 模板
    cp "$SCRIPT_DIR/04-工具层/04-交接契约工具/handoff-template.yaml" \
       "$project_root/.codex/handoff-template.yaml" 2>/dev/null || true

    echo ""
    info "Codex 适配部署完成（AGENTS.md + .codex/roles/）"
    echo "    详见：05-适配层/Codex适配指南.md"
    warn "注：Codex 不自动部署参考实现 18 skills，按需自行迁移"
}

# --- 部署：Cursor（生成 .cursorrules + .cursor/rules/）---
deploy_cursor() {
    local project_root="${1:-$PWD}"
    info "部署 Cursor 适配到 $project_root/.cursor/ + .cursorrules"

    mkdir -p "$project_root/.cursor/rules"

    # 主入口 .cursorrules
    cat > "$project_root/.cursorrules" <<'EOF'
---
description: AI Project Engineering 体系协作约定
globs: ["项目文档/**", "src/**", "handoff.yaml"]
---

# 本项目 AI 协作约定（基于 ai-project-engineering 体系）

## 强制契约
- 阶段定义：见 01-标准层/01-DSBL五阶段定义.md
- Loop 微循环：见 01-标准层/02-Loop微循环规范.md
- 质量门禁：见 01-标准层/03-质量门禁QG-D至QG-Ship.md
- 交接契约：见 01-标准层/04-阶段交接契约Schema.md
- HITL 规则：见 03-执行层/03-HITL规则表.md

## 角色路由（@加载对应 .mdc）
| 用户意图 | 角色 | 加载 |
|---------|------|------|
| 需求/方案/PRD | Spec-Writer | @.cursor/rules/spec-writer.mdc |
| 架构/编码/审查 | Builder | @.cursor/rules/builder.mdc |
| 门禁/评审 | Reviewer | @.cursor/rules/reviewer.mdc |
| 测试/部署/验收 | Shipper | @.cursor/rules/shipper.mdc |
| 项目管理/复盘 | Keeper | @.cursor/rules/keeper.mdc |

## HITL 强制点
- D（需求共识）：L3 → Cursor Agent Plan Mode + 人审
- S（方案/架构）：L3 → Plan + 人审
- Ship（生产部署）：L4 → Plan + 多人签
EOF
    ok ".cursorrules"

    # 5 角色 .mdc placeholder
    for role in spec-writer builder reviewer shipper keeper; do
        cat > "$project_root/.cursor/rules/$role.mdc" <<EOF
---
description: $role 角色规则
globs: ["项目文档/**"]
---

# $role 角色（Cursor 适配）

本角色完整 Playbook 见 03-执行层/01-角色Playbook/。

按 DSBL 阶段执行：加载上游 handoff → 按模板生成 → 跑 QG → 写下游 handoff。
EOF
    done

    # 4 QG .mdc
    for stage in d s b ship; do
        cat > "$project_root/.cursor/rules/qg-$stage.mdc" <<EOF
---
description: QG-$stage 质量门禁
globs: ["handoff.yaml"]
---

# QG-$stage 检查（详见 01-标准层/03-质量门禁QG-D至QG-Ship.md）

执行前必须跑完对应 QG checklist 全部 🔴 项。
EOF
    done

    cp "$SCRIPT_DIR/04-工具层/04-交接契约工具/handoff-template.yaml" \
       "$project_root/.cursor/handoff-template.yaml" 2>/dev/null || true

    echo ""
    info "Cursor 适配部署完成（.cursorrules + .cursor/rules/）"
    echo "    详见：05-适配层/Cursor适配指南.md"
    warn "注：Cursor 不自动部署参考实现 18 skills，按需自行迁移"
}

# --- 部署：工具脚本（snapshot/rollback/validate-handoff）---
deploy_tools() {
    local bin_dir="$HOME/bin"
    mkdir -p "$bin_dir"
    info "部署工具脚本到 $bin_dir/"

    local tools=(
        "04-工具层/03-Checkpoint脚本/snapshot.sh:aipe-snapshot"
        "04-工具层/03-Checkpoint脚本/rollback.sh:aipe-rollback"
        "04-工具层/04-交接契约工具/validate-handoff.sh:aipe-validate-handoff"
    )
    local count=0
    for entry in "${tools[@]}"; do
        local src="${entry%%:*}"
        local name="${entry##*:}"
        local src_path="$SCRIPT_DIR/$src"
        if [ -f "$src_path" ]; then
            cp "$src_path" "$bin_dir/$name"
            chmod +x "$bin_dir/$name"
            ok "$name → $bin_dir/$name"
            count=$((count + 1))
        else
            warn "工具源缺失：$src_path"
        fi
    done

    echo ""
    info "如未在 PATH 中，添加：export PATH=\"$bin_dir:\$PATH\""
    ok "工具脚本部署：$count 个"
}

# --- 工具中立性校验 ---
check_neutral() {
    info "工具中立性校验：标准层不应出现具体工具名"

    local fail=0
    local patterns=("Claude Code" "Codex" "Cursor" "Copilot" "通义灵码" "文心快码")

    echo ""
    echo "=== 01-标准层/ ==="
    for p in "${patterns[@]}"; do
        local hits
        hits=$(grep -rln "$p" "$SCRIPT_DIR/01-标准层/" 2>/dev/null | wc -l || echo 0)
        if [ "$hits" -gt 0 ]; then
            warn "  发现 '$p'：$hits 文件"
            fail=$((fail + 1))
        else
            ok "  '$p'：0"
        fi
    done

    echo ""
    echo "=== 02-产物层/ ==="
    for p in "${patterns[@]}"; do
        local hits
        hits=$(grep -rln "$p" "$SCRIPT_DIR/02-产物层/" 2>/dev/null | wc -l || echo 0)
        if [ "$hits" -gt 0 ]; then
            warn "  发现 '$p'：$hits 文件"
            fail=$((fail + 1))
        else
            ok "  '$p'：0"
        fi
    done

    echo ""
    if [ "$fail" -eq 0 ]; then
        ok "工具中立性校验通过"
    else
        error "发现 $fail 处工具名泄漏，请清理"
        return 1
    fi
}

# --- Dry Run ---
dry_run() {
    local mode="$1"
    echo ""
    echo "=== DRY RUN — 模式：$mode ==="
    case "$mode" in
        claude-code)
            echo "将部署到 $CLAUDE_SKILLS_DIR/：6 copilot + 18 skills"
            echo "源：$REF_IMPL_DIR/"
            ;;
        codex)
            echo "将部署到 $PWD/.codex/ + $PWD/AGENTS.md"
            ;;
        cursor)
            echo "将部署到 $PWD/.cursor/ + $PWD/.cursorrules"
            ;;
        custom|templates)
            echo "将部署到 $TEMPLATES_DIR/：标准层 + 产物层 + 执行层 + 理论层"
            ;;
    esac
    echo "=== End DRY RUN ==="
    echo ""
}

# --- Main ---
main() {
    local arg="${1:-custom}"

    case "$arg" in
        --adapter)
            local adapter="${2:-custom}"
            case "$adapter" in
                claude-code)
                    echo ""
                    echo "========================================="
                    echo " AI Project Engineering - Claude-Code 适配"
                    echo "========================================="
                    deploy_templates
                    echo ""
                    deploy_claude_code
                    ;;
                codex)
                    echo ""
                    echo "========================================="
                    echo " AI Project Engineering - Codex 适配"
                    echo "========================================="
                    deploy_templates
                    echo ""
                    deploy_codex "${3:-$PWD}"
                    ;;
                cursor)
                    echo ""
                    echo "========================================="
                    echo " AI Project Engineering - Cursor 适配"
                    echo "========================================="
                    deploy_templates
                    echo ""
                    deploy_cursor "${3:-$PWD}"
                    ;;
                custom)
                    echo ""
                    echo "========================================="
                    echo " AI Project Engineering - 自定义工具适配"
                    echo "========================================="
                    deploy_templates
                    echo ""
                    info "自定义工具适配：让 AI 工具直接读 $TEMPLATES_DIR/ 下模板"
                    echo "    详见：05-适配层/自带工具适配指南.md"
                    ;;
                *)
                    error "未知 adapter：$adapter"
                    echo "可用：claude-code / codex / cursor / custom"
                    exit 1
                    ;;
            esac
            ;;
        --templates-only)
            echo ""
            echo "========================================="
            echo " AI Project Engineering - 仅模板"
            echo "========================================="
            deploy_templates
            ;;
        --tools)
            echo ""
            echo "========================================="
            echo " AI Project Engineering - 工具脚本"
            echo "========================================="
            deploy_tools
            ;;
        --check-neutral)
            check_neutral
            ;;
        --dry-run)
            dry_run "${2:-custom}"
            ;;
        --help|-h|help)
            cat <<'EOF'
AI Project Engineering Install Script (v1.0)

Usage:
  ./install.sh                                # 默认：模板 + schema + QG
  ./install.sh --adapter claude-code          # 部署参考实现到 ~/.claude/skills/
  ./install.sh --adapter codex                # 生成 AGENTS.md + .codex/
  ./install.sh --adapter cursor               # 生成 .cursorrules + .cursor/
  ./install.sh --adapter custom               # 只部署模板（=默认）
  ./install.sh --templates-only               # 只部署产物层模板
  ./install.sh --tools                        # snapshot/rollback/validate-handoff → ~/bin/
  ./install.sh --check-neutral                # 工具中立性校验
  ./install.sh --dry-run [mode]               # 预览

核心：体系标准层 + 产物层模板始终部署（工具中立）；参考实现按 adapter 可选。
EOF
            ;;
        *)
            error "未知参数：$arg"
            echo "运行 ./install.sh --help 查看用法"
            exit 1
            ;;
    esac

    echo ""
    ok "完成。详见 README.md 和 05-适配层/"
}

main "$@"
