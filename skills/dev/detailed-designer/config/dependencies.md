# Dependencies - detailed-designer

## 核心依赖（Core）

无。本技能可独立运行，基于架构设计文档进行详细设计。

## 增强依赖（Enhanced）

| 技能 | 用途 | 效果 |
|------|------|------|
| `architecture-designer` | 接收架构设计文档，实现上下游衔接 | 无缝衔接架构设计到详细设计 |

## 依赖检测逻辑

```
本技能无核心依赖，开箱即用。

IF architecture-designer 可用:
  建议工作流：PRD → architecture-designer → detailed-designer
  支持直接从架构设计产出导入
  输出提示: 建议先使用 architecture-designer 完成架构设计
ELSE:
  需要用户手动提供架构设计文档
  提示: 请提供架构设计文档，或描述系统模块划分
```

## 上下游衔接

```
PRD → architecture-designer → detailed-designer → 开发实施
                                ↑
                          本技能所在位置
```

### 输入来源
1. architecture-designer 的 7 章架构文档（推荐）
2. 用户手动提供的架构设计描述
3. 现有系统的架构文档

### 输出去向
1. 开发团队直接参照编码
2. 接口文档供前后端联调
3. DDL 供 DBA 执行建表
