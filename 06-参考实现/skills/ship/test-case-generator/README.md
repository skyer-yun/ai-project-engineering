# Test Case Generator

> 测试用例自动生成技能 v1.0

## 概述

根据 PRD/详细设计/验收标准自动生成结构化测试用例集。支持 6 种测试设计方法自动选择。

## 版本

| 版本 | 日期 | 说明 |
|------|------|------|
| 1.0 | 2026-05-26 | 初始版本：3 工作流 + 6 设计方法 + 覆盖率分析 |

## 目录结构

```
test-case-generator/
├── skill.md                              # 主入口
├── README.md                             # 本文件
├── config/
│   ├── dependencies.md                   # 依赖配置
│   ├── triggers.md                       # 触发规则
│   └── roles.md                          # 角色定义
├── workflows/
│   ├── functional-test-case.md           # 功能测试用例生成
│   ├── api-test-case.md                  # API 测试用例生成
│   └── test-coverage-analysis.md         # 覆盖率分析
├── knowledge/
│   ├── test-design-methods/              # 设计方法详解
│   │   └── README.md
│   └── test-templates/                   # 用例模板
│       └── README.md
└── memory/
    └── preferences.md                    # 用户偏好
```

## 被依赖关系

| 智能体 | 依赖类型 | 说明 |
|--------|---------|------|
| 05-testing-copilot | 核心 | 测试用例自动生成的核心技能 |

## 安装路径

```
~/.claude/skills/test-case-generator/skill.md
```

## 使用示例

```
"根据 PRD 生成登录模块测试用例"
→ functional-test-case workflow
→ 自动选择等价类+边界值+状态迁移
→ 输出用例集 + 追溯矩阵

"生成所有 API 接口的测试用例"
→ api-test-case workflow
→ 从详细设计提取接口列表
→ 5维度用例生成

"分析一下测试覆盖率"
→ test-coverage-analysis workflow
→ 生成追溯矩阵 + 覆盖率报告 + 补充建议
```
