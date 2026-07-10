# 06-参考实现

> **定位声明**：本目录是**参考样例**，不是体系标准。
>
> 体系标准在 [00-理论层/](../../00-理论层/) + [01-标准层/](../../01-标准层/) + [02-产物层/](../../02-产物层/) + [03-执行层/](../../03-执行层/)。
>
> 本目录提供 6 个 copilot + 多个 skills 作为**示例实现**，演示如何用具体 AI 工具落地本体系。用户可选用任意 AI 工具替代，详见 [05-适配层/](../../05-适配层/)。

---

## 目录结构

```
06-参考实现/
├── README.md                          # 本文件（定位声明）
├── copilots/                          # 6 个角色样例 copilot
│   ├── pre-sales-copilot/             # → 需求规范师（Spec-Writer） 参考实现
│   ├── product-copilot/               # → 需求规范师（Spec-Writer） 参考实现
│   ├── dev-copilot/                   # → 构建师（Builder） 参考实现
│   ├── testing-copilot/               # → 交付师（Shipper） 参考实现
│   ├── delivery-copilot/              # → 交付师（Shipper） 参考实现
│   └── project-copilot/               # → 统筹师（Keeper） 参考实现
└── skills/                            # 18 技能样例，按 五阶段 重组
    ├── spec/                          # D/设计阶段技能（需求/方案/PRD）
    ├── build/                         # S 后半/开发阶段技能（架构/详设/审查）
    ├── ship/                          # 交付阶段技能（测试/部署/培训）
    └── learn/                         # 跨阶段/项目管理技能
```

---

## 角色与 copilot 映射

> **关键声明**：1 个角色可由多 copilot 承担，1 个 copilot 也可跨角色。

| 五角色 | 参考实现 copilot | 备注 |
|--------|----------------|------|
| **需求规范师（Spec-Writer）** | pre-sales-copilot + product-copilot | 售前+产品 合并示例 |
| **构建师（Builder）** | dev-copilot | 研发 |
| **审查师（Reviewer）** | （跨 copilot 抽取资深人/agent） | 无独立 copilot，由各 copilot 协作 |
| **交付师（Shipper）** | testing-copilot + delivery-copilot | 测试+交付 合并示例 |
| **统筹师（Keeper）** | project-copilot | 项目管理 → 统筹师（Keeper） |

---

## 18 技能源码重组（按 五阶段）

### spec/（D + S 前半）
- `competitive-analyzer`：竞品分析
- `requirement-change-manager`：需求变更管理
- `solution-architect`：方案架构师

### build/（S 后半 + B）
- `architecture-designer`：架构设计
- `code-reviewer`：代码审查（审查师（Reviewer） 角色工具）
- `detailed-designer`：详细设计

### ship/（对应：交付阶段 全程）
- `test-case-generator`：测试用例自动生成
- `performance-tester`：性能测试
- `auto-deployer`：自动化部署
- `user-trainer`：用户培训材料
- `customer-satisfaction`：客户满意度评估

### learn/（跨阶段 + 项目管理）
- `quality-gate`：质量门禁检查（QG-需求~QG-交付 落地）
- `risk-sentinel`：风险预警
- `gantt-visualizer`：甘特图可视化
- `smart-scheduler`：智能排期
- `multi-project-dashboard`：多项目看板
- `knowledge-compiler`：项目知识沉淀
- `continuous-optimizer`：持续优化建议

---

## 使用建议

### 1. 直接用 Claude Code 部署

详见 [05-适配层/Claude-Code适配指南.md](../../05-适配层/Claude-Code适配指南.md)：

```bash
./install.sh --adapter claude-code
# 部署 copilots/ 和 skills/ 到 ~/.claude/skills/
```

### 2. 用其他 AI 工具

详见 [05-适配层/](../../05-适配层/) 其他指南，按工具特性转换格式：
- Codex：转 AGENTS.md
- Cursor：转 .cursorrules
- 自带工具：参考模板自写

### 3. 不用参考实现，自建工具

完全可以。体系标准层和产物层是工具中立的 markdown 模板，任何能读 markdown 的 AI 工具都能落地。

---

## 维护原则

- 参考实现跟随业界 AI 工具演进，每季度评审一次
- 不强制同步——参考实现落后于体系标准时，以体系标准为准
- 用户反馈改进项录入 [02-产物层/复盘/项目复盘模板.md](../../02-产物层/复盘/项目复盘模板.md) 改进项区

---

*本目录是**参考样例**。体系标准以 [01-标准层/](../../01-标准层/) 为权威源。*
