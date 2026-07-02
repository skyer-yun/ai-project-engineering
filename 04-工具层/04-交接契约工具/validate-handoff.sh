#!/usr/bin/env bash
# validate-signature.sh — 交接契约引用 YAML 校验工具
# 协议权威源：../../01-标准层/06-交接契约引用协议.md
#
# 用法：
#   ./validate-signature.sh <file.yaml>
#   ./validate-signature.sh examples/good.yaml
#   ./validate-signature.sh --batch loop-signatures/    # 批量校验目录
#   ./validate-signature.sh --help
#
# 校验项：
#   1. 必填字段（node / iteration / agent / input/output_artifacts / eval_scores / reflect_passed / exit_met）
#   2. 字段类型（iteration 是整数 / *_passed 是 bool / eval_scores 是 map）
#   3. 节点编号合法（全程）
#   4. agent 名合法（6 copilot 之一）
#   5. exit_met=true 时 handoff_to 必填
#   6. 历史对比（可选，与上一份 signature 比较 node 是否递进）

set -euo pipefail

# ============ 合法值 ============
VALID_NODES="D D D S S S B B B Ship Ship Ship Ship Ship Ship L"
VALID_AGENTS="pre-sales-copilot product-copilot dev-copilot testing-copilot delivery-copilot project-copilot"

# 必填字段（每个 signature 顶层）
REQUIRED_FIELDS=(node iteration agent input_artifacts output_artifacts eval_scores reflect_passed exit_met)

# ============ 参数解析 ============
BATCH_MODE=0
TARGET=""

print_help() {
  cat <<EOF
validate-signature.sh — 交接契约引用 YAML 校验

用法：
  ./validate-signature.sh <file.yaml>           # 单文件校验
  ./validate-signature.sh --batch <dir>         # 批量校验目录所有 yaml
  ./validate-signature.sh --help

退出码：
  0 = 全部通过
  1 = 参数错误
  2 = 缺少依赖（python3/yaml）
  3 = 校验失败（含错误数）
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --batch) BATCH_MODE=1; TARGET="$2"; shift 2 ;;
    --help|-h) print_help; exit 0 ;;
    -*) echo "未知选项：$1"; print_help; exit 1 ;;
    *) TARGET="$1"; shift ;;
  esac
done

if [[ -z "$TARGET" ]]; then
  echo "❌ 缺少目标参数"
  print_help
  exit 1
fi

# ============ 依赖检查 ============
command -v python3 >/dev/null 2>&1 || { echo "❌ 缺少 python3"; exit 2; }
python3 -c "import yaml" 2>/dev/null || {
  echo "❌ 缺少 PyYAML，请运行：pip install pyyaml"
  exit 2
}

# ============ Python 校验逻辑 ============
read -r -d '' PY_VALIDATE <<'PYEOF' || true
import sys, os, yaml

VALID_NODES = {f"N{i}" for i in range(1, 17)}
VALID_AGENTS = {
    "pre-sales-copilot", "product-copilot", "dev-copilot",
    "testing-copilot", "delivery-copilot", "project-copilot"
}
REQUIRED_FIELDS = ["node", "iteration", "agent", "input_artifacts",
                   "output_artifacts", "eval_scores",
                   "reflect_passed", "exit_met"]

