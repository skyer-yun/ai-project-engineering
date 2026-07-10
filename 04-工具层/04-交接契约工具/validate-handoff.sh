#!/usr/bin/env bash
# validate-handoff.sh — 阶段交接契约 YAML 校验工具
# 协议权威源：../../01-标准层/04-阶段交接契约Schema.md
#
# 用法：
#   ./validate-handoff.sh <file.yaml>
#   ./validate-handoff.sh examples/good-D-to-S.yaml
#   ./validate-handoff.sh --batch 项目文档/DEMO/_handoffs/
#   ./validate-handoff.sh --help
#
# 校验项（详见 Schema §四 下游读取规则）：
#   1. 必填字段：handoff.{schema_version, project, from_stage, to_stage, quality_gate, gate_status,
#                  output_artifacts, loop_signs, handoff, hitl_signature}
#   2. from_stage / to_stage 合法：D / S / B / Ship / L（或中文别名 需求/设计/开发/交付/复盘）
#   3. quality_gate 合法：QG-D / QG-S / QG-B / QG-Ship（或中文 QG-需求 等）
#   4. gate_status = passed / failed / escalated
#   5. loop_signs[].{iterations ≤ 5, exit_met = true, reflect_passed = true}
#   6. hitl_signature.{mode, approved_by} 齐全
#   7. output_artifacts[].{name, path, version} 必填
#
# 退出码：
#   0 = 全部通过
#   1 = 参数错误
#   2 = 缺少依赖（python3/yaml）
#   3 = 校验失败

set -euo pipefail

print_help() {
  cat <<EOF
validate-handoff.sh — 阶段交接契约 YAML 校验

用法：
  ./validate-handoff.sh <file.yaml>           # 单文件校验
  ./validate-handoff.sh --batch <dir>         # 批量校验目录所有 yaml
  ./validate-handoff.sh --help

退出码：
  0 = 全部通过
  1 = 参数错误
  2 = 缺少依赖（python3/yaml）
  3 = 校验失败
EOF
}

BATCH_MODE=0
TARGET=""
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

command -v python3 >/dev/null 2>&1 || { echo "❌ 缺少 python3"; exit 2; }
python3 -c "import yaml" 2>/dev/null || {
  echo "❌ 缺少 PyYAML，请运行：pip install pyyaml"
  exit 2
}

read -r -d '' PY_VALIDATE <<'PYEOF' || true
import sys, os, yaml

# 合法值（详见 01-标准层/04-阶段交接契约Schema.md）
STAGE_ALIASES = {
    "D": "D", "S": "S", "B": "B", "Ship": "Ship", "L": "L",
    "需求": "D", "设计": "S", "开发": "B", "交付": "Ship", "复盘": "L",
}
QG_ALIASES = {
    "QG-D": "QG-D", "QG-S": "QG-S", "QG-B": "QG-B", "QG-Ship": "QG-Ship",
    "QG-需求": "QG-D", "QG-设计": "QG-S", "QG-开发": "QG-B", "QG-交付": "QG-Ship",
}
GATE_STATUS = {"passed", "failed", "escalated"}
HITL_MODE = {"In", "On", "Fallback"}

REQUIRED_TOP = ["schema_version", "project", "from_stage", "to_stage",
                "quality_gate", "gate_status", "output_artifacts",
                "loop_signs", "handoff", "hitl_signature"]

def err(name, msg, errors):
    errors.append(f"{name}: {msg}")

