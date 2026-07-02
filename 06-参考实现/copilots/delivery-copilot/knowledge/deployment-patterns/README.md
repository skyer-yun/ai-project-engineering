# 部署模式速查

> 提供 Docker/K8s/云服务/私有化 4 种主流部署模式速查

---

## 1. Docker 部署

### 适用场景
- 中小规模项目
- 快速交付/演示环境
- 开发/测试环境标准化
- 单机或少量服务器部署

### 核心组件

```
Docker Engine     — 容器运行时
Docker Compose    — 多容器编排（单机）
Docker Registry   — 镜像仓库（公有/私有）
Dockerfile        — 镜像构建脚本
```

### 部署架构

```
[docker-compose.yml]
  ├── nginx (反向代理 + 静态资源)
  ├── app (应用服务)
  ├── redis (缓存)
  └── mysql (数据库)

网络：自定义 bridge 网络
存储：Named Volumes（数据持久化）+ Bind Mounts（配置文件）
```

### 典型 docker-compose 结构

```yaml
version: '3.8'
services:
  nginx:
    image: nginx:1.25
    ports: ["80:80", "443:443"]
    volumes: ["./nginx.conf:/etc/nginx/nginx.conf"]
    depends_on: [app]

  app:
    image: ${REGISTRY}/app:${VERSION}
    environment:
      - DB_HOST=mysql
      - REDIS_HOST=redis
    depends_on: [mysql, redis]

  redis:
    image: redis:7-alpine
    volumes: ["redis-data:/data"]

  mysql:
    image: mysql:8.0
    environment:
      - MYSQL_ROOT_PASSWORD=${DB_PASSWORD}
    volumes: ["mysql-data:/var/lib/mysql"]

volumes:
  redis-data:
  mysql-data:
```

### 关键操作

```
# 构建
docker-compose build

# 启动
docker-compose up -d

# 查看状态
docker-compose ps

# 查看日志
docker-compose logs -f app

# 更新版本
docker-compose pull app
docker-compose up -d app

# 回滚
docker-compose down
# 修改 .env 中 VERSION 为上一版本
docker-compose up -d
```

### 回滚策略
- 镜像版本回退（修改 TAG）
- 数据库需单独回滚（备份恢复）

---

## 2. Kubernetes (K8s) 部署

### 适用场景
- 大规模/高可用项目
- 微服务架构
- 需要自动扩缩容
- 多环境统一管理

### 核心组件

```
Deployment    — 无状态应用部署
StatefulSet   — 有状态应用（数据库）
Service       — 服务发现与负载均衡
Ingress       — 外部访问路由
ConfigMap     — 配置管理
Secret        — 敏感信息管理
PVC           — 持久化存储
HPA           — 自动扩缩容
Namespace     — 环境隔离
Helm          — 包管理工具
```

### 部署架构

```
Ingress (nginx-ingress)
  ├── /api/*  → Service:app (Deployment, 3 replicas)
  ├── /*      → Service:web (Deployment, 2 replicas)
  └── Service:app →
        ├── Pod:app-xxx-1
        ├── Pod:app-xxx-2
        └── Pod:app-xxx-3

StatefulSet: mysql (1 replica + PVC)
StatefulSet: redis (1 replica + PVC)

HPA: app (min:2, max:10, CPU>70%)
```

### 关键操作

```
# 部署
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml

# 查看状态
kubectl get pods,svc,ingress

# 滚动更新
kubectl set image deployment/app app=${REGISTRY}/app:${VERSION}
kubectl rollout status deployment/app

# 回滚
kubectl rollout undo deployment/app
kubectl rollout history deployment/app

# 扩缩容
kubectl scale deployment/app --replicas=5
```

### 回滚策略
- `kubectl rollout undo` 即时回滚
- 数据库使用 StatefulSet + PVC，需独立备份恢复

---

## 3. 云服务部署

### 适用场景
- 快速上线、无需运维基础设施
- 弹性伸缩需求
- 全球化部署
- SaaS 产品

### 主流云平台

| 平台 | 计算服务 | 数据库服务 | 对象存储 | CDN | 适用 |
|------|---------|-----------|---------|-----|------|
| 阿里云 | ECS/ACK/FC | RDS/Redis | OSS | CDN | 国内业务 |
| 腾讯云 | CVM/TKE/SCF | TencentDB | COS | CDN | 腾讯生态 |
| AWS | EC2/EKS/Lambda | RDS/ElastiCache | S3 | CloudFront | 海外业务 |
| Azure | VM/AKS/Functions | Azure DB | Blob | CDN | 微软生态 |

### 常用部署模式

