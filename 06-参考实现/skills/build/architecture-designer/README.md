# Architecture Designer - 系统架构设计

## 定位

从 PRD/需求文档生成系统架构设计文档。支持 6 种架构模式，输出 7 章标准结构。

## 架构模式

| 模式 | 适用场景 | 复杂度 |
|------|----------|--------|
| 单体架构 | 小型项目/快速验证 | 低 |
| 微服务架构 | 大型系统/多团队 | 高 |
| Serverless | 事件驱动/弹性伸缩 | 中 |
| 事件驱动 | 异步处理/系统解耦 | 中高 |
| 分层架构 | 企业应用/清晰分层 | 中 |
| 六边形架构 | DDD/高可测试 | 中高 |

## 目录结构

```
architecture-designer/
  skill.md                            # 主技能文件
  config/
    dependencies.md                   # 依赖配置
    triggers.md                       # 触发关键词
    roles.md                          # 角色定义
  workflows/
    architecture-design.md            # 架构设计工作流（5阶段）
  knowledge/
    architecture-patterns/
      README.md                       # 6种架构模式参考
  memory/
    preferences.md                    # 用户偏好
```

## 依赖

- **核心**：无（独立技能）
- **增强**：`brainstorming`（多方案对比）、`web-access`（技术选型查询）

## 快速开始

1. 提供 PRD 或需求描述
2. 自动分析需求并推荐架构模式
3. 生成完整的 7 章架构设计文档
