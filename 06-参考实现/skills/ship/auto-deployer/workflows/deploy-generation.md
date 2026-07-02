# 部署方案生成工作流

## 工作流概览

```
环境分析(1) → 容器化(2) → K8s编排(3) → CI/CD配置(4) → 文档输出(5)
```

---

## Step 1: 环境分析

### 目标
收集并分析部署环境信息，确定技术方案。

### 输入
- 技术栈信息（语言/框架/数据库/中间件）
- 目标部署平台（K8s 集群/云平台/物理机）
- 资源规格（CPU/内存/存储）
- 网络配置（域名/VPC/负载均衡）
- 并发量和性能要求

### 处理步骤
1. **技术栈识别**
   - 后端框架（Spring Boot / Express / Django / FastAPI）
   - 前端框架（React / Vue / Next.js / Nuxt.js）
   - 数据库（MySQL / PostgreSQL / MongoDB / Redis）
   - 消息队列（RabbitMQ / Kafka / RocketMQ）
   - 其他中间件（Nginx / Elasticsearch / MinIO）

2. **资源估算**
   - 根据并发量估算 CPU/内存需求
   - 根据数据量估算存储需求
   - 根据可用性要求估算副本数

3. **网络规划**
   - 内部服务通信方案（Service Mesh / 直接调用）
   - 外部访问方案（Ingress / LoadBalancer / NodePort）
   - 域名和 SSL 证书规划

4. **环境清单**
   - 开发环境 (dev)
   - 测试环境 (test/staging)
   - 预发布环境 (pre-prod)
   - 生产环境 (prod)

### 输出
- 部署环境分析报告

---

## Step 2: 容器化

### 目标
根据技术栈生成优化的 Dockerfile 和 docker-compose 配置。

### 输入
- 技术栈信息
- 项目构建配置（pom.xml / package.json / requirements.txt）

### 处理步骤

#### 2.1 生成 Dockerfile

**Java (Spring Boot) 模板**：
```dockerfile
# 阶段1: 构建
FROM eclipse-temurin:17-jdk-jammy AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
# 使用 Maven Wrapper
COPY .mvn .mvn
COPY mvnw .
RUN ./mvnw clean package -DskipTests

# 阶段2: 运行
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# [安全] 使用非root用户
RUN groupadd -r appuser && useradd -r -g appuser appuser

COPY --from=builder /app/target/*.jar app.jar

# [安全] 设置文件权限
RUN chown -R appuser:appuser /app
USER appuser

EXPOSE 8080

# [健康检查]
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD curl -f http://localhost:8080/actuator/health || exit 1

ENTRYPOINT ["java", \
  "-Xms256m", "-Xmx512m", \
  "-Djava.security.egd=file:/dev/./urandom", \
  "-jar", "app.jar"]
```

**Node.js 模板**：
```dockerfile
# 阶段1: 安装依赖
FROM node:20-alpine AS deps
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --only=production

# 阶段2: 构建
FROM node:20-alpine AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

# 阶段3: 运行
FROM node:20-alpine
WORKDIR /app

# [安全] 使用非root用户
RUN addgroup -g 1001 -S nodejs && adduser -S nodejs -u 1001

COPY --from=deps /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package.json .

RUN chown -R nodejs:nodejs /app
USER nodejs

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3000/health || exit 1

CMD ["node", "dist/main.js"]
```

**Python (FastAPI/Django) 模板**：
```dockerfile
# 阶段1: 构建
FROM python:3.11-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

# 阶段2: 运行
FROM python:3.11-slim
WORKDIR /app

# [安全] 使用非root用户
RUN groupadd -r appuser && useradd -r -g appuser appuser

COPY --from=builder /root/.local /home/appuser/.local
COPY . .

ENV PATH=/home/appuser/.local/bin:$PATH
RUN chown -R appuser:appuser /app
USER appuser

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/health')" || exit 1

CMD ["gunicorn", "app.main:app", "-w", "4", "-k", "uvicorn.workers.UvicornWorker", "-b", "0.0.0.0:8000"]
```

#### 2.2 生成 .dockerignore
```
.git
node_modules
__pycache__
*.pyc
.env
.env.*
*.md
.vscode
.idea
```

#### 2.3 生成 docker-compose.yml（本地开发用）
```yaml
version: '3.8'
services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "${APP_PORT:-3000}:3000"
    environment:
      - NODE_ENV=development
      - DB_HOST=db
    depends_on:
      db:
        condition: service_healthy
    volumes:
      - ./src:/app/src  # 开发热更新

  db:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: ${DB_ROOT_PASSWORD}
      MYSQL_DATABASE: ${DB_NAME}
    ports:
      - "${DB_PORT:-3306}:3306"
    volumes:
      - db_data:/var/lib/mysql
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 10s
      timeout: 5s
      retries: 5

volumes:
  db_data:
```

### 输出
- Dockerfile
- .dockerignore
- docker-compose.yml（可选）

---

## Step 3: K8s 编排

### 目标
生成完整的 Kubernetes 资源清单。

### 输入
- 容器化配置
- 环境分析报告

### 处理步骤

#### 3.1 生成 Namespace
```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: {project-name}
  labels:
    environment: production
```

