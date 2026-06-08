# Gantt Visualizer - 甘特图可视化

## 定位

将 WBS（工作分解结构）/ 任务列表转换为交互式 HTML 甘特图。自包含 HTML 文件，无需服务器。

## 核心特性

- 交互式甘特图（拖拽调整、时间轴缩放）
- 支持 WBS 缩进文本 / Markdown 表格 / 自然语言输入
- 自包含 HTML（纯 CSS/JS，无外部依赖）
- 支持里程碑、依赖关系、进度显示
- Mermaid 降级方案

## 目录结构

```
gantt-visualizer/
  skill.md                    # 主技能文件
  config/
    dependencies.md           # 依赖配置
    triggers.md               # 触发关键词
    roles.md                  # 角色定义
  workflows/
    gantt-generation.md       # 甘特图生成工作流
  memory/
    preferences.md            # 用户偏好
```

## 依赖

- **核心**：无（独立技能）
- **增强**：`project-manager`（WBS 导入）、`docx`（Word 导出）

## 快速开始

1. 提供项目任务数据（WBS / 表格 / 描述）
2. 自动解析并生成交互式甘特图
3. 可拖拽调整、缩放视图、导出 PNG
