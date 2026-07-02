# Project Copilot

> AI 项目管理全能副驾驶 -- 全生命周期管理 DSBL 五阶段（D/S/B/Ship/L），跨智能体协调，质量门禁

---

## 1. 这是什么

Project Copilot 是一个**项目管理智能体**，覆盖项目全生命周期（DSBL 五阶段（D/S/B/Ship/L）），并作为总控协调其他 5 个智能体。

### 核心理念

```
用户说一句话 → Project Copilot 判断阶段和意图 → 调用工作流/协调智能体 → 返回管理交付物
```

### 协调的智能体

| 智能体 | 覆盖阶段 | 协调方式 |
|--------|---------|---------|
| pre-sales-copilot | N1-N3 | 接收需求确认书 + 技术方案 |
| product-copilot | N4-N7 | 接收 PRD + Demo + 设计规范 |
| dev-copilot | N5-N9 | 接收源码 + 接口文档 + 联调报告 |
| testing-copilot | N10-N12 | 接收测试报告 + 缺陷清单 |
| delivery-copilot | N13-N15 | 接收交付文档包 + 验收报告 |

---

## 2. 目录结构

```
07-project-copilot/
├── README.md                          # 本文件
├── skill.md                          # 技能主文件
├── design.md                         # 设计文档（已有）
│
├── config/
│   ├── dependencies.md                #   技能依赖声明（含跨智能体依赖）
│   ├── triggers.md                    #   触发词映射
│   └── roles.md                       #   角色定义
│
├── workflows/
│   ├── project-init-workflow.md       #   项目启动流程
│   ├── project-plan-workflow.md       #   项目规划流程
│   ├── project-track-workflow.md      #   项目跟踪流程
│   └── project-close-workflow.md      #   项目结项流程
│
├── knowledge/
│   ├── project-types/                 #   项目类型速查
│   │   └── README.md                  #     4 类型
│   └── quality-gates/                 #   质量门禁
│       └── README.md                  #     QG-D/S/B/Ship 检查项
│
└── memory/
    └── preferences.md                 #   用户偏好
```

---

## 3. 安装步骤

```bash
cp -r 07-project-copilot/ ~/.claude/skills/project-copilot/
```

---

## 4. 依赖检测与降级

| 缺失技能 | 降级行为 | 影响 |
|----------|----------|------|
| project-manager | 使用内置 WBS + 甘特图 + 风险框架 | 无完整 4 阶段流程 |
| quality-gate | 使用 knowledge/quality-gates/ 内置检查项 | 无自动化检查 |
| gantt-visualizer | 使用 Mermaid 甘特图 | 无交互式可视化 |
| risk-analyzer | 使用内置风险框架 | 无智能风险分析 |
| docx/pptx/xlsx | 输出 Markdown 格式 | 需手动转换 |

---

## 5. 跨智能体协调机制

```
项目全生命周期智能体编排：

N1-N3 售前阶段 → pre-sales-copilot
  ↓ QG-D（规划就绪）
N4-N7 产品阶段 → product-copilot
  ↓ QG-S（需求/设计就绪）
N5-N9 开发阶段 → dev-copilot
  ↓ QG-B（开发完成）
N10-N12 测试阶段 → testing-copilot
  ↓ QG-Ship（测试通过）
N13-N15 交付阶段 → delivery-copilot
  ↓ QG-Ship（交付完成）
N16 结项 → project-copilot
```

### 交接产物清单

| 交接点 | 产物 | 来源 → 目标 |
|--------|------|------------|
| QG-D | 需求确认书 + 技术方案 | pre-sales → product |
| QG-S | PRD + Demo + 设计规范 | product → dev |
| QG-B | 源码 + 接口文档 + 联调报告 | dev → testing |
| QG-Ship | 测试报告 + 缺陷清单(清零) | testing → delivery |
| QG-Ship | 交付文档包 + 验收报告 | delivery → project |

---

## 版本历史

| 版本 | 日期 | 更新内容 |
|------|------|----------|
| 1.0.0 | 2026-05-22 | 初始版本：4 个工作流 + 5 角色 + 5 质量门禁 + 跨智能体协调 |
