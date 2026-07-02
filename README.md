# ai-project-engineering

> **方法论**：DSBL 五阶段 × Loop 微循环 × 五角色 × HITL × 上下文工程四原则
>
> **核心承诺**：工具中立——体系只定义契约（产物/Schema/HITL/QG），不绑定任何具体 AI 工具。Claude Code、Codex、Cursor、WorkBuddy、用户自研 Agent 都能接入。
>
> **目标**：让 Spec-Writer / Builder / Reviewer / Shipper / Keeper 五角色的 AI 协作像「接力赛」一样可追溯、可回滚、可度量。

---

## 一张图看懂

```
                  ┌─────────────────────────────────────────────┐
                  │   外环：项目级 Sprint（迭代骨架）            │
                  │   ────────────────────────────────────────  │
                  │   中环：D → S → B → Ship → L （DSBL 五阶段）│
                  │   ────────────────────────────────────────  │
                  │   内环：Plan→Act→Observe→Reflect→Exit      │
                  │        （每阶段内的 Loop 微循环）            │
                  └─────────────────────────────────────────────┘
                                       │
                                       ▼
   ┌──────────────────────────────────────────────────────────────┐
   │  00-理论层    为什么这样设计（4 份）                          │
   │              DSBL 阶段模型 / 业界共识 / HITL / 上下文工程    │
   ├──────────────────────────────────────────────────────────────┤
   │  01-标准层    什么是「对」 ⭐ 6 份权威源                     │
   │              DSBL 定义 / Loop 规范 / QG-D~Ship / 交接契约    │
   │              Schema / 工件演化 / 质量硬指标                  │
   ├──────────────────────────────────────────────────────────────┤
   │  02-产物层    每个产物长什么样（按 DSBL 分组模板）          │
   │              D-Discover / S-Spec / B-Build / S-Ship / L-Learn│
   ├──────────────────────────────────────────────────────────────┤
   │  03-执行层    怎么干                                         │
   │   ├ 01-角色Playbook/  （5 角色，给人看）                    │
   │   ├ 02-推广路径与培训方案.md                                 │
   │   └ 03-HITL规则表.md（DSBL×HITL×角色 交叉矩阵）            │
   ├──────────────────────────────────────────────────────────────┤
   │  04-工具层    落地武器                                       │
   │   ├ 01-团队工程素养盘点工具.html                            │
   │   ├ 02-Loop度量看板/                                        │
   │   ├ 03-Checkpoint脚本/            snapshot + rollback       │
   │   └ 04-交接契约工具/              YAML 校验 + 模板           │
   ├──────────────────────────────────────────────────────────────┤
   │  05-适配层    工具中立适配（5 份指南）                      │
   │   ├ Claude-Code / Codex / Cursor / 自带工具 适配指南         │
   │   └ README.md（选型决策树 + 部署命令）                       │
   ├──────────────────────────────────────────────────────────────┤
   │  06-参考实现  参考样例（非标准）                             │
   │   ├ copilots/   6 copilot（→ 5 角色映射）                   │
   │   └ skills/     18 技能（按 spec/build/ship/learn 重组）    │
   └──────────────────────────────────────────────────────────────┘
```

---

## 按角色快速导航

| 我是… | 我该读什么（按顺序） |
|------|--------------------|
| **新人入职** | ① 本 README → ② `00-理论层/01-DSBL阶段模型与Loop微循环原理.md` → ③ 对应角色 Playbook → ④ 选适配方案（[05-适配层/README.md](./05-适配层/README.md)） |
| **Spec-Writer**（需求/产品/售前） | ① `00-理论层/03-HITL模式与不可逆性矩阵.md` → ② `03-执行层/01-角色Playbook/Spec-Writer-Playbook.md` → ③ `02-产物层/D-Discover/` + `S-Spec/` |
| **Builder**（研发/架构） | ① `03-执行层/01-角色Playbook/Builder-Playbook.md` → ② `02-产物层/S-Spec/` + `B-Build/` → ③ `01-标准层/03-质量门禁QG-D至QG-Ship.md` |
| **Reviewer**（质量/审查） | ① `03-执行层/01-角色Playbook/Reviewer-Playbook.md` → ② `01-标准层/03-质量门禁QG-D至QG-Ship.md` |
| **Shipper**（测试/部署/交付） | ① `03-执行层/01-角色Playbook/Shipper-Playbook.md` → ② `02-产物层/S-Ship/` → ③ `04-工具层/03-Checkpoint脚本/` |
| **Keeper**（项目管理/复盘） | ① `03-执行层/01-角色Playbook/Keeper-Playbook.md` → ② `01-标准层/01-DSBL五阶段定义.md` → ③ `04-工具层/02-Loop度量看板/` |