```
模式 1：全托管（Serverless）
  API Gateway + Lambda/FC + RDS + Redis + OSS
  优点：无需管理服务器、按量付费
  缺点：冷启动、厂商锁定

模式 2：容器服务
  ACK/TKE/EKS + RDS + Redis + OSS
  优点：标准化、可迁移
  缺点：需管理集群

模式 3：虚拟机
  ECS/CVM/EC2 + 自建数据库/中间件
  优点：完全控制、灵活
  缺点：运维成本高
```

### 关键配置项

```
网络：VPC + 子网 + 安全组
存储：对象存储（静态资源/附件/备份）
CDN：静态资源加速
域名：DNS 解析 + SSL 证书
监控：云监控 + 日志服务
告警：阈值告警 + 通知（短信/邮件/钉钉）
```

---

## 4. 私有化部署

### 适用场景
- 政企客户、数据安全要求高
- 内网环境、无法访问外网
- 定制化程度高
- 合规要求（等保/密评）

### 部署架构

```
离线环境：

[安装介质]
  ├── Docker 离线包
  ├── 镜像包（tar.gz）
  ├── 数据库安装包
  ├── 配置文件模板
  ├── 安装脚本（install.sh）
  └── 安装手册

[部署架构]
  单机模式：all-in-one（小型项目）
  主从模式：app+db 分离（中型项目）
  集群模式：多节点高可用（大型项目）
```

### 私有化部署关键考虑

```
离线安装：
  [ ] 所有依赖打包到安装介质
  [ ] Docker/中间件离线安装包
  [ ] 系统镜像离线导入
  [ ] 无外网依赖

环境适配：
  [ ] 操作系统兼容性（CentOS/Ubuntu/国产OS）
  [ ] CPU 架构兼容性（x86/ARM/鲲鹏）
  [ ] 数据库兼容性（MySQL/PostgreSQL/达梦/人大金仓）
  [ ] 中间件兼容性（Tomcat/Nginx/宝兰德）

安全合规：
  [ ] 等保要求（等保二级/三级）
  [ ] 密码算法（SM2/SM3/SM4 国密）
  [ ] 日志审计（操作日志保留6个月以上）
  [ ] 数据备份（每日全量 + 实时增量）

运维友好：
  [ ] 一键安装/卸载脚本
  [ ] 健康检查脚本
  [ ] 日志收集脚本
  [ ] 备份恢复脚本
  [ ] 升级脚本（版本间升级）
```

### 安装脚本模板

```bash
#!/bin/bash
# {项目名称} 安装脚本 v{版本}

# 1. 环境检查
check_env() {
  echo "检查系统环境..."
  # OS版本、磁盘空间、端口占用、依赖软件
}

# 2. 安装依赖
install_deps() {
  echo "安装依赖组件..."
  # Docker、数据库、中间件
}

# 3. 导入镜像
load_images() {
  echo "导入应用镜像..."
  # docker load < images/*.tar
}

# 4. 初始化配置
init_config() {
  echo "初始化配置..."
  # 生成配置文件、设置环境变量
}

# 5. 初始化数据库
init_db() {
  echo "初始化数据库..."
  # 建表、初始数据
}

# 6. 启动服务
start_services() {
  echo "启动服务..."
  # docker-compose up -d
}

# 7. 健康检查
health_check() {
  echo "健康检查..."
  # curl http://localhost/health
}

# 执行安装
main() {
  check_env
  install_deps
  load_images
  init_config
  init_db
  start_services
  health_check
  echo "安装完成！"
}

main "$@"
```

---

## 5. 发布策略对比

| 策略 | 描述 | 优点 | 缺点 | 适用场景 |
|------|------|------|------|---------|
| 蓝绿发布 | 两套环境切换 | 零停机、快速回滚 | 资源翻倍 | 核心系统 |
| 金丝雀发布 | 逐步放量 | 风险可控、数据验证 | 发布周期长 | 大型系统 |
| 滚动更新 | 逐台替换 | 资源利用率高 | 回滚较慢 | K8s 环境 |
| 全量发布 | 一次全部更新 | 简单快速 | 风险集中 | 低风险场景 |

### 回滚策略选择

```
高可用系统（金融/支付）：
  → 蓝绿发布 + 数据库双写 + 瞬时切换

一般业务系统：
  → 滚动更新 + 健康检查 + 自动回滚

内部管理系统：
  → 全量发布 + 停机窗口 + 手动回滚

私有化部署：
  → 全量发布 + 数据库备份 + 版本回退脚本
```

---

## 6. 部署模式选择决策树

```
开始
  ↓
是否有 Kubernetes 环境？
  → 是 → K8s 部署（Deployment + Service + Ingress）
  → 否 ↓

是否需要弹性伸缩？
  → 是 → 云服务部署（ACK/TKE/EKS）
  → 否 ↓

客户是否要求私有化？
  → 是 → 私有化部署（Docker 离线 + 安装脚本）
  → 否 ↓

是否已安装 Docker？
  → 是 → Docker Compose 部署
  → 否 → 传统部署（直接安装）
```
