# 依赖配置

> 项目助手通过检测本地路径判断技能是否安装，缺失时不影响其他功能

## 核心依赖（必须）

| 技能包 | 用途 | 检测路径 |
|--------|------|---------|
| project-manager | 项目管理核心（WBS/甘特图/风险/4阶段流程） | ~/.claude/skills/project-manager/skill.md |
| quality-gate | 质量门禁检查（5门禁48检查项） | ~/.claude/skills/quality-gate/skill.md |

## 增强依赖（可选）

| 技能包 | 用途 | 检测路径 |
|--------|------|---------|
| gantt-visualizer | 甘特图可视化 | ~/.claude/skills/gantt-visualizer/skill.md |
| risk-analyzer | 风险智能分析 | ~/.claude/skills/risk-analyzer/skill.md |
| stakeholder-manager | 干系人管理 | ~/.claude/skills/stakeholder-manager/skill.md |
| docx | 项目报告 Word 输出 | ~/.claude/skills/docx/ |
| pptx | 项目汇报 PPT | ~/.claude/skills/pptx/ |
| xlsx | WBS/进度/风险表格 | ~/.claude/skills/xlsx/ |
| pdf | 文档 PDF 输出 | ~/.claude/skills/pdf/ |

## 跨智能体依赖（协调）

本智能体需要感知和协调其他 5 个智能体的状态和产物。

### 智能体状态检测

| 智能体 | 检测路径 | 覆盖阶段 | 协调关系 |
|--------|---------|---------|---------|
| 02-pre-sales-copilot | ~/.claude/skills/02-pre-sales-copilot/skill.md | N1-N3 | 上游：接收需求确认书 |
| product-copilot | ~/.claude/skills/product-copilot/skill.md | N4-N7 | 上游：接收 PRD+Demo |
| 04-dev-copilot | ~/.claude/skills/04-dev-copilot/skill.md | N5-N9 | 上游：接收源码+接口文档 |
| 05-testing-copilot | ~/.claude/skills/05-testing-copilot/skill.md | N10-N12 | 上游：接收测试报告 |
| 06-delivery-copilot | ~/.claude/skills/06-delivery-copilot/skill.md | N13-N15 | 上游：接收交付文档 |

### 交接产物追踪

| 交接点 | 产物 | 检查文件 | 通过条件 |
|--------|------|---------|---------|
| QG-D(N3→N4) | 需求确认书+技术方案 | 项目文档/售前/ | 文件存在+内容完整 |
| QG-S(N7→N8) | PRD+Demo+设计规范 | 项目文档/产品/ | PRD已评审+Demo已确认 |
| QG-B(N10→N11) | 源码+接口文档+联调报告 | 项目文档/开发/ | 代码冻结+联调通过 |
| QG-Ship(N12→N13) | 测试报告+缺陷清单 | 项目文档/测试/ | P0/P1清零+报告Pass |
| QG-Ship(N15→N16) | 交付文档包+验收报告 | 项目文档/交付/ | 验收签字+文档完整 |

## 降级策略

```
缺失技能时的处理：
  project-manager 未安装 → 使用内置 WBS+甘特图+风险框架
  quality-gate 未安装 → 使用 knowledge/quality-gates/ 内置检查项
  gantt-visualizer 未安装 → 使用 Mermaid 甘特图
  risk-analyzer 未安装 → 使用内置风险框架（概率x影响矩阵）
  stakeholder-manager 未安装 → 使用内置干系人分析模板
  docx/pptx/xlsx 未安装 → 输出 Markdown 格式

跨智能体依赖缺失：
  某智能体未安装 → 不影响本智能体工作
  → 但无法自动检测该阶段产物状态
  → 需要用户手动确认交接产物是否就绪
```

## 检测方式

```bash
# 检测核心技能
for skill in project-manager quality-gate; do
  if [ -f ~/.claude/skills/$skill/skill.md ] || [ -f ~/.claude/skills/$skill/SKILL.md ]; then
    echo "[OK] $skill"
  else
    echo "[--] $skill (未安装，已降级)"
  fi
done

# 检测增强技能
for skill in gantt-visualizer risk-analyzer stakeholder-manager; do
  if [ -f ~/.claude/skills/$skill/skill.md ]; then
    echo "[OK] $skill"
  else
    echo "[--] $skill (未安装，已降级)"
  fi
done

# 检测文档工具
for tool in docx pptx xlsx pdf; do
  if [ -d ~/.claude/skills/$tool/ ]; then
    echo "[OK] $tool"
  else
    echo "[--] $tool (未安装，已降级)"
  fi
done

# 检测跨智能体
for agent in 02-pre-sales-copilot product-copilot 04-dev-copilot 05-testing-copilot 06-delivery-copilot; do
  if [ -f ~/.claude/skills/$agent/skill.md ]; then
    echo "[OK] $agent"
  else
    echo "[--] $agent (未安装)"
  fi
done
```