---

## 权威源清单（Must Read）

> 以下 6 份文件是**唯一定义源**，其他位置出现同名概念都是引用。

| # | 文件 | 权威内容 |
|---|------|---------|
| 1 | `01-标准层/01-DSBL五阶段定义.md` | D/S/B/Ship/L 五阶段 × 8 字段定义（使命/主责角色/HITL/Loop Schema/输入产物/输出产物/出口 QG） |
| 2 | `01-标准层/02-Loop微循环规范.md` | Plan/Act/Observe/Reflect/Exit 5 字段细则 + Observe vs Reflect 分离原则 |
| 3 | `01-标准层/03-质量门禁QG-D至QG-Ship.md` | 4 门禁 checklist（每门禁 8-12 项 🔴/🟡） |
| 4 | `01-标准层/04-阶段交接契约Schema.md` | 跨阶段交接 YAML 标准（DSBL 阶段间契约） |
| 5 | `01-标准层/05-工件演化与版本规范.md` | 工件类型注册表 + 版本演化规则 |
| 6 | `01-标准层/06-产物质量硬指标库.md` | 按 DSBL 分组的数字指标阈值（单测 80% / P0/P1=0 等） |

---

## DSBL 五阶段速查

| 阶段 | 使命 | 主责角色 | HITL | 出口 QG |
|------|------|---------|------|---------|
| **D**-Discover | 需求→结构化共识 | Spec-Writer | In（L3） | QG-D |
| **S**-Spec | 方案/PRD/架构/详设 | Spec-Writer→Builder | In（L3） | QG-S |
| **B**-Build | 编码/审查/联调 | Builder+Reviewer | In+Fallback（L2） | QG-B |
| **S**-Ship | 测试/部署/验收/培训 | Shipper+Reviewer | In（L4 生产/验收） | QG-Ship |
| **L**-Learn | 复盘/沉淀 | Keeper | In（L3） | —（终态） |

详见 `01-标准层/01-DSBL五阶段定义.md`。

---

## 五角色速查

| 角色 | 职责 | DSBL 覆盖 |
|------|------|----------|
| **Spec-Writer** | 需求→可执行规范 | D（主）+ S 前半 |
| **Builder** | 规范→代码 | S 后半（架构/详设）+ B |
| **Reviewer** | 质量守门（跨阶段） | S+B+Ship |
| **Shipper** | 测试→部署→验收→培训 | Ship |
| **Keeper** | 上下文/记忆/复盘 | 全程监督 + L |

**关键**：角色与具体 AI 工具解耦——Keeper 可以是 Claude Code、Codex、Cursor 或人。1 角色 = 多工具可承担，1 工具 = 多角色可承担。

---

## 快速上手（3 步）

### 第 1 步：理解方法论（30 分钟）

读 `00-理论层/01-DSBL阶段模型与Loop微循环原理.md`，理解「**外环 Sprint × 中环 DSBL × 内环 Loop 5 字段**」三层嵌套模型。

### 第 2 步：找到自己的角色 Playbook（10 分钟）

`03-执行层/01-角色Playbook/` 选一份（5 角色），按第 1 节「触发场景」开干。

### 第 3 步：选适配方案（5 分钟）

按 [05-适配层/README.md](./05-适配层/README.md) 的决策树选工具：

```bash
./install.sh --adapter claude-code   # Claude Code（参考实现就绪）
./install.sh --adapter codex         # Codex（生成 AGENTS.md）
./install.sh --adapter cursor        # Cursor（生成 .cursorrules）
./install.sh --adapter custom        # 自带工具（部署模板+schema）
./install.sh --templates-only        # 仅产物层模板
./install.sh --tools                 # 部署 snapshot/rollback/validate-handoff
./install.sh --check-neutral         # 工具中立性校验
```

---

## 安装

```bash
# 1. 克隆本仓库
git clone <repo-url> ai-project-engineering
cd ai-project-engineering

# 2. 选适配方案部署（默认 custom：部署模板+schema+QG checklist）
./install.sh --adapter claude-code

# 3. （可选）部署工具脚本到 ~/bin/
./install.sh --tools

# 4. （可选）工具中立性校验
./install.sh --check-neutral
```

