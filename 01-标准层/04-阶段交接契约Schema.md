# 阶段交接契约 Schema

> **定位**：本文件是「阶段间交接契约 YAML Schema」的**唯一权威源**。每个 QG 通过后必须生成此契约，下游阶段读取契约方可启动。
>
> **关联**：QG 门禁见 [03-质量门禁QG-需求至QG-交付.md](./03-质量门禁QG-需求至QG-交付.md)；Loop 签名见 [02-Loop微循环规范.md](./02-Loop微循环规范.md)。
>
> **命名说明**：YAML 字段值 `from_stage`/`to_stage` 使用内部代号 **D/S/B/Ship/L**（分别对应 需求/设计/开发/交付/复盘），简洁且校验工具稳定；中文别名作兼容值。

---

## 一、设计目标

契约是阶段流转的**单一真相源**，解决三类问题：

1. **下游启动条件**：下游不读上游聊天记录，只读契约。
2. **责任追溯**：每份产物有具名责任人 + 时间戳。
3. **工具中立**：契约只描述产物/状态/签名，不依赖具体 AI 工具。

---

## 二、Schema 完整定义

```yaml
# 阶段交接契约 v1.0
# 上游阶段 Exit-Pass 后生成，下游阶段启动前校验

handoff:
  # —— 基础元信息 ——
  schema_version: "1.0"
  project: "{项目名}"
  project_code: "{项目代号}"
  generated_at: "2026-07-01T10:00:00+08:00"
  generated_by: "{生成者，工具中立：人名/AI 工具名}"

  # —— 阶段流转（内部代号：D=需求 / S=设计 / B=开发 / Ship=交付 / L=复盘）——
  from_stage: D              # D / S / B / Ship / L
  to_stage: S
  quality_gate: QG-D         # QG-D=QG-需求 / QG-S=QG-设计 / QG-B=QG-开发 / QG-Ship=QG-交付
  gate_status: passed        # passed / failed / escalated

  # —— 输出产物（工具中立：只描述，不绑工具）——
  output_artifacts:
    - name: "需求分析报告"
      path: "项目文档/{项目}/需求/需求分析报告-v1.0.md"
      version: "v1.0"
      hash: "sha256:..."     # 可选，用于完整性校验
    - name: "干系人清单"
      path: "项目文档/{项目}/需求/干系人清单-v1.0.md"
      version: "v1.0"

  # —— Loop 签名链（阶段内微循环记录）——
  loop_signs:
    - stage: D               # 内部代号；中文别名"需求"等价
      iterations: 3
      final_eval:
        requirement_completeness: 0.92
        scenario_coverage: 0.96
        stakeholder_signed: 1.0
      reflect_passed: true
      exit_met: true

  # —— 逻辑角色交接（签字用，工种映射见 01-五阶段定义.md）——
  handoff:
    to_role: "Builder"       # Spec-Writer / Builder / Reviewer / Shipper / Keeper 之一
    from_role: "Spec-Writer"

  # —— 工具记录（中立：用了什么，但 schema 不依赖）——
  tool_used:
    primary: "Claude Code"   # 可为 Codex / Cursor / WorkBuddy / 自带 / 人工
    adapter: "Claude-Code"   # 对应 05-适配层/ 的方案名
    notes: "可选说明"

  # —— HITL 签名 ——
  hitl_signature:
    mode: "In"               # In / On / Fallback
    irreversibility: L3      # L1-L4 不可逆等级
    approved_by:
      - {role: "客户代表", name: "张三", timestamp: "2026-07-01T10:00:00+08:00"}
      - {role: "Spec-Writer", name: "李四", timestamp: "2026-07-01T09:50:00+08:00"}
      - {role: "Keeper", name: "王五", timestamp: "2026-07-01T10:05:00+08:00"}

  # —— 风险与备注 ——
  risk_flags: []
  notes: "可选说明文字"
```

---

## 三、字段语义

### 3.1 阶段字段

| 字段 | 取值 | 说明 |
|------|------|------|
| `from_stage` | D/S/B/Ship/L | 上游阶段代号（D=需求 / S=设计 / B=开发 / Ship=交付 / L=复盘） |
| `to_stage` | D/S/B/Ship/L | 下游阶段名（顺序原则：需求→设计→开发→交付→复盘） |
| `quality_gate` | QG-D/QG-S/QG-B/QG-Ship | 对应门禁（中文名：QG-需求/QG-设计/QG-开发/QG-交付） |
| `gate_status` | passed/failed/escalated | 门禁状态 |

### 3.2 产物字段

- `output_artifacts` 是**数组**，列出本阶段全部输出产物。
- 每个 `artifact` 必含 `name` / `path` / `version`；`hash` 可选（建议关键产物加）。
- `path` 用相对路径，相对项目根目录。

### 3.3 Loop 签名字段

- `loop_signs` 是阶段内 Loop 微循环的签名链。
- 必含 `iterations`（次数）/ `final_eval`（关键指标）/ `reflect_passed` / `exit_met`。
- 阈值参考 [06-产物质量硬指标库.md](./06-产物质量硬指标库.md)。

### 3.4 角色字段

- `to_role` / `from_role` 取方法论逻辑层 5 角色之一：Spec-Writer（需求规范师）/ Builder（构建师）/ Reviewer（审查师）/ Shipper（交付师）/ Keeper（统筹师）。
- 角色与工具/工种解耦——具体的 AI 工具/人记录在 `tool_used`，工种映射见 [01-五阶段定义.md](./01-五阶段定义.md)。

### 3.5 HITL 签名字段

- `mode`：In（人在回路必审）/ On（人按需介入）/ Fallback（AI 自动+抽检）。
- `irreversibility`：L1（可逆）/ L2（轻损）/ L3（重损）/ L4（不可逆，如生产部署）。
- `approved_by` 是具名签名清单，必含 `role` / `name` / `timestamp`。

---

## 四、下游读取规则

下游阶段启动前，必须用 [validate-handoff.sh](../04-工具层/04-交接契约工具/) 校验契约：

| 校验项 | 规则 |
|--------|------|
| `gate_status` | 必须 = `passed` |
| `exit_met` | 所有 loop_sign 必须为 true |
| 关键 Eval | 全部高于阈值（阈值见 [06-产物质量硬指标库.md](./06-产物质量硬指标库.md)） |
| `iterations` | ≤5（超出升级） |
| `reflect_passed` | 必须 true |
| `approved_by` | 必须齐全（按阶段要求的最少签名数） |
| `output_artifacts` | path 必须存在且 hash 一致（如填了） |

任一不过 → 下游拒绝启动，回报"上游契约校验失败"。

---

## 五、契约归档

- 契约文件命名：`handoff-{from}-{to}-v{N}.{ext}`，如 `handoff-D-S-v1.0.yaml`。
- 归档目录：`项目文档/{项目}/_handoffs/`。
- 每个阶段可有多版本契约（v1.0 / v1.1 / v2.0），下游以最新版本为准。

---

## 六、契约修改与版本化

- 契约一旦签署，禁止静默修改——修改必须重新签 QG + 新版本号。
- Schema 自身版本化为 `schema_version`（当前 1.0），未来扩展向后兼容。

---

## 七、最小可用示例（参考）

详见 [04-工具层/04-交接契约工具/examples/](../04-工具层/04-交接契约工具/) 下的示例 YAML。