#### 3.2 生成 ConfigMap
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {project-name}-config
  namespace: {project-name}
data:
  APP_ENV: "production"
  APP_PORT: "8080"
  LOG_LEVEL: "info"
  # 数据库配置（非敏感信息）
  DB_HOST: "mysql-service"
  DB_PORT: "3306"
  DB_NAME: "{database_name}"
```

#### 3.3 生成 Secret
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: {project-name}-secret
  namespace: {project-name}
type: Opaque
stringData:
  # [WARNING] 以下为示例值，生产环境必须替换
  DB_USERNAME: "REPLACE_ME"
  DB_PASSWORD: "REPLACE_ME"
  JWT_SECRET: "REPLACE_ME"
  REDIS_PASSWORD: "REPLACE_ME"
```

#### 3.4 生成 Deployment
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {project-name}
  namespace: {project-name}
  labels:
    app: {project-name}
    version: v1
spec:
  replicas: 3
  selector:
    matchLabels:
      app: {project-name}
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  template:
    metadata:
      labels:
        app: {project-name}
        version: v1
    spec:
      containers:
        - name: {project-name}
          image: registry.example.com/{project-name}:{VERSION}
          imagePullPolicy: Always
          ports:
            - containerPort: 8080
              protocol: TCP
          envFrom:
            - configMapRef:
                name: {project-name}-config
            - secretRef:
                name: {project-name}-secret
          resources:
            requests:
              cpu: "250m"
              memory: "256Mi"
            limits:
              cpu: "500m"
              memory: "512Mi"
          livenessProbe:
            httpGet:
              path: /actuator/health
              port: 8080
            initialDelaySeconds: 30
            periodSeconds: 10
            timeoutSeconds: 3
            failureThreshold: 3
          readinessProbe:
            httpGet:
              path: /actuator/health/readiness
              port: 8080
            initialDelaySeconds: 10
            periodSeconds: 5
            timeoutSeconds: 3
            failureThreshold: 3
          volumeMounts:
            - name: config-volume
              mountPath: /app/config
              readOnly: true
      volumes:
        - name: config-volume
          configMap:
            name: {project-name}-config
      terminationGracePeriodSeconds: 30
```

#### 3.5 生成 Service
```yaml
apiVersion: v1
kind: Service
metadata:
  name: {project-name}-service
  namespace: {project-name}
spec:
  selector:
    app: {project-name}
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
  type: ClusterIP
```

#### 3.6 生成 Ingress
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {project-name}-ingress
  namespace: {project-name}
  annotations:
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/proxy-body-size: "50m"
    nginx.ingress.kubernetes.io/proxy-read-timeout: "300"
spec:
  ingressClassName: nginx
  tls:
    - hosts:
        - {project-name}.example.com
      secretName: {project-name}-tls
  rules:
    - host: {project-name}.example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: {project-name}-service
                port:
                  number: 80
```

#### 3.7 生成 HPA
```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: {project-name}-hpa
  namespace: {project-name}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: {project-name}
  minReplicas: 3
  maxReplicas: 10
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 70
    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: 80
```

### 输出
- K8s 资源清单文件（namespace/configmap/secret/deployment/service/ingress/hpa）

---

## Step 4: CI/CD 配置

### 目标
根据代码仓库类型生成 CI/CD 流水线配置。

### 输入
- 代码仓库类型（GitLab/GitHub/Jenkins）
- 容器镜像仓库地址
- 部署环境信息

### 处理步骤
见 `knowledge/deploy-patterns/README.md` 中的 CI/CD 模板部分。

### 输出
- CI/CD 流水线配置文件

---

## Step 5: 文档输出

### 目标
汇总所有部署产物，输出完整的部署文档。

### 输入
- 环境分析报告
- Dockerfile
- K8s 资源清单
- CI/CD 配置

### 处理步骤
1. 编写部署概述（架构图、组件说明）
2. 编写部署前置条件（工具、权限、网络）
3. 编写部署步骤（按环境分章节）
4. 编写环境配置说明（配置项清单）
5. 编写回滚方案（标准回滚 + 紧急回滚）
6. 编写监控告警方案
7. 编写常见问题排查

### 输出
- 部署文档（Markdown 或 Word 格式）

### 部署文档模板
```markdown
# {项目名称} 部署文档

## 1. 部署概述
### 1.1 系统架构
### 1.2 技术栈
### 1.3 部署架构图

## 2. 前置条件
### 2.1 基础设施要求
### 2.2 工具和权限
### 2.3 网络要求

## 3. 部署步骤
### 3.1 开发环境部署
### 3.2 测试环境部署
### 3.3 预发布环境部署
### 3.4 生产环境部署 [WARNING]

## 4. 环境配置
### 4.1 配置项清单
### 4.2 敏感配置管理
### 4.3 多环境配置差异

## 5. 回滚方案
### 5.1 标准回滚
### 5.2 紧急回滚
### 5.3 数据回滚

## 6. 监控告警
### 6.1 监控指标
### 6.2 告警规则
### 6.3 值班联系

## 7. 常见问题
### 7.1 部署失败
### 7.2 服务异常
### 7.3 性能问题
```
