# 交接契约工具

> **用途**：阶段交接契约 YAML 校验
> **协议权威源**：[01-标准层/04-阶段交接契约Schema.md](../../01-标准层/04-阶段交接契约Schema.md)

---

## 文件清单

| 文件 | 用途 |
|------|------|
| `signature-template.yaml` | DSBL 五阶段标准模板（含完整示例） |
| `validate-handoff.sh` | YAML 校验工具（必填字段 / 类型 / 合法值 / 下游读取规则） |
| `examples/good-D-to-S.yaml` | 合法示例（D→S 交接，通过校验） |
| `examples/bad-missing-fields.yaml` | 非法示例（缺字段 + 类型错） |
| `examples/bad-invalid-values.yaml` | 非法示例（阶段名/角色非法值） |

---

## 快速上手

### 1. 拷贝模板

```bash
cp 04-工具层/04-交接契约工具/signature-template.yaml \
   项目文档/{项目}/_handoffs/handoff-D-S-v1.0.yaml
```

### 2. 填写关键字段

```yaml
handoff:
  schema_version: "1.0"
  project: "{项目名}"
  generated_at: "2026-07-10T16:00:00+08:00"
  generated_by: "李四"

  from_stage: D
  to_stage: S
  quality_gate: QG-D
  gate_status: passed

  output_artifacts:
    - name: "需求分析报告"
      path: "项目文档/{项目}/D-Discover/需求分析报告-v1.0.md"
      version: "v1.0"

  loop_signs:
    - stage: D
      iterations: 3
      final_eval: {requirement_completeness: 0.92}
      reflect_passed: true
      exit_met: true

  handoff:
    to_role: "Builder"
    from_role: "Spec-Writer"

  tool_used:
    primary: "Claude Code"
    adapter: "Claude-Code"

  hitl_signature:
    mode: "In"
    irreversibility: L3
    approved_by:
      - {role: "客户代表", name: "张三", timestamp: "2026-07-01T10:00:00+08:00"}

  risk_flags: []
  notes: ""
```

### 3. 校验

```bash
./04-工具层/04-交接契约工具/validate-handoff.sh \
   项目文档/{项目}/_handoffs/handoff-D-S-v1.0.yaml
```

预期输出：`[OK] ... PASS: all 1 file(s) valid`

### 4. 批量校验

```bash
./04-工具层/04-交接契约工具/validate-handoff.sh --batch \
   项目文档/{项目}/_handoffs/
```

---

## 校验规则（下游读取规则）

### 必填字段

| 字段 | 类型 | 说明 |
|------|------|------|
| `schema_version` | string | 当前 "1.0" |
| `from_stage` / `to_stage` | enum | D / S / B / Ship / L |
| `quality_gate` | enum | QG-D / QG-S / QG-B / QG-Ship（L 无） |
| `gate_status` | enum | passed / failed / escalated |
| `output_artifacts` | list | 含 name/path/version |
| `loop_signs` | list | 含 iterations/final_eval/reflect_passed/exit_met |
| `handoff.from_role` / `to_role` | enum | Spec-Writer / Builder / Reviewer / Shipper / Keeper |
| `hitl_signature.mode` | enum | In / On / Fallback |
| `hitl_signature.irreversibility` | enum | L1 / L2 / L3 / L4 |
| `hitl_signature.approved_by` | list | 含 role/name/timestamp |

### 下游启动校验规则

- `gate_status` 必须 = `passed`
- 所有 `loop_signs[].exit_met` = true
- 关键 Eval 高于阈值（详见 [06-产物质量硬指标库.md](../../01-标准层/06-产物质量硬指标库.md)）
- `iterations` ≤ 5（超出升级）
- 所有 `reflect_passed` = true
- `approved_by` 齐全（按阶段要求的最少签名数）

### 合法值范围

| 字段 | 合法值 |
|------|--------|
| `from_stage` / `to_stage` | D / S / B / Ship / L |
| `quality_gate` | QG-D / QG-S / QG-B / QG-Ship |
| `from_role` / `to_role` | Spec-Writer / Builder / Reviewer / Shipper / Keeper |
| `mode` | In / On / Fallback |
| `irreversibility` | L1 / L2 / L3 / L4 |

---

## 五阶段交接路径

| # | 上游 → 下游 | 阶段交接 | 关键 Eval | 必签角色 |
|---|------------|----------|----------|---------|
| 1 | 外部 → Spec-Writer | → D | — | 客户代表 |
| 2 | Spec-Writer → Builder | D → S | requirement_completeness / scenario_coverage | Spec-Writer + 客户 + Keeper |
| 3 | Builder（自循环 S） | S（前→后） | prd_completeness / arch_4view | Spec-Writer + Builder + Reviewer |
| 4 | Builder → Shipper | B → Ship | unit_coverage / integration_pass_rate | Builder + Reviewer |
| 5 | Shipper → Keeper | Ship → L | case_pass_rate / p0_p1=0 / acceptance_pass | Shipper + Reviewer + **客户** |
| 6 | Keeper 归档 | L → 终态 | archive_completeness | Keeper + 各角色代表 |

---

## 工具中立声明

本工具不绑定具体 AI 工具。`tool_used.primary` / `tool_used.adapter` 字段允许填任意工具名（Claude Code / Codex / Cursor / WorkBuddy / 自带 / 人工），仅作为记录，不影响校验。

---

## 与项目文档集成

推荐目录结构：

```
项目文档/{项目}/
├── D-Discover/
├── S-Spec/
├── B-Build/
├── S-Ship/
├── L-Learn/
└── _handoffs/                    # ⭐ 全周期交接契约链
    ├── handoff-D-S-v1.0.yaml
    ├── handoff-S-B-v1.0.yaml
    ├── handoff-B-Ship-v1.0.yaml
    ├── handoff-Ship-L-v1.0.yaml
    └── handoff-L-archive-v1.0.yaml
```

**回溯链路**：当 Ship 部署失败时，按 Ship→B→S→D 反向查交接契约，定位是哪个阶段引入的问题。

---

## FAQ

**Q: 一份 YAML 多个 handoff 可以吗？**
A: 不可以。一份契约 = 一次阶段交接。多个交接需多个文件，用 `from-to-version` 区分。

**Q: yaml 解析报错 "expected <block end>, found '?'"**
A: 文件含 tab 缩进或非法字符。YAML 只允许空格缩进。

**Q: 校验工具报"缺少 PyYAML"**
A: 安装依赖：`pip install pyyaml`

**Q: 如何添加自定义校验规则？**
A: 编辑 `validate-handoff.sh` 内嵌的 Python 代码，扩展 `validate_handoff()` 函数。

**Q: 工具中立怎么体现？**
A: 校验只看 `from_stage`/`to_stage`/`gate_status`/`exit_met` 等阶段字段，不看 `tool_used.primary`——任何 AI 工具产出的契约都按同一规则校验。

---

## 变更记录

| 版本 | 日期 | 变更内容 |
|------|------|---------|
| v1.0 | | 初版：DSBL 五阶段 + 工具中立校验 |

---

*本工具是交接契约 Schema 的落地实现。配合 [04-工具层/03-Checkpoint脚本/](../03-Checkpoint脚本/) 一起使用。*
