# Cursor 适配指南

> **定位**：把 [01-标准层/](../01-标准层/) + [02-产物层/](../02-产物层/) 的契约落地到 **Cursor IDE** 运行时。
>
> Cursor 通过 `.cursorrules` + 工作区约定接入本体系，适合在 IDE 内高频编码场景下使用。

---

## 一、Cursor 与体系契约的映射

| 体系契约 | Cursor 落地形态 |
|----------|---------------|
| **5 角色 Playbook** | `.cursor/rules/{role}.mdc`（每角色一份规则文件） |
| **DSBL 五阶段产物** | `.cursorrules` 引用 [02-产物层/](../02-产物层/) 模板路径 |
| **Loop 微循环（P/A/O/R/E）** | Cursor Agent 模式 + 工作区 checklist 文件 |
| **质量门禁 QG-D/S/B/Ship** | `.cursor/rules/qg-{stage}.mdc` + Apply 前评审 |
| **阶段交接契约 YAML** | `handoff.yaml` 提交到 git 工作区 |
| **HITL In/On/Fallback** | Cursor Agent Plan Mode = In；Diff 评审 = On；Yolo 自动 = Fallback |
| **上下文工程四原则** | @file 引用 = Select；会话折叠 = Compress；多 chat = Isolate |

---

## 二、部署清单

```bash
./install.sh --adapter cursor
```

产物（在项目根目录）：

```
项目根/
├── .cursorrules                  # 主入口（路由 + 强制契约）
├── .cursor/
│   └── rules/
│       ├── spec-writer.mdc       # D + S 前半
│       ├── builder.mdc           # S 后半 + B
│       ├── reviewer.mdc          # 跨阶段审查
│       ├── shipper.mdc           # Ship
│       ├── keeper.mdc            # 全程 + L
│       ├── qg-d.mdc              # 质量门禁
│       ├── qg-s.mdc
│       ├── qg-b.mdc
│       └── qg-ship.mdc
├── handoff-template.yaml         # 交接契约模板
└── 项目文档/{项目}/              # 产物输出目录
```

> **不部署**：参考实现 copilot/skills 不自动部署到 Cursor（Cursor 用 .mdc 规则而非 skill 包）。如需迁移 [06-参考实现/](../06-参考实现/) 的 18 skills，按 §四 自行转换。

---

## 三、.cursorrules 主入口模板

```markdown
---
description: AI Project Engineering 体系协作约定
globs: ["项目文档/**", "src/**", "handoff.yaml"]
---

# 本项目的 AI 协作约定

## 强制契约（来自 ai-project-engineering 体系）

- 阶段定义：见 01-标准层/01-DSBL五阶段定义.md
- Loop 微循环：见 01-标准层/02-Loop微循环规范.md
- 质量门禁：见 01-标准层/03-质量门禁QG-D至QG-Ship.md
- 交接契约：见 01-标准层/04-阶段交接契约Schema.md
- HITL 规则：见 03-执行层/03-HITL规则表.md

## 角色路由（@加载对应 .mdc）

| 用户意图 | 切换角色 | 加载规则文件 |
|---------|---------|------------|
| 需求 / 方案 / PRD | Spec-Writer | @.cursor/rules/spec-writer.mdc |
| 架构 / 编码 / 审查 | Builder | @.cursor/rules/builder.mdc |
| 质量门禁 / 评审 | Reviewer | @.cursor/rules/reviewer.mdc |
| 测试 / 部署 / 验收 | Shipper | @.cursor/rules/shipper.mdc |
| 项目管理 / 复盘 | Keeper | @.cursor/rules/keeper.mdc |

## HITL 强制点（不可跳过）

- D 阶段需求共识：L3 → Cursor Agent Plan Mode + 人审
- S 阶段方案/架构：L3 → Plan + 人审
- Ship 阶段生产部署：L4 → Plan + 多人签

## 阶段切换规则

每完成一个 DSBL 阶段：
1. 跑对应 QG checklist（@.cursor/rules/qg-{stage}.mdc）
2. 写 handoff.yaml
3. git 提交，@加载下游角色规则
```

