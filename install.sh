#!/usr/bin/env bash
# =============================================================================
# AI Project Engineering - Install Script
# Installs agents and skills to ~/.claude/ (Claude Code runtime)
#
# Usage:
#   ./install.sh              # Install everything
#   ./install.sh all          # Install everything
#   ./install.sh pre-sales    # Install pre-sales agent + skills only
#   ./install.sh dev          # Install dev agent + skills only
#   ./install.sh project      # Install project agent + skills only
#   ./install.sh --dry-run    # Show what would be installed without copying
# =============================================================================

set -euo pipefail

# --- Configuration ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
CLAUDE_SKILLS_DIR="$CLAUDE_DIR/skills"
BACKUP_DIR="$CLAUDE_DIR/backups/$(date +%Y%m%d_%H%M%S)"

# Agent directory mapping: group_name -> (source_dir, runtime_dir)
# Most agents use NN-prefix in both source and runtime, except product-copilot
# which has no prefix at runtime (installed before the numbering convention).
declare -A AGENT_SRC_DIRS=(
    [pre-sales]="02-pre-sales-copilot"
    [product]="03-product-copilot"
    [dev]="04-dev-copilot"
    [testing]="05-testing-copilot"
    [delivery]="06-delivery-copilot"
    [project]="07-project-copilot"
)
declare -A AGENT_RUNTIME_DIRS=(
    [pre-sales]="02-pre-sales-copilot"
    [product]="product-copilot"
    [dev]="04-dev-copilot"
    [testing]="05-testing-copilot"
    [delivery]="06-delivery-copilot"
    [project]="07-project-copilot"
)

# Agent display names for reporting
declare -A AGENT_NAMES=(
    [pre-sales]="Pre-Sales Copilot"
    [product]="Product Copilot"
    [dev]="Dev Copilot"
    [testing]="Testing Copilot"
    [delivery]="Delivery Copilot"
    [project]="Project Copilot"
)

# --- Helper Functions ---
info()  { echo -e "\033[1;34m[INFO]\033[0m  $*"; }
ok()    { echo -e "\033[1;32m[OK]\033[0m    $*"; }
warn()  { echo -e "\033[1;33m[WARN]\033[0m  $*"; }
error() { echo -e "\033[1;31m[ERROR]\033[0m $*" >&2; }

# Create backup of an existing directory
backup_if_exists() {
    local target="$1"
    if [ -d "$target" ]; then
        mkdir -p "$BACKUP_DIR"
        local basename
        basename="$(basename "$target")"
        cp -r "$target" "$BACKUP_DIR/"
        info "Backed up existing $basename to $BACKUP_DIR/"
    fi
}

# Install a single agent (copilot directory)
install_agent() {
    local group="$1"
    local src_dir="${AGENT_SRC_DIRS[$group]}"
    local rt_dir="${AGENT_RUNTIME_DIRS[$group]}"
    local source="$SCRIPT_DIR/$src_dir"

    if [ ! -d "$source" ]; then
        error "Agent source not found: $source"
        return 1
    fi

    local target="$CLAUDE_SKILLS_DIR/$rt_dir"
    backup_if_exists "$target"
    # Remove target first to avoid cp -r nesting issue (cp src target/ creates target/src/)
    rm -rf "$target"
    # Copy source contents into target (trailing slash on source copies contents, not the dir itself)
    mkdir -p "$target"
    cp -r "$source"/* "$target"/
    ok "Installed agent: ${AGENT_NAMES[$group]} ($rt_dir/)"
}

# Install all skills for a given group
install_skills() {
    local group="$1"
    local source_dir="$SCRIPT_DIR/skills/$group"

    if [ ! -d "$source_dir" ]; then
        warn "No skills directory for group: $group"
        return 0
    fi

    local count=0
    for skill_path in "$source_dir"/*/; do
        [ -d "$skill_path" ] || continue
        local skill_name
        skill_name="$(basename "$skill_path")"
        local target="$CLAUDE_SKILLS_DIR/$skill_name"

        backup_if_exists "$target"
        rm -rf "$target"
        cp -r "$skill_path" "$target"
        count=$((count + 1))
        ok "Installed skill: $group/$skill_name"
    done

    if [ "$count" -eq 0 ]; then
        warn "No skills found in $group/"
    else
        info "Group '$group': $count skill(s) installed"
    fi
}

