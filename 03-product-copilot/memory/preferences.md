# 用户偏好

> 最后更新：2026-05-18
> 用途：记录用户工作习惯与偏好，Product Copilot 据此调整输出风格与技术选型

---

## 语言与风格

| 项目 | 偏好 |
|------|------|
| 语言 | 中文优先，专有名词保持英文原文 |
| 输出风格 | 简洁直接，先说结论再给细节 |
| 交付物 | 面向文档/方案/PPT，不面向讨论 |
| 语气 | 自信但不自负，不确定时先确认再做 |

## 技术选型默认值

| 领域 | 默认选择 | 备选 |
|------|----------|------|
| 前端框架 | React + TypeScript + Tailwind | Vue 3 + TypeScript |
| 设计系统 | Ant Design Pro（中后台）/ TDesign（腾讯系） | Element Plus / Arco Design |
| 数据库 | MySQL / PostgreSQL | SQLite（原型） |
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
| 营销页面 / Landing Page | 自由发挥（frontend-design skill） | - |
| 未指定时 | 主动询问用户选择 | - |

## 工作习惯

- **编辑优先**：修改现有文件，避免创建新文件
- **先读后改**：改文件前先读取理解上下文
- **并行调用**：独立操作尽量并行执行
- **不过度工程**：只做要求的事，不多不少
- **对结果负责**：好的计划跟过程指导好的结果
- **不无脑输出**：遇到不清楚先理思路，再动手

## 行业偏好

<!-- 填写你专注的行业，例如：金融、教育、政务、医疗、电商 -->

- 主要行业：[待填写]
- 次要行业：[待填写]
- 行业特殊要求：[待填写]

## 输出偏好

- PRD：走 `write-a-prd` skill，输出 GitHub Issue 或 Markdown
- 项目管理：走 `project-manager` skill，输出 WBS / 甘特图 / 风险登记册
- 流程图/架构图：DrawIO MCP 或 Mermaid
- Demo 页面：走 `ai-product-dev-kit-modular` skill

## 更新记录

| 日期 | 更新内容 |
|------|----------|
| 2026-05-18 | 初始模板创建 |