详见 `docs/安装与配置.md`。

---

## 目录结构

```
ai-project-engineering/
├── README.md                            # 本文件
├── install.sh                           # 部署脚本（支持 --adapter）
├── 00-理论层/                            # 为什么这样设计（4 份）
├── 01-标准层/                            # 6 份权威源（must read）
├── 02-产物层/                            # DSBL 分组模板
│   ├── D-Discover/
│   ├── S-Spec/
│   ├── B-Build/
│   ├── S-Ship/
│   ├── L-Learn/
│   └── 跨阶段/
├── 03-执行层/
│   ├── 01-角色Playbook/                  # 5 角色
│   ├── 02-推广路径与培训方案.md
│   └── 03-HITL规则表.md
├── 04-工具层/
│   ├── 01-团队工程素养盘点工具.html
│   ├── 02-Loop度量看板/
│   ├── 03-Checkpoint脚本/
│   └── 04-交接契约工具/
├── 05-适配层/                            # 工具中立适配（5 份指南）
│   ├── Claude-Code适配指南.md
│   ├── Codex适配指南.md
│   ├── Cursor适配指南.md
│   ├── 自带工具适配指南.md
│   └── README.md
├── 06-参考实现/                          # 参考样例（非标准）
│   ├── copilots/                         # 6 copilot（→ 5 角色映射）
│   └── skills/                           # 18 技能（spec/build/ship/learn）
└── docs/                                 # 使用指南 / 安装 / FAQ
```

---

## 核心设计原则

| 原则 | 含义 |
|------|------|
| **工具中立** | 体系只定义契约（产物/Schema/HITL/QG），不绑定具体 AI 工具 |
| **DSBL 五阶段** | 5 阶段（D/S/B/Ship/L）× 内嵌 Loop 5 字段，替代瀑布式节点链 |
| **角色驱动** | 五角色跨阶段，不硬绑工种；1 角色 = 多工具可承担 |
| **契约下沉** | HITL/Eval/QG 写进标准层，所有工具通过适配层接入 |
| **单一权威源** | 每个概念只在 01-标准层定义一次，其他位置一律引用 |
| **参考实现可选** | 6 copilot + 18 skills 降级为样例，用户可选用任意工具替代 |
| **HITL 不可逆分级** | L1-L4 不可逆等级，L3/L4 强制人审（In 模式） |
| **上下文工程四原则** | Anthropic 2025-09 官方四原则（Write/Select/Compress/Isolate） |

---

## 业界共识锚点（2025-2026）

本体系对齐以下业界主流共识：

| 共识 | 来源 | 本体系落地 |
|------|------|----------|
| AWS AI-DLC 三阶段 | AWS re:Invent 2025 | DSBL 五阶段（D/S/B/Ship/L） |
| Loop Engineering | Anthropic 2026 工程博客 | 每阶段内嵌 Loop 5 字段 |
| Spec-Driven Development | GitHub/Cursor 2025 实践 | S 阶段产物规范 |
| Context Engineering 4 原则 | Anthropic 2025-09 工程博客 | 00-理论层/04 |
| HITL 73% / 0.8% | Anthropic 2026-02 论文 | 00-理论层/03 HITL 矩阵 |
| MCP + A2A 双层协议栈 | 2025 业界标准 | 05-适配层 工具中立 |
| 五角色趋势 | 业界 2025 综合 | Spec-Writer/Builder/Reviewer/Shipper/Keeper |

详见 `00-理论层/02-业界共识与权威锚点.md`。

---

## 工具中立性校验

```bash
# 体系标准层不应出现具体工具名
./install.sh --check-neutral

# 手动校验
grep -rn "Claude Code\|Codex\|Cursor" 01-标准层/ 00-理论层/  # 应仅在业界共识引用中出现
grep -rn "Claude Code\|Codex\|Cursor" 02-产物层/ 03-执行层/  # 应仅在适配引用中出现
```

工具名只允许在：
- `00-理论层/02-业界共识与权威锚点.md`（业界引用）
- `05-适配层/`（适配指南本身）
- `06-参考实现/`（参考样例）
- 交接契约的 `tool_used` 字段（记录用，非依赖）

---

*本项目由 DSBL × Loop Engineering × HITL × 上下文工程驱动，工具中立、契约驱动、角色协作。*
