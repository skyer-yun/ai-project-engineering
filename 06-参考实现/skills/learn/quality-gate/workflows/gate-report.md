# Gate Report Workflow

> 门禁报告生成

## Stage 1: 收集结果

从 single-gate-check 或 full-scan 收集检查结果。

## Stage 2: 格式化报告

### Markdown 报告（默认）

按门禁报告模板格式输出（见 single-gate-check.md）。

### Word 报告（需 docx）

调用 docx 技能生成正式文档，包含：
- 封面（项目名 + 门禁名称 + 日期）
- 检查结果表
- 问题清单
- 修复建议
- 签字栏

## Stage 3: 归档

```
归档路径：项目文档/{项目名}/07-管理/质量门禁/
命名规则：{日期}-QG{N}-{门禁名称}-{PASS|FAIL}.md
```
