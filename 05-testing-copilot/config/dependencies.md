# 依赖配置

> 测试智能体通过检测本地路径判断技能是否安装，缺失时不影响其他功能

## 核心依赖（必须）

| 技能包 | 用途 | 检测路径 |
|--------|------|---------|
| test-case-generator | 测试用例自动生成（6 种设计方法） | ~/.claude/skills/test-case-generator/skill.md |

## 增强依赖（可选）

| 技能包 | 用途 | 检测路径 |
|--------|------|---------|
| test-automator | 自动化测试脚本生成 | ~/.claude/skills/test-automator/skill.md |
| defect-analyzer | 缺陷根因分析 | ~/.claude/skills/defect-analyzer/skill.md |
| brainstorming | 测试场景发散/创意探索 | ~/.claude/skills/brainstorming/ |
| xlsx | 测试用例/缺陷表格输出 | ~/.claude/skills/xlsx/ |
| docx | 测试报告 Word 输出 | ~/.claude/skills/docx/ |
| web-access | 安全漏洞查询/标准查阅 | ~/.claude/skills/web-access/ |

## 上游智能体产物（前置条件）

| 产物 | 来源 | 检测方式 |
|------|------|---------|
| PRD 定稿 | product-copilot / write-a-prd | 项目文档目录查找 |
| 接口文档 | 04-dev-copilot | 项目文档目录查找 |
| 联调报告 | 04-dev-copilot | 项目文档目录查找 |
| 源码 | 04-dev-copilot | Git 仓库/分支检查 |

## 下游智能体交接（后置条件）

| 产物 | 目标 | 交接条件 |
|------|------|---------|
| 测试报告 | 06-delivery-copilot | All Pass 或条件通过 |
| 缺陷清单 | 06-delivery-copilot | P0/P1 必须清零 |
| 性能测试报告 | 06-delivery-copilot | 性能指标达标 |

## 降级策略

```
缺失技能时的处理：
  test-case-generator 未安装 → 使用内置 6 种测试设计方法 + knowledge/test-methods/
  test-automator 未安装 → 提供手动测试步骤文档
  defect-analyzer 未安装 → 人工分析模式，提供分析框架
  xlsx/docx 未安装 → 输出 Markdown 格式
  brainstorming 未安装 → 使用内置测试场景清单
  web-access 未安装 → 使用知识库内置安全标准参考

上游产物缺失时的处理：
  PRD 缺失 → 基于用户口头描述进行测试范围分析（降级模式）
  接口文档缺失 → 提示用户从 04-dev-copilot 获取
  联调报告缺失 → 提示用户确认开发完成状态
```

## 检测方式

```bash
# 逐一检测技能是否存在
for skill in test-case-generator test-automator defect-analyzer; do
  if [ -f ~/.claude/skills/$skill/skill.md ] || [ -f ~/.claude/skills/$skill/SKILL.md ]; then
    echo "[OK] $skill"
  else
    echo "[--] $skill (未安装，已降级)"
  fi
done

# 检测文档工具
for tool in xlsx docx web-access brainstorming; do
  if [ -d ~/.claude/skills/$tool/ ]; then
    echo "[OK] $tool"
  else
    echo "[--] $tool (未安装，已降级)"
  fi
done
```
