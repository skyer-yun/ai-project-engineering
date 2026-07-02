# Builder 角色 Playbook

> **目标读者**：研发工程师 / 技术架构师 / 全栈开发
> **主责阶段**：S-Spec 后半（架构/详设，主） + B-Build（主）
> **业界锚点**：Anthropic *Building Effective Agents* / Spec-Driven Development / Context Engineering 四原则 / atomic commit + Plan Mode
> **工具中立**：Claude Code / Codex / Cursor / 自带工具均可，详见 [05-适配层/](../../05-适配层/)。

---

## 一、角色定位

Builder 是「规范→可运行代码」的转化者。承担原研发职责：
- 架构设计（S 后半）
- 详细设计（S 后半）
- 编码实现（B）
- 代码审查（B，作为 Reviewer 协作）
- 联调集成（B）

**核心信念**：规范的精确度决定代码质量。S 阶段没写清楚的需求，B 阶段 AI 写出来必然翻车。

---

## 二、权威源

- 阶段定义：[01-标准层/01-DSBL五阶段定义.md](../../01-标准层/01-DSBL五阶段定义.md)
- Loop 微循环：[01-标准层/02-Loop微循环规范.md](../../01-标准层/02-Loop微循环规范.md)
- 质量门禁：[01-标准层/03-质量门禁QG-D至QG-Ship.md](../../01-标准层/03-质量门禁QG-D至QG-Ship.md)（QG-S 后半 + QG-B 主责）
- HITL 模式：[03-执行层/03-HITL规则表.md](../03-HITL规则表.md)
- 工具：[04-工具层/](../../04-工具层/)（素养/看板/Checkpoint）
- 产物模板：[02-产物层/S-Spec/架构/详设](../../02-产物层/S-Spec/) + [02-产物层/B-Build/](../../02-产物层/B-Build/)

---

## 三、触发语

| # | 触发语 | 阶段 | 期望产物 |
|---|--------|------|---------|
| 1 | 「设计架构」 | S 后半 | 架构设计文档（C4 四视图）+ ADR |
| 2 | 「写详细设计」 | S 后半 | 详设文档 + OpenAPI |
| 3 | 「实现这个模块」 | B | 源码 + 单测 + atomic commit |
| 4 | 「重构这个模块」 | B | 重构方案 + 新代码 + diff |
| 5 | 「联调接口」 | B | 集成测试报告 + API 文档 |
| 6 | 「根据 PRD 做架构」 | S | 架构设计文档（含选型） |

---

## 四、DSBL 阶段覆盖 + HITL 模式

| 阶段 | HITL | 核心动作 |
|------|------|---------|
| **S** 后半（架构/详设，主） | **In** | 架构评审、详设评审、ADR 决策 |
| **B** 关键模块编码（主） | **In** | Plan Mode + atomic commit + 资深 review |
| **B** 一般模块/CRUD（主） | **Fallback** | AI 自动 + Reviewer 抽检 |
| **B** 联调集成（主） | **On** | 开发+测试联合评审 |
| Ship | 协作 | 配合部署、修复生产 bug |

---

## 五、Loop 5 字段（Builder 版）

```yaml
loop:
  goal: "将可执行规范 → 可测试、可部署、可维护的源代码"
  context: |
    上游：技术方案 + PRD + UI-UX + 客户约束
    工程约束：技术栈 / deadline / 安全合规
  tools:
    - 任意 AI 工具（Claude Code / Codex / Cursor 等）
    - Plan Mode（关键模块先 plan 后 act）
    - Git atomic commit（每特性一个 commit，可 /undo 回滚）
    - Jest/Vitest（单测）/ ESLint/SonarQube（静态分析）
    - OpenAPI Generator（接口文档自动化）
  checkpoint: "每特性编码完成 → 单测覆盖达标 + lint 清零 → atomic commit"
  exit: "集成测试通过率 ≥ 95% + API 文档齐全 → 提测 → 交接 Shipper"
```

**B 阶段编码详细 Loop**（最密集的节点，每特性一次完整循环）：

```
Plan     → Plan Mode：文件改动清单 + 依赖分析 + 单测目标
Act      → AI 主导编码（关键模块人审，CRUD 自动）
Observe  → 单测覆盖率 ≥80% 行 / ≥70% 分支 + lint 严重=0 + 类型零错
Reflect  → 资深工程师（Reviewer）审 diff（架构性 / 安全 / 性能）
Exit     → Reviewer 通过 + atomic commit → 下一特性
```

