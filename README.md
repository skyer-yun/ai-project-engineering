# AI 项目工程化 - 6 智能体协作体系

## 概述

本项目定义了覆盖 AI 项目全生命周期（N1-N16）的 6 智能体协作体系，通过 Meta-Skill 编排层实现售前、产品、开发、测试、交付、项目管理的端到端智能化支撑。

## 6 智能体

| 智能体 | 覆盖阶段 | 当前状态 |
|--------|----------|----------|
| pre-sales-copilot | N1-N3（需求收集、分析、方案编写） | 已安装，知识库完整 |
| product-copilot | N4-N7（方案评审、PRD、原型、设计输入） | v1.1 已完成 |
| dev-copilot | N5-N9（架构设计、详细设计、编码、审查、联调） | 已安装，5工作流 |
| testing-copilot | N10-N12（测试策略、测试执行、缺陷闭环） | 已安装，知识库完整 |
| delivery-copilot | N13-N15（部署发布、验收交付、培训移交） | 已安装，知识库最丰富 |
| project-copilot | N1-N16（全周期计划、跟踪、风险、门禁、收尾） | 已安装，7技能归属 |

## 设计范式

每个智能体采用统一的 Meta-Skill 编排层架构：

- **目录结构**：`skill.md` + `config/` + `workflows/` + `knowledge/` + `memory/`
- **skill.md**：YAML 头部（name/version/description/dependencies/triggers） + 9 节正文
- **路由机制**：LLM 语义优先路由 + `triggers.md` 关键词兜底 + 置信度三档路由
- **记忆策略**：偏好保留在 skill 专属 memory/，项目决策合并到原生记忆
- **依赖检查**：启动时动态检测，按核心/增强分级，缺失时提供降级方案

### skill.md 9 节结构

1. 角色定义与能力边界
2. 意图识别与路由
3. 依赖检查
4. 工作流路由
5. 知识库
6. 记忆系统
7. 核心规则
8. 启动流程
9. 错误处理

## 技能路线图（全部完成）

18 个技能已全部开发完成并安装，分 3 阶段交付：

| 阶段 | 技能数 | 状态 |
|------|--------|------|
| Phase 1（核心） | 7 个 | 已完成 — solution-architect / competitive-analyzer / architecture-designer / detailed-designer / test-case-generator / quality-gate / gantt-visualizer |
| Phase 2（增强） | 6 个 | 已完成 — requirement-change-manager / code-reviewer / auto-deployer / performance-tester / user-trainer / knowledge-compiler |
| Phase 3（扩展） | 5 个 | 已完成 — smart-scheduler / risk-sentinel / multi-project-dashboard / customer-satisfaction / continuous-optimizer |

## 目录结构

```
ai-project-engineering/
├── README.md                              # 本文件
├── 00-总体架构/
│   ├── 6智能体协作全景图.md
│   ├── N1-N16统一阶段定义.md               # 唯一权威阶段定义
│   ├── 跨智能体对齐机制.md
│   └── 待建技能清单与优先级.md
├── 01-飞书知识库参考/                      # 16 篇参考文档（模板+规范）
├── 02-pre-sales-copilot/                  # 售前智能体（4 工作流）
├── 03-product-copilot/                    # 产品智能体（v1.1 已安装，本项目内为指针）
├── 04-dev-copilot/                        # 开发智能体（4 工作流）
├── 05-testing-copilot/                    # 测试智能体（4 工作流）
├── 06-delivery-copilot/                   # 交付智能体（3 工作流）
├── 07-project-copilot/                    # 项目管理智能体（4 工作流）
└── skills/                                # 独立技能（按智能体归属分组）
    ├── pre-sales/                         # 售前：solution-architect / competitive-analyzer
    ├── product/                           # 产品：requirement-change-manager
    ├── dev/                               # 开发：architecture-designer / detailed-designer / code-reviewer
    ├── testing/                           # 测试：test-case-generator / performance-tester
    ├── delivery/                          # 交付：auto-deployer / user-trainer / customer-satisfaction
    └── project/                           # 项目：quality-gate / gantt-visualizer / knowledge-compiler / smart-scheduler / risk-sentinel / multi-project-dashboard / continuous-optimizer
```

## 当前进度

- [x] 总体架构设计（协作全景图、对齐机制、技能清单）
- [x] N1-N16 统一阶段定义（消除飞书参考文档版本差异）
- [x] product-copilot v1.1 开发完成
- [x] 6 智能体设计完成（skill.md + config + workflows 全部 9 节结构）
- [x] Phase 1 核心技能 7 个已开发
- [x] Phase 2 增强技能 6 个已开发
- [x] Knowledge 知识库内容填充（18 技能 + 5 智能体共 ~10,370 行）
- [x] Phase 3 扩展技能 5 个已开发
- [x] 端到端联调验证（6 维度全部 PASS）
- [x] 源项目目录重组（技能按智能体归属分组 + 安装脚本）