def validate_one(name, data, errors):
    if not isinstance(data, dict):
        err(name, f"顶层必须是 dict，实际是 {type(data).__name__}", errors)
        return

    # 1. 必填字段
    for f in REQUIRED_TOP:
        if f not in data:
            err(name, f"缺少必填字段 `handoff.{f}`", errors)

    # 2. stage 合法
    for f in ("from_stage", "to_stage"):
        v = data.get(f)
        if v and v not in STAGE_ALIASES:
            err(name, f"非法 {f}=`{v}`，合法值：{sorted(STAGE_ALIASES)}", errors)

    # 3. quality_gate 合法
    qg = data.get("quality_gate")
    if qg and qg not in QG_ALIASES:
        err(name, f"非法 quality_gate=`{qg}`，合法值：{sorted(QG_ALIASES)}", errors)

    # 4. gate_status 合法
    gs = data.get("gate_status")
    if gs and gs not in GATE_STATUS:
        err(name, f"非法 gate_status=`{gs}`，合法值：{sorted(GATE_STATUS)}", errors)

    # 5. output_artifacts
    oarts = data.get("output_artifacts")
    if oarts is not None:
        if not isinstance(oarts, list):
            err(name, "output_artifacts 必须是 list", errors)
        else:
            for i, a in enumerate(oarts):
                if not isinstance(a, dict):
                    err(name, f"output_artifacts[{i}] 必须是 dict", errors)
                else:
                    for k in ("name", "path", "version"):
                        if k not in a:
                            err(name, f"output_artifacts[{i}] 缺少 `{k}`", errors)

    # 6. loop_signs
    ls = data.get("loop_signs")
    if ls is not None:
        if not isinstance(ls, list):
            err(name, "loop_signs 必须是 list", errors)
        else:
            for i, s in enumerate(ls):
                if not isinstance(s, dict):
                    err(name, f"loop_signs[{i}] 必须是 dict", errors)
                    continue
                it = s.get("iterations")
                if isinstance(it, int) and it > 5:
                    err(name, f"loop_signs[{i}].iterations={it} 超阈值（≤5，超出升级）", errors)
                if s.get("exit_met") is not True:
                    err(name, f"loop_signs[{i}].exit_met 必须为 true", errors)
                if s.get("reflect_passed") is not True:
                    err(name, f"loop_signs[{i}].reflect_passed 必须为 true", errors)
                stg = s.get("stage")
                if stg and stg not in STAGE_ALIASES:
                    err(name, f"loop_signs[{i}].stage=`{stg}` 非法", errors)

    # 7. handoff role
    ho = data.get("handoff")
    if ho is not None:
        if not isinstance(ho, dict):
            err(name, "handoff 必须是 dict", errors)
        else:
            for k in ("to_role", "from_role"):
                if k not in ho:
                    err(name, f"handoff.{k} 必填", errors)

    # 8. hitl_signature
    hs = data.get("hitl_signature")
    if hs is not None:
        if not isinstance(hs, dict):
            err(name, "hitl_signature 必须是 dict", errors)
        else:
            mode = hs.get("mode")
            if mode and mode not in HITL_MODE:
                err(name, f"hitl_signature.mode=`{mode}` 非法（In/On/Fallback）", errors)
            ap = hs.get("approved_by")
            if ap is not None:
                if not isinstance(ap, list) or len(ap) == 0:
                    err(name, "hitl_signature.approved_by 必须是非空 list", errors)
                else:
                    for j, m in enumerate(ap):
                        if not isinstance(m, dict):
                            err(name, f"approved_by[{j}] 必须是 dict", errors)
                        else:
                            for k in ("role", "name", "timestamp"):
                                if k not in m:
                                    err(name, f"approved_by[{j}] 缺少 `{k}`", errors)


def validate_file(filepath):
    errors = []
    try:
        with open(filepath, "r", encoding="utf-8") as f:
            content = f.read()
    except Exception as e:
        return [f"读取失败：{e}"]

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

    if isinstance(data, dict) and "handoff" in data:
        validate_one(filepath, data["handoff"], errors)
    elif isinstance(data, dict):
        # 容错：直接以 handoff 字段集为顶层
        if "from_stage" in data or "to_stage" in data:
            validate_one(filepath, data, errors)
        else:
            errors.append(f"{filepath}: 未找到 `handoff` 顶层 key")
    else:
        errors.append(f"{filepath}: 顶层必须是 dict")

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
    for fp in files:
        errs = validate_file(fp)
        if errs:
            total_errors += len(errs)
            print(f"[FAIL] {fp}")
            for e in errs:
                print(f"   {e}")
        else:
            print(f"[OK]   {fp}")

    print("\n" + "=" * 50)
    if total_errors == 0:
        print(f"PASS: all {len(files)} file(s) valid")
        return 0
    else:
        print(f"FAIL: {total_errors} error(s) across {len(files)} file(s)")
        return 3

sys.exit(main())
PYEOF

if [[ $BATCH_MODE -eq 1 ]]; then
  python3 -c "$PY_VALIDATE" "$TARGET" "batch"
else
  python3 -c "$PY_VALIDATE" "$TARGET" "single"
fi
