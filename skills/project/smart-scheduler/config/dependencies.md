# 依赖配置

## 核心依赖
- **07-project-copilot**：提供 WBS 数据、任务依赖关系、项目约束条件
  - 必须可用，否则无法执行排期

## 增强依赖
- **gantt-visualizer**：将排期结果可视化为交互式 HTML 甘特图
  - 可选，不可用时降级为 Markdown 表格 + Mermaid 甘特图

## 依赖检查
启动时检测 07-project-copilot 是否可用，不可用时提示用户先提供 WBS 数据。
