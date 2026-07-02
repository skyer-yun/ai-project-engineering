# Codex 适配指南

> **定位**：把 [01-标准层/](../01-标准层/) + [02-产物层/](../02-产物层/) 的契约落地到 OpenAI **Codex / GPT 工具链** 运行时。
>
> Codex 系（Codex CLI、GitHub Copilot Workspace、GPT-5 工程模式）通过 `AGENTS.md` + 工程文件约定接入本体系。

---

## 一、Codex 与体系契约的映射

| 体系契约 | Codex 落地形态 |
|----------|---------------|
| **5 角色 Playbook** | 5 份 `AGENTS.md`（Spec-Writer/Builder/Reviewer/Shipper/Keeper） |
| **DSBL 五阶段产物** | `AGENTS.md` 引用 [02-产物层/](../02-产物层/) 模板路径 |
| **Loop 微循环（P/A/O/R/E）** | `AGENTS.md` workflow 节 + Copilot Workspace 的 Plan/Apply 双态 |
| **质量门禁 QG-D/S/B/Ship** | `AGENTS.md` checklist + 工程 CI 关卡 |
| **阶段交接契约 YAML** | `handoff.yaml` 提交到 git，下游 agent 解析 |
| **HITL In/On/Fallback** | Copilot Workspace Plan 模式 = In；Diff 评审 = On；Apply = Fallback |
| **上下文工程四原则** | Context window 管理 = Select/Compress；多 Agent 隔离 = Isolate |

---

## 二、部署清单

```bash
./install.sh --adapter codex
```

产物（在项目根目录）：

```
项目根/
├── AGENTS.md                     # 主入口（5 角色路由）
├── .codex/
│   ├── roles/
│   │   ├── spec-writer.md        # D + S 前半
│   │   ├── builder.md            # S 后半 + B
│   │   ├── reviewer.md           # 跨阶段
│   │   ├── shipper.md            # Ship
│   │   └── keeper.md             # 全程 + L
│   ├── workflows/                # DSBL 各阶段 workflow
│   └── handoff-template.yaml     # 交接契约模板（工具中立）
└── 项目文档/{项目}/              # 产物输出目录
```

> **不部署**：参考实现 copilot/skills 不自动部署到 Codex（Codex 用 AGENTS.md 约定而非 skill 包）。如需迁移 [06-参考实现/](../06-参考实现/) 的 18 skills，按本指南 §四 自行转换。

---

## 三、AGENTS.md 主入口模板

```markdown
# AGENTS.md — 本项目的 AI 协作约定

## 强制契约（来自 ai-project-engineering 体系）

- 阶段定义：见 01-标准层/01-DSBL五阶段定义.md
- Loop 微循环：见 01-标准层/02-Loop微循环规范.md
- 质量门禁：见 01-标准层/03-质量门禁QG-D至QG-Ship.md
- 交接契约：见 01-标准层/04-阶段交接契约Schema.md
- HITL 规则：见 03-执行层/03-HITL规则表.md

## 角色路由

| 用户意图 | 切换到角色 | 加载 |
|---------|----------|------|
| 需求 / 方案 / PRD | Spec-Writer | .codex/roles/spec-writer.md |
| 架构 / 详设 / 编码 / 审查 | Builder | .codex/roles/builder.md |
| 质量门禁 / 评审 | Reviewer | .codex/roles/reviewer.md |
| 测试 / 部署 / 验收 / 培训 | Shipper | .codex/roles/shipper.md |
| 项目管理 / 复盘 / 知识沉淀 | Keeper | .codex/roles/keeper.md |

## 阶段切换规则

每完成一个 DSBL 阶段，必须：
1. 跑对应 QG checklist（D/S/B/Ship）
2. 写 handoff.yaml（schema 见 01-标准层/04）
3. 提交到 git，通知下游角色加载

## HITL 强制点

- D 阶段（需求共识）：L3 不可逆 → HITL-In（Plan 模式 + 人审）
- S 阶段（方案/架构）：L3 → HITL-In
- Ship 阶段（生产部署）：L4 → HITL-In + 多人签
```

---

## 四、把参考实现 skills 迁移到 Codex

[06-参考实现/skills/](../06-参考实现/skills/) 的 18 个 skill 是 Claude-Code 格式（`skill.md` + 引用链）。迁到 Codex 的做法：

| Claude-Code skill 元素 | Codex 对应 |
|----------------------|-----------|
| `skill.md` 主体 | 转 `AGENTS.md` 的 §节 或 `.codex/workflows/{name}.md` |
| `triggers.md` | AGENTS.md 角色路由表（语义匹配优先） |
| `references/*.md` | `.codex/references/*.md`（直接复制，路径不变） |
| 调用其他 skill | 在 AGENTS.md 用「@加载 .codex/workflows/x.md」 |

**关键**：Codex 没有 skill 包概念，靠 AGENTS.md 约定 + 工程目录约定。模板（[02-产物层/](../02-产物层/)）和 schema（[01-标准层/](../01-标准层/)）原样可用，只是入口形式不同。

---

## 五、典型 DSBL × Codex 工作流

### D-Discover

```
用户对 Codex：「按 .codex/roles/spec-writer.md 起草需求分析」
  ↓
Codex 加载 spec-writer.md → 读 02-产物层/D-Discover/需求分析报告模板.md
  ↓
Plan 模式起草大纲 → 人审（Copilot Workspace Plan）
  ↓
Apply 填充 → Eval（requirement_completeness ≥ 0.9）
  ↓
写 handoff.yaml（from_stage=D, to_stage=S, QG-D=passed）
```

### B-Build

```
Codex 按 .codex/roles/builder.md
  ↓
关键模块 Plan 模式（HITL-In）；CRUD Fallback 自动
  ↓
拉起 reviewer.md（跨阶段）跑四维审查
  ↓
单测 ≥80% + lint 零严重
  ↓
handoff.yaml（from_stage=B, to_stage=Ship, QG-B=passed）
```

### Ship

```
shipper.md + CI/CD 关卡
  ↓
生产部署 L4 → HITL-In + 多人签
  ↓
handoff.yaml（from_stage=Ship, to_stage=L, QG-Ship=passed）
```

---

## 六、与 Claude-Code 适配的差异点

| 维度 | Claude-Code | Codex |
|------|------------|-------|
| 入口形式 | Skill 包（skill.md） | AGENTS.md + 工程目录约定 |
| Plan 审批 | 原生 Plan Mode + ExitPlanMode | Copilot Workspace Plan/Apply |
| 角色切换 | 会话内自然语言切 | AGENTS.md 路由表 + 加载子文件 |
| Skill 调用 | Skill Tool 原生 | @include 文件引用 |
| 部署目标 | `~/.claude/skills/` | 项目根 `.codex/` |

**相同点**：体系标准层和产物层模板完全通用，无需改动。

---

## 七、常见问题

**Q：Codex 没有原生 Plan Mode 怎么办？**
A：用 Copilot Workspace 的 Plan/Apply 双态；或约定「AI 起草 → 人 git diff 评审 → AI 执行」的等效流程。HITL-In 是契约，不是工具特性。

**Q：能否只用 GitHub Copilot 不装 Codex CLI？**
A：可以。Copilot Chat 也读 AGENTS.md。能力稍弱（无 workflow 文件加载），但模板填充够用。

**Q：18 skills 是否必须迁移？**
A：不。最小化部署只写 AGENTS.md 主入口 + 5 角色 md，靠 Codex 原生能力读模板。

---

*本指南是 Codex 落地参考。体系标准以 [01-标准层/](../01-标准层/) 为权威源。*
