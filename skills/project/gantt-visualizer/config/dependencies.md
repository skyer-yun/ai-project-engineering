# Dependencies - gantt-visualizer

## 核心依赖（Core）

无。本技能为独立技能，生成自包含 HTML 文件，不依赖任何外部技能。

## 增强依赖（Enhanced）

| 技能 | 用途 | 效果 |
|------|------|------|
| `project-manager` | 从 WBS 直接导入项目计划 | 无缝对接项目管理流程 |
| `docx` | 导出甘特图到 Word 文档 | 支持嵌入正式文档 |

## 依赖检测逻辑

```
本技能无核心依赖，开箱即用。

IF project-manager 可用:
  支持从 WBS 数据直接导入
  提示: 检测到 project-manager，可从 WBS 直接生成甘特图
ELSE:
  需要用户手动提供任务数据

IF docx 可用:
  支持导出到 Word 文档
ELSE:
  仅支持 HTML 输出
```
