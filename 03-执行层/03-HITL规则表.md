# HITL 规则表

> **定位**：本文件是「DSBL × HITL × 不可逆 × 角色」交叉权威表。结合 [00-理论层/03-HITL模式与不可逆性矩阵.md](../00-理论层/03-HITL模式与不可逆性矩阵.md)（原理）和 [01-标准层/01-DSBL五阶段定义.md](../01-标准层/01-DSBL五阶段定义.md)（阶段定义），给出落地查表。
>
> **用途**：项目启动时按此表为每个阶段分配 HITL 模式 + 不可逆等级 + 主责角色。

---

## 一、交叉矩阵（DSBL × HITL × 不可逆 × 角色）

| 阶段 | 主责角色 | 协作角色 | HITL 模式 | 不可逆等级 | Plan Mode | Checkpoint | 必签角色 |
|------|---------|---------|----------|-----------|----------|-----------|---------|
| **D**-Discover | Spec-Writer | Keeper | **In** | L3 | 推荐 | 文档版本 | 客户代表 + Spec-Writer + Keeper |
| **S**-Spec（前半：方案/PRD） | Spec-Writer | Builder + Reviewer | **In** | L3 | **强制**（PRD 大纲） | 文档版本 | Spec-Writer + Builder + Reviewer |
| **S**-Spec（后半：架构/详设） | Builder | Spec-Writer + Reviewer | **In** | L3 | **强制**（章节大纲） | Git commit + ADR | Builder + Reviewer |
| **B**-Build（关键模块） | Builder | Reviewer | **In** | L2 | **强制**（文件改动+单测计划） | atomic commit | Builder + Reviewer |
| **B**-Build（一般模块/CRUD） | Builder | — | **Fallback** | L1 | 推荐 | atomic commit | Reviewer 抽检 |
| **Ship**-测试策略 | Shipper | Reviewer | **On** | L2 | 推荐 | 测试基线 | Shipper + Reviewer |
| **Ship**-测试执行 | Shipper | Reviewer | **On + Fallback**（自动 F，手动 On） | L1 | — | 测试报告版本 | Shipper |
| **Ship**-部署（生产） | Shipper | Reviewer + 客户 | **In** | **L4** | **强制**（步骤+回滚预案） | **完整快照** | Shipper + Reviewer + **客户签字** |
| **Ship**-验收交付 | Shipper | 客户 + Keeper | **In** | **L4** | 推荐 | 验收报告版本 | Shipper + **客户签字** + Keeper |
| **Ship**-培训移交 | Shipper | 客户 | **On** | L2 | — | 培训材料版本 | Shipper + 客户反馈 |
| **L**-Learn | Keeper | 全角色 | **In** | L3 | 推荐 | 复盘报告版本 | Keeper + 各角色代表 |

---

## 二、查表规则

### 2.1 怎么用这张表

1. **识别当前阶段**：DSBL 五阶段之一。
2. **看子任务**：如 B 阶段要区分"关键模块"还是"CRUD"。
3. **取 HITL 模式**：In / On / Fallback 之一。
4. **取不可逆等级**：L1-L4，决定回滚成本。
5. **取必签角色**：阶段 Exit 时必须有这些角色的签名。

### 2.2 HITL 模式决策树

```
任务进入
   ↓
是客户面向或不可逆？ ──── 是 ──→ In（必须审批）
   │ 否
   ↓
是中风险可回滚？ ──────── 是 ──→ On（监督可回滚）
   │ 否
   ↓
是低风险完全可逆？ ────── 是 ──→ Fallback（自动+兜底）
   │ 否
   ↓
不确定 → 默认 In（保守原则）
```

### 2.3 Plan Mode 强制场景汇总

- D 阶段：需求面访大纲
- S 阶段前半：PRD 12 部分大纲 + 用户故事
- S 阶段后半：架构章节 + 详细设计章节
- B 阶段关键模块：文件改动 + 单测计划
- Ship 阶段部署：步骤 + 回滚预案
- L 阶段：复盘维度大纲

---

## 三、按角色视角的 HITL 速查

### Spec-Writer

| 阶段 | HITL | 关键动作 |
|------|------|---------|
| D（主） | In | 面访 / 整理 / 客户确认 |
| S 前半（主） | In | 方案 / PRD 评审 |

### Builder

| 阶段 | HITL | 关键动作 |
|------|------|---------|
| S 后半（主） | In | 架构 / 详设评审 |
| B 关键模块 | In | Plan Mode + atomic commit |
| B 一般模块 | Fallback | AI 自动 + 抽检 |

### Reviewer

| 阶段 | HITL | 关键动作 |
|------|------|---------|
| S | In | 方案/架构/详设评审会签 |
| B | In | PR Review diff |
| Ship | In | 测试评审 / 部署审批 |

### Shipper

| 阶段 | HITL | 关键动作 |
|------|------|---------|
| Ship 测试 | On + Fallback | 自动+手动 |
| Ship 部署 | **In（L4）** | 完整快照 + 业务签字 |
| Ship 验收 | **In（L4）** | 客户签字 |

### Keeper

| 阶段 | HITL | 关键动作 |
|------|------|---------|
| 全程 | 监督 | 契约守护 + 上下文治理 |
| L（主） | In | 复盘报告 + 改进项录入 |

---

## 四、违反规则的常见错误

| 错误 | 后果 | 正解 |
|------|------|------|
| 用 Fallback 跑 Ship 部署 | 生产事故无人审 | Ship 部署强制 In + 完整快照 |
| 用 On 跑 S 架构评审 | 架构定稿后发现方向错 | S 后半强制 In + 评审会签字 |
| 不打 Checkpoint 就改 B 代码 | AI 写错无法回滚 | B 阶段每次 atomic commit 前 snapshot |
| L 阶段用 Fallback 自动生成复盘 | 复盘流于形式 | L 强制 In + 多角色参与 |
| 一个角色全程用同一 HITL 模式 | 关键点失守或低效 | 按阶段/子任务切换模式 |

---

## 五、与 Plan Mode 的工具映射

> 工具中立：下表是参考映射，具体工具的 Plan Mode 实现见 [05-适配层/](../05-适配层/)。

| AI 工具 | Plan Mode 形态 |
|---------|--------------|
| Claude Code | Plan Mode + ExitPlanMode Hook |
| Codex | Review Mode |
| Cursor | Composer Preview |
| WorkBuddy | Draft Mode |
| 自带工具 | 见 [05-适配层/自带工具适配指南.md](../05-适配层/自带工具适配指南.md) |

---

*本文件是「DSBL × HITL × 不可逆 × 角色」交叉表的**唯一权威源**。其他位置涉及具体 HITL 标注时请引用本文件。*