def validate_signature(name, data, errors):
    """校验单个 signature 顶层 dict"""
    if not isinstance(data, dict):
        errors.append(f"{name}: 顶层必须是 dict，实际是 {type(data).__name__}")
        return

    # 必填字段
    for f in REQUIRED_FIELDS:
        if f not in data:
            errors.append(f"{name}: 缺少必填字段 `{f}`")

    # 节点合法性
    node = data.get("node")
    if node and node not in VALID_NODES:
        errors.append(f"{name}: 非法 node `{node}`，合法值：{sorted(VALID_NODES)}")

    # agent 合法性
    agent = data.get("agent")
    if agent and agent not in VALID_AGENTS:
        errors.append(f"{name}: 非法 agent `{agent}`，合法值：{sorted(VALID_AGENTS)}")

    # iteration 类型
    it = data.get("iteration")
    if it is not None:
        if not isinstance(it, int) or it < 1:
            errors.append(f"{name}: iteration 必须是正整数，实际：{it!r}")

    # bool 字段
    for bf in ("reflect_passed", "exit_met"):
        v = data.get(bf)
        if v is not None and not isinstance(v, bool):
            errors.append(f"{name}: {bf} 必须是 bool，实际：{v!r}")

    # exit_met=true 时 handoff_to 必填
    if data.get("exit_met") is True and not data.get("handoff_to"):
        errors.append(f"{name}: exit_met=true 时 handoff_to 必填")

    # eval_scores 必须是 map
    es = data.get("eval_scores")
    if es is not None and not isinstance(es, dict):
        errors.append(f"{name}: eval_scores 必须是 map（dict），实际：{type(es).__name__}")

    # artifacts 必须是 list
    for af in ("input_artifacts", "output_artifacts"):
        a = data.get(af)
        if a is not None and not isinstance(a, list):
            errors.append(f"{name}: {af} 必须是 list，实际：{type(a).__name__}")
        elif isinstance(a, list):
            for i, item in enumerate(a):
                if not isinstance(item, dict):
                    errors.append(f"{name}: {af}[{i}] 必须是 dict")
                elif "name" not in item or "path" not in item:
                    errors.append(f"{name}: {af}[{i}] 缺少 name 或 path")


def validate_file(filepath):
    """校验单个文件，可能含多个 signature"""
    errors = []
    try:
        with open(filepath, "r", encoding="utf-8") as f:
            content = f.read()
    except Exception as e:
        return [f"读取失败：{e}"]

    # 跳过纯注释/空文件
    stripped = "\n".join(l for l in content.split("\n")
                        if l.strip() and not l.lstrip().startswith("#"))
    if not stripped:
        return [f"空文件或纯注释：{filepath}"]

    try:
        data = yaml.safe_load(content)
    except yaml.YAMLError as e:
        return [f"YAML 解析错误：{e}"]

    if data is None:
        return [f"空文件：{filepath}"]

    if isinstance(data, dict):
        # 文件含单个 signature（无顶层 key）或多 signature（有顶层 key）
        # 判断：有 node 字段就当单 signature
        if "node" in data:
            validate_signature(filepath, data, errors)
        else:
            # 多 signature 文件，每个顶层 key 是一个 signature
            for k, v in data.items():
                if isinstance(v, dict):
                    validate_signature(f"{filepath}::{k}", v, errors)
                # 跳过 alias anchor（*xxx）
    elif isinstance(data, list):
        for i, item in enumerate(data):
            validate_signature(f"{filepath}[{i}]", item, errors)
    else:
        errors.append(f"{filepath}: 顶层必须是 dict 或 list")

    return errors


def main():
    target = sys.argv[1]
    batch = sys.argv[2] == "batch"

    if batch:
        if not os.path.isdir(target):
            print(f"❌ 不是目录：{target}", file=sys.stderr)
            return 1
        files = []
        for root, _, fs in os.walk(target):
            for f in fs:
                if f.endswith((".yaml", ".yml")):
                    files.append(os.path.join(root, f))
    else:
        if not os.path.isfile(target):
            print(f"❌ 文件不存在：{target}", file=sys.stderr)
            return 1
        files = [target]

    total_errors = 0
    total_files = 0
    for fp in files:
        total_files += 1
        errs = validate_file(fp)
        if errs:
            total_errors += len(errs)
            print(f"[FAIL] {fp}")
            for e in errs:
                print(f"   {e}")
        else:
            print(f"[OK]   {fp}")

    print(f"\n" + "=" * 50)
    if total_errors == 0:
        print(f"PASS: all {total_files} file(s) valid")
        return 0
    else:
        print(f"FAIL: {total_errors} error(s) across {total_files} file(s)")
        return 3

sys.exit(main())
PYEOF

# ============ 执行 ============
if [[ $BATCH_MODE -eq 1 ]]; then
  python3 -c "$PY_VALIDATE" "$TARGET" "batch"
else
  python3 -c "$PY_VALIDATE" "$TARGET" "single"
fi
