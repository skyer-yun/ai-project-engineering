# Claude-Code 适配指南

> **定位**：把 [01-标准层/](../01-标准层/) + [02-产物层/](../02-产物层/) 的契约落地到 Anthropic **Claude Code CLI** 运行时。
>
> 本指南是**参考实现**——体系标准不依赖 Claude Code，但 Claude Code 是首选落地工具之一。

---

## 一、Claude Code 与体系契约的映射

| 体系契约 | Claude-Code 落地形态 |
|----------|--------------------|
| **5 角色 Playbook** | Skill 包（每角色一个 skill 目录） |
| **五阶段产物** | Skill 引用 [02-产物层/](../02-产物层/) 模板，按阶段生成 |
| **Loop 微循环（P/A/O/R/E）** | Skill workflow 文件 + `Plan Mode` 触发 Plan/Reflect |
| **质量门禁 QG-需求/QG-设计/QG-开发/QG-交付** | Skill 内置 checklist + `ExitPlanMode` Hook 强制审核 |
| **阶段交接契约 YAML** | Skill 末尾调用 `validate-handoff.sh` |
| **HITL In/On/Fallback** | `Plan Mode` = In；`AskUserQuestion` = On；自动执行 = Fallback |
| **上下文工程四原则** | `@file` 引用=Select；`Compress` 会话=Compress；Skill 隔离=Isolate |

---

## 二、部署清单

```bash
./install.sh --adapter claude-code
```

部署到 `~/.claude/skills/`：

```
~/.claude/skills/
├── pre-sales-copilot/      # → 需求规范师（Spec-Writer） 参考
├── product-copilot/        # → 需求规范师（Spec-Writer） 参考
├── dev-copilot/            # → 构建师（Builder） 参考
├── testing-copilot/        # → 交付师（Shipper） 参考
├── delivery-copilot/       # → 交付师（Shipper） 参考
├── project-copilot/        # → 统筹师（Keeper） 参考
└── （18 技能 spec/build/ship/learn）
```

源码见 [06-参考实现/](../06-参考实现/)。

---

## 三、角色与 copilot 选择建议

| 体系角色 | 推荐主用 copilot | 可选协作 |
|---------|----------------|---------|
| **需求规范师（Spec-Writer）** | pre-sales-copilot（售前场景）/ product-copilot（产品场景） | solution-architect |
| **构建师（Builder）** | dev-copilot | architecture-designer / detailed-designer / code-reviewer |
| **审查师（Reviewer）** | code-reviewer skill（跨 copilot 抽取） | quality-gate skill |
| **交付师（Shipper）** | testing-copilot + delivery-copilot | test-case-generator / auto-deployer |
| **统筹师（Keeper）** | project-copilot | risk-sentinel / smart-scheduler |

**关键**：1 角色 = 多 copilot 可承担；1 copilot = 可跨角色。Claude Code 会话内可切换角色。

---

## 四、典型 Claude-Code 工作流

### 需求 阶段

```
用户：pre-sales-copilot / product-copilot
  ↓
Plan Mode（HITL-In）
  ↓ AI 起草：需求分析报告大纲
ExitPlanMode → 用户审批
  ↓
Act：填充 [02-产物层/需求/需求分析报告模板.md]
  ↓
Observe：跑 Eval（requirement_completeness ≥ 0.9）
  ↓
Reflect：与干系人清单对齐
  ↓
Exit：写 handoff.yaml（from_stage=D, to_stage=S, QG-需求=passed）
```

### 设计 阶段

```
dev-copilot + solution-architect skill
  ↓
Plan Mode → Act：生成技术方案 / PRD / 架构设计
  ↓
Observe：QG-设计 checklist 自动检查
  ↓
Reflect：code-reviewer skill 介入（审查师（Reviewer） 角色）
  ↓
Exit：handoff.yaml（from_stage=S, to_stage=B, QG-设计=passed）
```

### 开发 阶段

```
dev-copilot
  ↓
关键模块：Plan Mode（HITL-In）
CRUD/样板：Fallback 自动执行
  ↓
code-reviewer skill 跑四维审查
  ↓
Observe：单测 ≥80% 行覆盖 + lint 零严重
  ↓
Exit：handoff.yaml（from_stage=B, to_stage=Ship, QG-开发=passed）
```

### 交付阶段

```
testing-copilot + delivery-copilot
  ↓
test-case-generator skill 生成用例
  ↓
performance-tester skill 压测
  ↓
auto-deployer skill（生产部署 HITL-In + L4 不可逆）
  ↓
Exit：handoff.yaml（from_stage=Ship, to_stage=L, QG-交付=passed）
```

### 复盘 阶段

```
project-copilot + knowledge-compiler skill
  ↓
填写 [02-产物层/复盘/项目复盘模板.md]
  ↓
沉淀到项目 memory
```

---

## 五、Plan Mode = HITL-In 的工具中立表达

Claude Code 的 Plan Mode 是 HITL-In 的具体实现：

- **AI 起草**（Plan）→ **人审批**（ExitPlanMode Hook）→ **AI 执行**（Act）
- 对应 [00-理论层/03-HITL模式与不可逆性矩阵.md](../00-理论层/03-HITL模式与不可逆性矩阵.md) 的 **HITL-In** 模式
- 不可逆性 L3/L4 节点（需求阶段共识、设计阶段方案、交付阶段上线）**必须**用 Plan Mode

> **工具中立声明**：其他 AI 工具（Codex/Cursor）若没有原生 Plan Mode，用「AI 起草 → 人审 → 执行」的等效机制即可。

---

## 六、Skill 内引用标准层的写法

Claude Code Skill 的 `skill.md` 应当：

```markdown
## 强制契约（来自体系标准层）

本技能执行时必须遵守：
- 阶段定义：[../../01-标准层/01-五阶段定义.md]
- Loop 微循环：[../../01-标准层/02-Loop微循环规范.md]
- 质量门禁：[../../01-标准层/03-质量门禁QG-需求至QG-交付.md]
- 交接契约：[../../01-标准层/04-阶段交接契约Schema.md]
- HITL 规则：[../../03-执行层/03-HITL规则表.md]

## 输入产物（来自上游 handoff）
解析 from_stage=D 的 handoff.yaml，加载 output_artifacts。

## 输出产物（去下游 handoff）
按 [../../02-产物层/设计/] 模板生成，写入 handoff.yaml。
```

---

## 七、常见问题

**Q：6 个 copilot 是否必须全装？**
A：不。最小化部署只装 1 个（如 dev-copilot 走 构建师（Builder） 角色），其余靠 Claude Code 原生路由。

**Q：能否只用 Claude Code 原生能力，不装 copilot？**
A：完全可以。体系标准层和产物层是工具中立的 markdown，Claude Code 直接读模板填字段即可。copilot 只是参考实现，降低接入成本。

**Q：Plan Mode 是否会拖慢速度？**
A：只在 L3/L4 不可逆节点慢一点（避免返工）。Fallback 节点（CRUD、样板）仍走自动执行。Anthropic 2026-02 论文实证：73% 任务仍是 HITL-In/On 模式。

---

*本指南是 Claude Code 落地参考。体系标准以 [01-标准层/](../01-标准层/) 为权威源。*
