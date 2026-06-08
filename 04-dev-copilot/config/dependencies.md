# 依赖配置

> 研发助手通过检测本地路径判断技能是否安装，缺失时不影响其他功能

## 核心依赖（必须，待建）

| 技能包 | 用途 | 检测路径 | 状态 |
|--------|------|---------|------|
| architecture-designer | 架构设计（模式选择+模块划分+技术选型） | ~/.claude/skills/architecture-designer/skill.md | 待建 |
| detailed-designer | 详细设计（接口设计+数据模型+时序图） | ~/.claude/skills/detailed-designer/skill.md | 待建 |

核心依赖未建成时，使用各工作流文件中的内置降级流程继续工作。

## 增强依赖（可选）

| 技能包 | 用途 | 检测路径 | 缺失降级 |
|--------|------|---------|---------|
| code-reviewer | 自动化代码审查（4维度+4级分级） | ~/.claude/skills/code-reviewer/skill.md | 使用 review-workflow 内置审查清单 |
| api-doc-generator | 接口文档自动生成（OpenAPI/Swagger） | ~/.claude/skills/api-doc-generator/skill.md | 手动编写 Markdown 格式 |
| tech-stack-selector | 技术栈选型决策 | ~/.claude/skills/tech-stack-selector/skill.md | 参考 knowledge/tech-stacks/ 手动决策 |
| brainstorming | 创意发散/方案探索 | ~/.claude/skills/brainstorming/ | 使用内置澄清清单 |
| web-access | 联网操作/技术调研 | ~/.claude/skills/web-access/ | 提示用户手动提供资料 |
| docx | Word 文档输出 | ~/.claude/skills/docx/ | 输出 Markdown 格式 |
| xlsx | Excel 表格输出 | ~/.claude/skills/xlsx/ | 输出 Markdown 表格 |

## 前置技能（非安装依赖）

| 技能包 | 用途 | 说明 |
|--------|------|------|
| product-copilot | PRD/Demo/设计规范 | 输入源，非安装依赖。读取其产出的 PRD 文档（Part 7 功能模块详细说明 + Part 8 数据模型 + Part 9 接口规范） |

## 降级策略汇总

```
核心依赖缺失：
  architecture-designer 未建 → 使用 architecture-workflow.md 内置架构设计流程
  detailed-designer 未建 → 使用 detailed-design-workflow.md 内置详细设计流程

增强依赖缺失：
  code-reviewer 未安装 → 使用 review-workflow.md 内置审查清单
  api-doc-generator 未安装 → 手动编写 Markdown 格式接口文档
  tech-stack-selector 未安装 → 参考 knowledge/tech-stacks/README.md 决策树
  brainstorming 未安装 → 使用内置澄清清单
  web-access 未安装 → 提示用户手动提供技术调研资料
  docx/xlsx 未安装 → 输出 Markdown 格式
```

## 检测方式

```bash
# 检测核心依赖
for skill in architecture-designer detailed-designer; do
  if [ -f ~/.claude/skills/$skill/skill.md ] || [ -f ~/.claude/skills/$skill/SKILL.md ]; then
    echo "[已安装] $skill"
  else
    echo "[待建] $skill（使用内置降级流程）"
  fi
done

# 检测增强依赖
for skill in code-reviewer api-doc-generator tech-stack-selector brainstorming web-access docx xlsx; do
  if [ -f ~/.claude/skills/$skill/skill.md ] || [ -f ~/.claude/skills/$skill/SKILL.md ] || [ -d ~/.claude/skills/$skill/ ]; then
    echo "[已安装] $skill"
  else
    echo "[未安装] $skill（已降级）"
  fi
done
```