# --- Dry Run ---
dry_run() {
    local targets=("$@")
    echo ""
    echo "=== DRY RUN - Nothing will be installed ==="
    echo ""

    for group in "${targets[@]}"; do
        local src_dir="${AGENT_SRC_DIRS[$group]}"
        local rt_dir="${AGENT_RUNTIME_DIRS[$group]}"
        local agent_name="${AGENT_NAMES[$group]}"
        echo "Agent: $agent_name ($rt_dir/)"
        echo "  Source: $SCRIPT_DIR/$src_dir/"
        echo "  Target: $CLAUDE_SKILLS_DIR/$rt_dir/"

        local source_dir="$SCRIPT_DIR/skills/$group"
        if [ -d "$source_dir" ]; then
            for skill_path in "$source_dir"/*/; do
                [ -d "$skill_path" ] || continue
                local skill_name
                skill_name="$(basename "$skill_path")"
                echo "  Skill: $skill_name"
                echo "    Source: $skill_path"
                echo "    Target: $CLAUDE_SKILLS_DIR/$skill_name/"
                [ -d "$CLAUDE_SKILLS_DIR/$skill_name" ] && echo "    (would backup existing)"
            done
        fi
        echo ""
    done

    echo "=== End DRY RUN ==="
    echo ""
}

# --- Main ---
main() {
    local target="${1:-all}"
    local is_dry_run=false

    # Check for dry-run flag
    if [ "$target" = "--dry-run" ]; then
        is_dry_run=true
        target="${2:-all}"
    fi

    # Validate target
    local groups=()
    if [ "$target" = "all" ]; then
        # Install in order: pre-sales, product, dev, testing, delivery, project
        groups=(pre-sales product dev testing delivery project)
    elif [ -n "${AGENT_SRC_DIRS[$target]+x}" ]; then
        groups=("$target")
    else
        error "Unknown agent: '$target'"
        echo ""
        echo "Available agents:"
        for group in pre-sales product dev testing delivery project; do
            echo "  - $group (${AGENT_NAMES[$group]})"
        done
        echo ""
        echo "Usage: $0 [all|pre-sales|product|dev|testing|delivery|project] [--dry-run]"
        exit 1
    fi

    # Handle dry-run
    if [ "$is_dry_run" = true ]; then
        dry_run "${groups[@]}"
        exit 0
    fi

    echo ""
    echo "========================================="
    echo " AI Project Engineering - Installer"
    echo "========================================="
    echo ""

    # Ensure target directories exist
    mkdir -p "$CLAUDE_SKILLS_DIR"

    # Count totals
    local total_agents=0
    local total_skills=0
    for group in "${groups[@]}"; do
        total_agents=$((total_agents + 1))
        local skill_dir="$SCRIPT_DIR/skills/$group"
        if [ -d "$skill_dir" ]; then
            for d in "$skill_dir"/*/; do
                [ -d "$d" ] && total_skills=$((total_skills + 1))
            done
        fi
    done

    info "Will install $total_agents agent(s) + $total_skills skill(s)"
    info "Target: $CLAUDE_SKILLS_DIR/"
    echo ""

    # Install each group
    local installed_agents=0
    local installed_skills=0
    for group in "${groups[@]}"; do
        info "--- ${AGENT_NAMES[$group]} ---"

        # Install agent
        if install_agent "$group"; then
            installed_agents=$((installed_agents + 1))
        fi

        # Install skills
        local skill_dir="$SCRIPT_DIR/skills/$group"
        if [ -d "$skill_dir" ]; then
            local prev_count=$installed_skills
            for skill_path in "$skill_dir"/*/; do
                [ -d "$skill_path" ] || continue
                local skill_name
                skill_name="$(basename "$skill_path")"
                local target="$CLAUDE_SKILLS_DIR/$skill_name"

                backup_if_exists "$target"
                rm -rf "$target"
                cp -r "$skill_path" "$target"
                ok "Installed skill: $group/$skill_name"
                installed_skills=$((installed_skills + 1))
            done
            local group_skills=$((installed_skills - prev_count))
            info "Group '$group': $group_skills skill(s) installed"
        fi

        echo ""
    done

    # Summary
    echo "========================================="
    echo " Installation Complete"
    echo "========================================="
    echo ""
    ok "Agents installed:  $installed_agents"
    ok "Skills installed:  $installed_skills"
    echo ""

    if [ -d "$BACKUP_DIR" ]; then
        info "Backups saved to: $BACKUP_DIR"
    fi

    echo ""
    info "Installed agents and skills:"
    for group in "${groups[@]}"; do
        local rt_dir="${AGENT_RUNTIME_DIRS[$group]}"
        echo "  ${AGENT_NAMES[$group]}:"
        echo "    - $rt_dir/ (agent)"
        local skill_dir="$SCRIPT_DIR/skills/$group"
        if [ -d "$skill_dir" ]; then
            for skill_path in "$skill_dir"/*/; do
                [ -d "$skill_path" ] || continue
                echo "    - $(basename "$skill_path")/ (skill)"
            done
        fi
    done
    echo ""
}

main "$@"
