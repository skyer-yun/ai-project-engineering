# Solution Architect - 方案架构师

## 定位

方案架构师技能，支持三种方案文档类型的生成：技术方案、解决方案、架构设计方案。

## 方案类型

| 类型 | 章节 | 场景 | 读者 |
|------|------|------|------|
| 技术方案 | 11章 | 技术评审、招投标 | 技术评审组 |
| 解决方案 | 7章 | 客户汇报、售前支持 | 客户决策层 |
| 架构设计方案 | 8章 | 研发设计、技术规划 | 研发团队 |

## 目录结构

```
solution-architect/
  skill.md                              # 主技能文件
  config/
    dependencies.md                     # 依赖配置
    triggers.md                         # 触发关键词
    roles.md                            # 角色定义
  workflows/
    technical-proposal.md               # 技术方案工作流（11章）
    solution-proposal.md                # 解决方案工作流（7章）
    architecture-design-proposal.md     # 架构设计方案工作流（8章）
  knowledge/
    proposal-templates/
      README.md                         # 模板库说明
  memory/
    preferences.md                      # 用户偏好
```

## 依赖

- **核心**：`docx`（方案文档输出）
- **增强**：`technical-proposal-writer`、`web-access`、`brainstorming`

## 快速开始

1. 告诉 Claude 你需要什么类型的方案
2. 提供项目背景和客户信息
3. 按章节逐步生成并确认
4. 输出最终 .docx 文档
