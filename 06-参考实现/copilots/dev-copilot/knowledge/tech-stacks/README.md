# 技术栈速查

> 常见技术栈选型参考 + 选型决策树。仅在当前任务相关时加载。

---

## 前端框架

### React

```
生态：最成熟，组件库最丰富
适用：中后台、SPA、跨平台（React Native）
优势：组件化、虚拟 DOM、社区庞大
劣势：学习曲线、需额外选型（路由/状态管理）
搭配：
  - UI 库：Ant Design / Arco Design / Semi Design / shadcn/ui
  - 状态管理：Zustand / Redux Toolkit / Jotai
  - 构建：Vite / Next.js
  - 类型：TypeScript（必须）
```

### Vue

```
生态：渐进式，上手快
适用：政企项目、快速原型、中小型项目
优势：模板语法直观、响应式系统、官方全家桶
劣势：大型项目复杂度管理、生态不如 React
搭配：
  - UI 库：Element Plus / TDesign / Naive UI
  - 状态管理：Pinia
  - 构建：Vite / Nuxt.js
  - 类型：TypeScript（推荐）
```

### Angular

```
生态：企业级，Google 维护
适用：大型企业应用、团队规范严格
优势：全家桶、依赖注入、强类型
劣势：学习曲线陡峭、包体积大
搭配：
  - UI 库：Angular Material / NG-ZORRO
  - 状态管理：RxJS / NgRx
```

---

## 后端框架

### Node.js

```
适用：I/O 密集型、实时应用、API 网关、BFF
优势：前后端语言统一、生态丰富、开发效率高
劣势：CPU 密集型任务性能差、单线程

框架选择：
  Express：
    - 轻量灵活，适合小项目/API 服务
    - 中间件生态成熟

  NestJS：
    - 企业级，TypeScript 优先
    - 装饰器风格，类似 Angular
    - 内置依赖注入、模块化、微服务支持
    - 适合中大型项目

  Fastify：
    - 高性能，适合高吞吐 API
    - 插件体系，Schema 验证
```

### Python

```
适用：AI/ML、数据处理、快速原型、脚本
优势：开发效率高、AI 生态最强、语法简洁
劣势：性能不如编译型语言、GIL 限制

框架选择：
  FastAPI：
    - 现代 Python Web 框架
    - 自动生成 OpenAPI 文档
    - 异步支持、类型校验
    - 适合 API 服务

  Django：
    - 全功能框架，自带 Admin/ORM/Auth
    - 适合内容管理、企业应用
    - Django REST Framework 提供 API 支持

  Flask：
    - 轻量灵活，适合小项目/微服务
```

### Java

```
适用：大型企业应用、金融系统、高并发
优势：性能好、生态成熟、企业级支持
劣势：开发效率低、启动慢、代码冗余

框架选择：
  Spring Boot：
    - 企业级标准，生态最完善
    - 微服务（Spring Cloud）
    - 适合大型项目

  Quarkus / GraalVM：
    - 云原生，启动快
    - 适合 Serverless / 容器化
```

### Go

```
适用：微服务、高并发、云原生工具
优势：性能好、并发强、部署简单（单二进制）
劣势：生态不如 Java/Node.js、错误处理繁琐

框架选择：
  Gin：轻量高性能 HTTP 框架
  Echo：类似 Gin，更多内置功能
  Kratos：B站开源微服务框架
```

---

## 数据库

### 关系型

```
MySQL：
  - 最广泛使用，生态成熟
  - 适合大多数 Web 应用
  - 主从复制、读写分离成熟

PostgreSQL：
  - 功能最强大的开源关系型数据库
  - JSON 支持、全文搜索、GIS
  - 适合复杂查询、数据分析

SQLite：
  - 轻量，零配置
  - 适合原型、本地应用、嵌入式
```

### NoSQL

```
MongoDB：
  - 文档型，灵活 Schema
  - 适合内容管理、日志、快速迭代

Redis：
  - 缓存、会话存储、排行榜、消息队列
  - 几乎所有项目都需要

Elasticsearch：
  - 全文搜索、日志分析
  - 适合搜索功能、日志系统
```

---

## 中间件

```
消息队列：
  RabbitMQ：功能完善，适合复杂路由
  Kafka：高吞吐，适合日志/事件流
  Redis Streams：轻量，适合简单场景

搜索：
  Elasticsearch：全文搜索
  Meilisearch：轻量替代

任务调度：
  Bull（Node.js）：Redis 队列
  Celery（Python）：分布式任务队列
```

---

## 部署

```
容器：Docker（必须）
编排：Kubernetes（大型）/ Docker Compose（中小型）
CI/CD：GitHub Actions / GitLab CI / Jenkins
监控：Prometheus + Grafana / Datadog
日志：ELK Stack / Loki
```

---

## 选型决策树

### 前端选型

```
需要前端框架吗？
├─ 是 → 团队技术栈？
│  ├─ React 经验 → React + TypeScript + Vite
│  ├─ Vue 经验 → Vue 3 + TypeScript + Vite
│  └─ 无偏好 → 项目类型？
│     ├─ 中后台/Dashboard → React + Ant Design Pro
│     ├─ 政企项目 → Vue 3 + Element Plus
│     └─ SaaS/创业产品 → React + shadcn/ui 或 Next.js
└─ 否（纯后端/API）→ 不需要前端框架
```

### 后端选型

```
项目类型？
├─ API 服务 → 语言偏好？
│  ├─ JavaScript/TypeScript → Node.js（NestJS 大型 / Express 小型）
│  ├─ Python → FastAPI
│  ├─ Java → Spring Boot
│  └─ Go → Gin
├─ AI/ML 项目 → Python（FastAPI + PyTorch/TensorFlow）
├─ 实时应用 → Node.js（Socket.io） / Go
└─ 企业级/金融 → Java（Spring Boot）
```

### 数据库选型

```
数据特征？
├─ 结构化数据 → 关系型
│  ├─ 通用 → MySQL
│  ├─ 复杂查询/JSON/GIS → PostgreSQL
│  └─ 原型/嵌入式 → SQLite
├─ 非结构化/快速迭代 → MongoDB
└─ 搜索需求 → Elasticsearch + MySQL/PostgreSQL

几乎总是需要：Redis（缓存/会话）
```