---

## 四、把参考实现 skills 迁移到 Cursor

[06-参考实现/skills/](../06-参考实现/skills/) 的 18 skill 是 Claude-Code 格式。迁到 Cursor 的做法：

| Claude-Code skill 元素 | Cursor 对应 |
|----------------------|-----------|
| `skill.md` 主体 | `.cursor/rules/{name}.mdc`（带 frontmatter） |
| `triggers.md` | `.mdc` 的 `globs` + `description` |
| `references/*.md` | 工作区 `.docs/references/*.md`（@引用） |
| 调用其他 skill | `.mdc` 内 `@.cursor/rules/x.mdc` |

**关键**：Cursor 用 glob 触发规则，而非语义匹配。把 skill 的触发关键词映射到文件路径 globs（如 PRD 模板触发的 glob 是 `项目文档/**/PRD*.md`）。

---

## 五、典型 DSBL × Cursor 工作流

### D-Discover

```
打开 Cursor → 新 chat
  ↓
「按 .cursor/rules/spec-writer.mdc 起草需求分析」
  ↓
Cursor 加载 spec-writer.mdc → 读 02-产物层/D-Discover/需求分析报告模板.md
  ↓
Agent Plan 模式起草大纲 → 人审 Apply
  ↓
Eval（requirement_completeness ≥ 0.9）
  ↓
写 handoff.yaml（from_stage=D, to_stage=S）
```

### B-Build（Cursor 强项）

```
Builder.mdc + 源码 globs
  ↓
关键模块：Cursor Agent Plan Mode（HITL-In）
样板代码：Cursor Tab 自动补全（Fallback）
  ↓
@.cursor/rules/reviewer.mdc 跑四维审查
  ↓
Cursor Terminal 跑单测（≥80% 行覆盖）
  ↓
handoff.yaml（from_stage=B, to_stage=Ship）
```

### Ship

```
shipper.mdc + 生产部署 L4 → HITL-In + 多人签
  ↓
handoff.yaml（from_stage=Ship, to_stage=L）
```

---

## 六、Cursor 特色能力与体系对齐

| Cursor 能力 | 体系对应 |
|------------|---------|
| **Cursor Tab 自动补全** | Fallback 模式（样板代码、CRUD） |
| **Agent 模式（Chat）** | Loop Act 阶段 |
| **Plan Mode（Agent）** | HITL-In + Loop Plan |
| **@file 引用** | 上下文 Select |
| **会话折叠** | 上下文 Compress |
| **多 chat 隔离** | 上下文 Isolate |
| **.mdc 规则自动加载** | 角色 Playbook 加载 |

---

## 七、与其他适配的差异点

| 维度 | Claude-Code | Codex | Cursor |
|------|------------|-------|--------|
| 入口形式 | Skill 包 | AGENTS.md | `.cursorrules` + `.mdc` |
| 触发机制 | 语义匹配 + 关键词 | AGENTS.md 路由 | glob + 语义 |
| 强项 | 全流程编排 | 工程化对话 | IDE 内编码 |
| 部署目标 | `~/.claude/skills/` | 项目根 `.codex/` | 项目根 `.cursor/` |
| Plan 审批 | Plan Mode | Workspace Plan | Agent Plan Mode |

**相同点**：体系标准层和产物层模板完全通用。

---

## 八、常见问题

**Q：Cursor 是否适合做 D/Ship 阶段？**
A：Cursor 强在 B 阶段（编码）。D（需求）和 Ship（部署）建议配合外部工具或 Claude-Code/Codex，Cursor 做 Editor + Apply。

**Q：能否只用 .cursorrules 不写 .mdc？**
A：可以（最小化部署）。但建议拆 .mdc，按角色 + QG 分别加载，避免主文件过长。

**Q：Cursor 的 Yolo 模式能用吗？**
A：只在 Fallback 节点用（CRUD、样板）。L3/L4 不可逆节点禁止 Yolo，必须 Plan Mode 人审。

---

*本指南是 Cursor 落地参考。体系标准以 [01-标准层/](../01-标准层/) 为权威源。*
