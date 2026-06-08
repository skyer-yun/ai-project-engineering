# Detailed Designer - 详细设计

## 定位

从架构设计文档生成详细设计文档。包含接口定义、数据模型（DDL/ER图）、时序图、状态机，供研发直接实施。

## 核心产出

| 产出物 | 格式 | 用途 |
|--------|------|------|
| 详细设计文档 | Markdown/DOCX | 研发参照 |
| 接口定义 | OpenAPI YAML | 前后端联调 |
| DDL 脚本 | SQL | DBA 建表 |
| 时序图 | Mermaid | 流程理解 |
| 状态机图 | Mermaid | 状态管理 |

## 目录结构

```
detailed-designer/
  skill.md                    # 主技能文件
  config/
    dependencies.md           # 依赖配置
    triggers.md               # 触发关键词
    roles.md                  # 角色定义
  workflows/
    detailed-design.md        # 详细设计工作流（6阶段）
  memory/
    preferences.md            # 用户偏好
```

## 依赖

- **核心**：无（独立技能）
- **增强**：`architecture-designer`（接收架构文档）

## 工作流位置

```
PRD → architecture-designer → detailed-designer → 开发实施
                                  ↑
                            本技能所在位置
```

## 快速开始

1. 提供架构设计文档
2. 自动拆解模块，定义接口
3. 生成数据模型、时序图、状态机
4. 输出完整的 10 章详细设计文档