---

## 六、产物清单与模板

| 阶段 | 产物 | 模板路径 |
|------|------|---------|
| S 后半 | 架构设计 | [02-产物层/S-Spec/架构设计模板.md](../../02-产物层/S-Spec/架构设计模板.md) |
| S 后半 | 详细设计 | [02-产物层/S-Spec/详细设计模板.md](../../02-产物层/S-Spec/详细设计模板.md) |
| S 后半 | ADR | 工件演化层（项目目录） |
| B | 源代码 | Git |
| B | 单元测试 | Git（同 repo） |
| B | 接口文档 | Git（OpenAPI） |
| B | 联调报告 | [02-产物层/B-Build/代码工程化规范.md](../../02-产物层/B-Build/代码工程化规范.md) |

---

## 七、Plan Mode 强制场景

| 场景 | 强制要求 |
|------|---------|
| 关键模块编码（业务核心 / 安全 / 性能关键） | 先 Plan 列文件改动+单测计划，人审批后 Execute |
| 架构设计 | 先 Plan 列章节大纲，评审通过后写正文 |
| 数据库 schema 变更 | 先 Plan 列影响表 + 迁移脚本 |
| 部署脚本 | 先 Plan 列步骤 + 回滚预案 |

> Plan Mode 是工具中立概念——任何支持"先审后执行"的 AI 工具都可承担。

---

## 八、典型协作流

### 8.1 S → B 流（自循环）

```
Spec-Writer 完成 PRD + UI-UX → QG-S 前半通过
   ↓
Builder 接手 S 后半：架构设计 → 架构评审
   ↓
Builder 写详细设计 + OpenAPI → 详设评审
   ↓
QG-S 后半通过 → 签交接契约（自循环 S）
   ↓
Builder 进入 B 阶段：Plan → 编码 → Observe → Reflect → Exit
   ↓
QG-B 通过 → 签交接契约 B→Ship
```

### 8.2 与 Reviewer 协作

Reviewer 是 B 阶段的常驻审查者：
- 每个 PR 必须有 Reviewer 签字
- 关键模块 Reviewer 必须资深
- 一般模块 Reviewer 可抽检
- Reviewer 反馈通过 [工件演化层](../../01-标准层/05-工件演化与版本规范.md) 记录

### 8.3 与 Shipper 协作

B→Ship 交接：
- 提测前 P0/P1 缺陷必须清零（详见 [01-标准层/06-产物质量硬指标库.md](../../01-标准层/06-产物质量硬指标库.md)）
- 提供联调报告 + 接口文档
- 签交接契约 B→Ship

---

## 九、入场姿势

```
我是 Builder，正在处理 {项目名} 的 {S 后半|B} 阶段任务。
当前任务：{一句话描述，如"实现登录模块"}
上游产物：{QG-S 通过的交接契约路径 + 详设文档路径}
目标产物：{源码 / 单测 / 接口文档}
请按 Plan Mode 列改动清单后等我审批，再 Act 编码。
```

---

## 十、反模式

| 反模式 | 后果 | 正解 |
|--------|------|------|
| 跳过详设直接编码 | 接口不一致、返工 | S 后半必须详设完整 |
| 关键模块不 Plan Mode | AI 跑歪路 | 关键模块强制 Plan |
| 单测覆盖率不达标就提测 | 缺陷逃脱率高 | 强制 ≥80% 行覆盖 |
| 不打 atomic commit | AI 写错无法回滚 | 每特性一个 atomic commit |
| 提测前 P0/P1 未清零 | Ship 阶段灾难 | 提测前清零 |

---

## 十一、下一步阅读

- 业界依据：[00-理论层/02-业界共识与权威锚点.md](../../00-理论层/02-业界共识与权威锚点.md)
- HITL 选择：[03-执行层/03-HITL规则表.md](../03-HITL规则表.md)
- 选 AI 工具：[05-适配层/](../../05-适配层/)
- 参考样例：[06-参考实现/copilots/dev-copilot/](../../06-参考实现/copilots/dev-copilot/)

---

*本 Playbook 是 Builder 角色的**操作手册**。具体编码规范见 [02-产物层/B-Build/代码工程化规范.md](../../02-产物层/B-Build/代码工程化规范.md)。*
