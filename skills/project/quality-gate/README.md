# Quality Gate

> 质量门禁检查技能 v1.0

## 概述

自动验证阶段产物质量标准，覆盖 QG1-QG5 共 5 个门禁 48 个检查项。

## 版本

| 版本 | 日期 | 说明 |
|------|------|------|
| 1.0 | 2026-05-26 | 初始版本：5 门禁 48 检查项 + 3 工作流 |

## 被依赖关系

| 智能体 | 依赖类型 | 说明 |
|--------|---------|------|
| 07-project-copilot | 核心 | 质量门禁管理核心技能 |
| 其他智能体 | 可选 | 按需调用门禁检查 |

## 目录结构

```
quality-gate/
├── skill.md
├── README.md
├── config/
│   ├── dependencies.md
│   ├── triggers.md
│   └── roles.md
├── workflows/
│   ├── single-gate-check.md
│   ├── full-scan.md
│   └── gate-report.md
├── knowledge/
│   └── quality-standards/
│       └── README.md
└── memory/
    └── preferences.md
```
