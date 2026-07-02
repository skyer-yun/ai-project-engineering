# 依赖配置

> 交付智能体通过检测本地路径判断技能是否安装，缺失时不影响其他功能

## 核心依赖（必须）

| 技能包 | 用途 | 检测路径 |
|--------|------|---------|
| docx | 交付文档 Word 输出 | ~/.claude/skills/docx/ |
| pptx | 培训材料/演示文稿 | ~/.claude/skills/pptx/ |

## 增强依赖（可选）

| 技能包 | 用途 | 检测路径 |
|--------|------|---------|
| deployment-planner | 部署方案自动生成 | ~/.claude/skills/deployment-planner/skill.md |
| acceptance-manager | 验收测试管理 | ~/.claude/skills/acceptance-manager/skill.md |
| delivery-doc-generator | 交付文档批量生成 | ~/.claude/skills/delivery-doc-generator/skill.md |
| pdf | 文档 PDF 输出 | ~/.claude/skills/pdf/ |
| xlsx | 验收清单/检查表 | ~/.claude/skills/xlsx/ |
| brainstorming | 部署风险发散 | ~/.claude/skills/brainstorming/ |

## 上游智能体产物（前置条件）

| 产物 | 来源 | 交接条件 |
|------|------|---------|
| 测试报告 | 05-testing-copilot | All Pass 或条件通过 |
| 缺陷清单 | 05-testing-copilot | P0/P1 必须清零 |
| 源码 | 04-dev-copilot | 已冻结+已打 Tag |
| 性能报告 | 05-testing-copilot | 指标达标证明 |

## 下游智能体交接（后置条件）

| 产物 | 目标 | 交接条件 |
|------|------|---------|
| 交付文档包 | 07-project-copilot | 用户手册+运维手册+培训材料 |
| 验收报告 | 07-project-copilot | 客户签字版 |
| 部署文档 | 07-project-copilot | 部署记录+配置清单 |

## 降级策略

```
缺失技能时的处理：
  docx 未安装 → 输出 Markdown 格式
  pptx 未安装 → 输出 Markdown 格式（培训大纲）
  deployment-planner 未安装 → 使用 knowledge/deployment-patterns/ 内置模式
  acceptance-manager 未安装 → 使用内置验收流程模板
  delivery-doc-generator 未安装 → 使用 knowledge/doc-templates/ 内置模板
  pdf/xlsx 未安装 → 输出 Markdown 格式
  brainstorming 未安装 → 使用内置风险清单

上游产物缺失时的处理：
  测试报告缺失 → 不允许部署，提示联系 05-testing-copilot
  P0/P1 未清零 → 不允许部署，阻塞交付流程
  源码未打 Tag → 提示开发团队打 Tag 后继续
```

## 检测方式

```bash
# 检测核心工具
for tool in docx pptx pdf xlsx; do
  if [ -d ~/.claude/skills/$tool/ ]; then
    echo "[OK] $tool"
  else
    echo "[--] $tool (未安装，已降级)"
  fi
done

# 检测增强技能
for skill in deployment-planner acceptance-manager delivery-doc-generator brainstorming; do
  if [ -f ~/.claude/skills/$skill/skill.md ] || [ -f ~/.claude/skills/$skill/SKILL.md ]; then
    echo "[OK] $skill"
  else
    echo "[--] $skill (未安装，已降级)"
  fi
done
```
