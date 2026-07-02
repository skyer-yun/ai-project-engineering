# 用户偏好

> 最后更新：2026-05-22
> 用途：记录用户研发相关偏好，Dev Copilot 据此调整技术选型、编码风格和输出格式

---

## 语言与风格

| 项目 | 偏好 |
|------|------|
| 语言 | 中文优先，专有名词保持英文原文 |
| 输出风格 | 简洁直接，先说结论再给细节 |
| 交付物 | 面向文档/代码/方案，不面向讨论 |
| 语气 | 自信但不自负，不确定时先确认再做 |

## 技术栈默认值

| 领域 | 默认选择 | 备选 |
|------|----------|------|
| 前端框架 | React + TypeScript + Tailwind | Vue 3 + TypeScript |
| 后端框架 | Node.js（NestJS 大型 / Express 小型） | Python（FastAPI） |
| 数据库 | MySQL / PostgreSQL | SQLite（原型） |
| 缓存 | Redis | — |
| API 风格 | RESTful（默认）/ GraphQL（复杂查询） | gRPC（内部服务） |
| 认证方式 | JWT + OAuth2.0 | Session |
| 部署方式 | Docker + 云服务 | 本地开发环境 |
| 文档格式 | Markdown 为主 | Word / PPT 按需生成 |
| 流程图 | Mermaid 优先 | PlantUML（复杂场景） |

## 设计系统选择规则

| 项目类型 | 设计系统 | 本地路径 |
|----------|----------|---------|
| 腾讯系项目 | TDesign | `C:/Users/Admin/tdesign设计系统/` |
| 中后台 / Dashboard / 管理系统 | Ant Design Pro | `C:/Users/Admin/ant-design-pro设计系统/` |
| Vue 生态 / 政企项目 | Element Plus | `C:/Users/Admin/element-plus设计系统/` |
| 字节系 / 现代化后台 | Arco Design | `C:/Users/Admin/arco-design设计系统/` |
| 暗色模式 / 多品牌 SaaS | Semi Design | `C:/Users/Admin/semi-design设计系统/` |
| React + Tailwind / Next.js | shadcn/ui | `C:/Users/Admin/shadcn-ui设计系统/` |
| 未指定时 | 主动询问用户选择 | — |

## 编码习惯

- **命名规范**：camelCase（变量/函数）、PascalCase（类/组件/类型）、snake_case（数据库字段）
- **目录结构**：按功能模块组织，不按文件类型
- **类型安全**：TypeScript strict mode，避免 any
- **错误处理**：统一错误码体系，不吞异常
- **日志**：结构化日志，区分 debug/info/warn/error 级别
- **测试**：核心业务逻辑必须有单元测试
- **注释**：公共 API 必须 JSDoc/TSDoc，复杂逻辑加行内注释

## Git 规范

- **Commit 格式**：Conventional Commits（`feat`/`fix`/`docs`/`style`/`refactor`/`perf`/`test`/`chore`）
- **分支策略**：main + feature/* + hotfix/*
- **提交粒度**：一个功能点一个 commit，不混合多个功能
- **提交信息**：说"为什么"而非"做了什么"
- **不跳过 hooks**：pre-commit / pre-push hooks 必须通过

## 架构偏好

- **架构模式**：小项目单体，中项目模块化单体，大项目微服务
- **API 风格**：RESTful 优先，GraphQL 按需
- **数据库**：关系型优先，NoSQL 辅助
- **缓存**：Redis 几乎总是需要
- **异步**：耗时操作走消息队列
- **安全**：JWT + HTTPS + 参数化查询 + 输入校验

## 更新记录

| 日期 | 更新内容 |
|------|----------|
| 2026-05-22 | 初始模板创建 |
