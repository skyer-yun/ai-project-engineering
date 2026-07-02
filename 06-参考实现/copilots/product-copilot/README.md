# product-copilot — 产品助手智能体

> 版本：v1.1（已完成）
> 安装路径：`~/.claude/skills/product-copilot/`
> 覆盖阶段：N4-N7（需求确认→PRD→原型→技术设计输入）

---

## 1. 当前状态

**已完成**，可直接使用。这是 6 个智能体中第一个实现并经过多轮优化的。

### 已实现功能

- 多技能编排（PRD→Demo→标注）
- 意图识别（LLM 语义优先 + triggers 兜底）
- 依赖检查与优雅降级
- 4 个工作流（PRD/Demo/项目管理/日常）
- 知识库（15 组件模式 + 6 设计系统 + 4 模板参考）
- 记忆系统（偏好保留 + 项目/决策合并原生）
- 动态依赖检测反馈
- 角色自动切换

### 关键文件

| 文件 | 说明 |
|------|------|
| `skill.md` | 主流程（YAML + 9 节结构） |
| `config/triggers.md` | 触发词定义 |
| `config/dependencies.md` | 依赖检查与降级策略 |
| `config/roles.md` | 角色定义 |
| `workflows/` | 4 个工作流（PRD/Demo/项目管理/日常） |
| `knowledge/component-patterns/` | 15 种组件模式 |
| `knowledge/design-systems/` | 6 套设计系统 |
| `knowledge/requirement-templates/` | PRD 模板参考 |
| `knowledge/page-templates/` | 页面模板参考 |
| `knowledge/workflow-templates/` | 工作流模板参考 |
| `knowledge/industry-patterns/` | 行业模式参考 |
| `memory/preferences.md` | 用户偏好记忆 |

---

## 2. 覆盖阶段

| 节点 | 阶段 | 核心产物 | 对应工作流 |
|------|------|----------|-----------|
| N4 | 需求确认 | 需求确认书 | PRD Workflow |
| N5 | PRD 编写 | 12 部分 PRD | PRD Workflow |
| N6 | 原型设计 | Demo 页面 | Demo Workflow |
| N7 | 技术设计输入 | 设计规范、功能清单 | Demo Workflow |

### 交接条件

- **前置（← 02-pre-sales-copilot）**：需求确认书 + 技术方案
- **后置（→ 04-dev-copilot）**：PRD 定稿 + Demo 确认 + 设计规范

---

## 3. 已有技能依赖

| 技能 | 状态 | 用途 |
|------|------|------|
| write-a-prd | 已安装 | PRD 编写（4 种方式/12 部分） |
| ai-product-dev-kit-modular | 已安装 | Demo/原型开发 |
| project-manager | 已安装 | 项目管理（WBS/甘特图） |
| prd-notes | 已安装 | PRD 页面标注 |
| docx/pptx/xlsx/pdf | 已安装 | 文档处理 |
| web-access | 已安装 | 联网操作 |
| brainstorming | 已安装 | 创意发散 |

---

## 4. 归属技能

本智能体在 `skills/product/` 下有 1 个独立技能：

| 技能 | 功能 | Phase |
|------|------|-------|
| requirement-change-manager | 需求变更 6 维度影响评估 | P2 |

---

## 5. 关键设计决策记录

| 决策 | 理由 | 版本 |
|------|------|------|
| LLM 语义优先路由 | 避免 triggers 关键词匹配的局限性 | v1.1 |
| triggers 降级为兜底 | 保持灵活性 | v1.1 |
| 记忆合并到原生 | 避免双写不一致 | v1.1 |
| YAML description 收窄 | 避免与单技能触发竞争 | v1.1 |
| 知识库按需加载 | 控制上下文窗口 | v1.1 |
