# 部署模式库

## 概述

本文档是自动化部署技能的核心知识库，包含 Dockerfile 模板、K8s 资源清单模板、CI/CD 流水线模板、部署策略、环境配置管理方案和回滚方案模板。为部署方案生成提供标准化的参考模板。

---

## 一、Dockerfile 模板

### 1.1 Java (Spring Boot)

```dockerfile
# ===== 多阶段构建 =====
# 阶段1: Maven 构建
FROM eclipse-temurin:17-jdk-jammy AS builder
WORKDIR /build
COPY pom.xml .
# 依赖缓存层（依赖不变时复用）
COPY .mvn .mvn
COPY mvnw .
RUN ./mvnw dependency:go-offline -B
COPY src ./src
RUN ./mvnw clean package -DskipTests -B

# 阶段2: 运行时
FROM eclipse-temurin:17-jre-jammy

# 元数据
LABEL maintainer="devops@example.com"
LABEL version="1.0"
LABEL description="Spring Boot Application"

WORKDIR /app

# [安全] 创建非root用户
RUN groupadd -r appuser && useradd -r -g appuser -d /app -s /sbin/nologin

# 仅拷贝构建产物
COPY --from=builder /build/target/*.jar app.jar

# [安全] 设置权限
RUN chown -R appuser:appuser /app && \
    chmod -R 755 /app

USER appuser

# [资源限制建议] JVM堆内存设置为容器内存的70-80%
ENV JAVA_OPTS="-Xms256m -Xmx512m -XX:+UseG1GC"
ENV TZ=Asia/Shanghai

EXPOSE 8080

# [健康检查]
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD curl -f http://localhost:8080/actuator/health || exit 1

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar app.jar"]
```

### 1.2 Node.js (Next.js/Express)

```dockerfile
# ===== 多阶段构建 =====
# 阶段1: 依赖安装
FROM node:20-alpine AS deps
WORKDIR /app
COPY package.json package-lock.json* ./
# 生产依赖
RUN npm ci --omit=dev

# 阶段2: 构建
FROM node:20-alpine AS builder
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm ci
COPY . .

# Next.js 构建参数（如有）
# ARG NEXT_PUBLIC_API_URL
# ENV NEXT_PUBLIC_API_URL=$NEXT_PUBLIC_API_URL

RUN npm run build

# 阶段3: 运行时
FROM node:20-alpine

# [安全] 非root用户
RUN addgroup -g 1001 -S nodejs && adduser -S nextjs -u 1001

WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
# Next.js 项目
# COPY --from=builder /app/.next/standalone ./
# COPY --from=builder /app/.next/static ./.next/static
# COPY --from=builder /app/public ./public
COPY --from=builder /app/package.json .

RUN chown -R nextjs:nodejs /app
USER nextjs

EXPOSE 3000

ENV NODE_ENV=production
ENV PORT=3000

HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3000/api/health || exit 1

CMD ["node", "dist/main.js"]
```

### 1.3 Python (FastAPI/Django)

```dockerfile
# ===== 多阶段构建 =====
# 阶段1: 依赖构建
FROM python:3.11-slim AS builder
WORKDIR /build
COPY requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

# 阶段2: 运行时
FROM python:3.11-slim

# [安全] 非root用户
RUN groupadd -r appuser && useradd -r -g appuser -d /app -s /sbin/nologin

WORKDIR /app

# 从构建阶段拷贝依赖
COPY --from=builder /root/.local /home/appuser/.local
COPY . .

# 设置PATH
ENV PATH=/home/appuser/.local/bin:$PATH
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN chown -R appuser:appuser /app
USER appuser

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/health')" || exit 1

# Gunicorn + Uvicorn worker
CMD ["gunicorn", "app.main:app", \
     "-w", "4", \
     "-k", "uvicorn.workers.UvicornWorker", \
     "-b", "0.0.0.0:8000", \
     "--access-logfile", "-", \
     "--error-logfile", "-"]
```

---

## 二、K8s 资源清单模板

### 2.1 完整部署清单（kustomization.yaml 结构）

```
k8s/
  base/
    kustomization.yaml
    namespace.yaml
    configmap.yaml
    secret.yaml
    deployment.yaml
    service.yaml
    ingress.yaml
    hpa.yaml
  overlays/
    dev/
      kustomization.yaml
      patches/
    staging/
      kustomization.yaml
      patches/
    production/
      kustomization.yaml
      patches/
```

### 2.2 资源配额参考

| 服务类型 | CPU Request | CPU Limit | Memory Request | Memory Limit | 副本数 |
|----------|-------------|-----------|----------------|--------------|--------|
| Web前端 | 100m | 500m | 128Mi | 256Mi | 2-3 |
| API服务 | 250m | 1000m | 256Mi | 512Mi | 3-5 |
| 后台任务 | 250m | 500m | 256Mi | 512Mi | 1-2 |
| 数据库 | 500m | 2000m | 512Mi | 2Gi | 1 (主) |
| 缓存 | 250m | 1000m | 256Mi | 1Gi | 1-3 |

---

## 三、CI/CD 流水线模板

### 3.1 GitLab CI

```yaml
# .gitlab-ci.yml
stages:
  - lint
  - test
  - build
  - scan
  - deploy-dev
  - deploy-staging
  - deploy-prod

variables:
  DOCKER_REGISTRY: registry.example.com
  IMAGE_NAME: $DOCKER_REGISTRY/$CI_PROJECT_PATH
  IMAGE_TAG: $CI_COMMIT_SHORT_SHA

# 代码检查
lint:
  stage: lint
  image: node:20-alpine
  script:
    - npm ci
    - npm run lint
    - npm run type-check
  only:
    - merge_requests
    - main

# 单元测试
test:
  stage: test
  image: node:20-alpine
  script:
    - npm ci
    - npm run test:coverage
  coverage: '/All files[^|]*\|[^|]*\s+([\d.]+)/'
  artifacts:
    reports:
      coverage_report:
        coverage_format: cobertura
        path: coverage/cobertura-coverage.xml

# 构建镜像
build:
  stage: build
  image: docker:24
  services:
    - docker:24-dind
  script:
    - docker login -u $REGISTRY_USER -p $REGISTRY_PASSWORD $DOCKER_REGISTRY
    - docker build -t $IMAGE_NAME:$IMAGE_TAG -t $IMAGE_NAME:latest .
    - docker push $IMAGE_NAME:$IMAGE_TAG
    - docker push $IMAGE_NAME:latest
  only:
    - main
    - tags

# 安全扫描
scan:
  stage: scan
  image: aquasec/trivy:latest
  script:
    - trivy image --exit-code 1 --severity HIGH,CRITICAL $IMAGE_NAME:$IMAGE_TAG
  only:
    - main

# 部署到开发环境
deploy-dev:
  stage: deploy-dev
  image: bitnami/kubectl:latest
  script:
    - kubectl config use-context dev
    - kubectl set image deployment/$APP_NAME $APP_NAME=$IMAGE_NAME:$IMAGE_TAG -n $APP_NAME-dev
    - kubectl rollout status deployment/$APP_NAME -n $APP_NAME-dev --timeout=300s
  environment:
    name: development
  only:
    - main

# [WARNING] 部署到生产环境
deploy-prod:
  stage: deploy-prod
  image: bitnami/kubectl:latest
  script:
    - kubectl config use-context prod
    - kubectl set image deployment/$APP_NAME $APP_NAME=$IMAGE_NAME:$IMAGE_TAG -n $APP_NAME
    - kubectl rollout status deployment/$APP_NAME -n $APP_NAME --timeout=300s
  environment:
    name: production
  when: manual  # 手动触发
  only:
    - tags
```

### 3.2 GitHub Actions

```yaml
# .github/workflows/deploy.yml
name: Build and Deploy

on:
  push:
    branches: [main]
    tags: ['v*']
  pull_request:
    branches: [main]

env:
  REGISTRY: registry.example.com
  IMAGE_NAME: ${{ github.repository }}

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      - run: npm ci
      - run: npm run lint

  test:
    runs-on: ubuntu-latest
    needs: lint
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      - run: npm ci
      - run: npm run test:coverage

  build:
    runs-on: ubuntu-latest
    needs: test
    if: github.event_name == 'push'
    permissions:
      packages: write
    steps:
      - uses: actions/checkout@v4
      - uses: docker/login-action@v3
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ secrets.REGISTRY_USER }}
          password: ${{ secrets.REGISTRY_PASSWORD }}
      - uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: |
            ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }}
            ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:latest
          cache-from: type=gha
          cache-to: type=gha,mode=max

  # [WARNING] 生产部署
  deploy-prod:
    runs-on: ubuntu-latest
    needs: build
    if: startsWith(github.ref, 'refs/tags/v')
    environment: production
    steps:
      - uses: actions/checkout@v4
      - uses: azure/k8s-set-context@v3
        with:
          method: kubeconfig
          kubeconfig: ${{ secrets.KUBE_CONFIG }}
      - run: |
          kubectl set image deployment/$APP_NAME \
            $APP_NAME=${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }} \
            -n $APP_NAME
          kubectl rollout status deployment/$APP_NAME -n $APP_NAME --timeout=300s
```

### 3.3 Jenkins Pipeline

```groovy
// Jenkinsfile
pipeline {
    agent any

    environment {
        REGISTRY = 'registry.example.com'
        IMAGE_NAME = "${env.REGISTRY}/${env.JOB_NAME}"
        IMAGE_TAG = "${env.BUILD_NUMBER}"
    }

    stages {
        stage('Lint') {
            steps {
                sh 'npm ci && npm run lint'
            }
        }

        stage('Test') {
            steps {
                sh 'npm run test:coverage'
            }
            post {
                always {
                    junit 'reports/junit.xml'
                    publishHTML target: [
                        reportDir: 'coverage',
                        reportFiles: 'index.html',
                        reportName: 'Coverage'
                    ]
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    docker.withRegistry("https://${REGISTRY}", 'registry-credentials') {
                        def app = docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                        app.push()
                        app.push('latest')
                    }
                }
            }
        }

        stage('Security Scan') {
            steps {
                sh "trivy image --exit-code 1 --severity HIGH,CRITICAL ${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }

        stage('Deploy Dev') {
            steps {
                sh """
                    kubectl config use-context dev
                    kubectl set image deployment/${APP_NAME} ${APP_NAME}=${IMAGE_NAME}:${IMAGE_TAG} -n ${APP_NAME}-dev
                    kubectl rollout status deployment/${APP_NAME} -n ${APP_NAME}-dev --timeout=300s
                """
            }
        }

        // [WARNING] 生产部署需要手动确认
        stage('Deploy Prod') {
            steps {
                input message: '确认部署到生产环境？', ok: '确认部署'
                sh """
                    kubectl config use-context prod
                    kubectl set image deployment/${APP_NAME} ${APP_NAME}=${IMAGE_NAME}:${IMAGE_TAG} -n ${APP_NAME}
                    kubectl rollout status deployment/${APP_NAME} -n ${APP_NAME} --timeout=300s
                """
            }
        }
    }

    post {
        failure {
            mail to: 'devops@example.com',
                 subject: "构建失败: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                 body: "构建失败，请检查: ${env.BUILD_URL}"
        }
    }
}
```

---

## 四、部署策略

### 4.1 蓝绿部署 (Blue-Green)

**适用场景**：需要零停机时间、快速回滚能力的服务

```yaml
# 蓝色环境（当前活跃）
apiVersion: v1
kind: Service
metadata:
  name: app-service
spec:
  selector:
    app: myapp
    slot: blue  # 当前指向蓝色
  ports:
    - port: 80
      targetPort: 8080

---
# 绿色环境（新版本部署到这里）
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp-green
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
      slot: green
  template:
    metadata:
      labels:
        app: myapp
        slot: green
        version: "2.0"
    spec:
      containers:
        - name: myapp
          image: myapp:2.0
```

**切换步骤**：
1. 部署新版本到绿色环境
2. 验证绿色环境功能正常
3. 切换 Service selector 从 blue 到 green
4. 观察一段时间确认无异常
5. 保留蓝色环境用于回滚

**回滚**：将 Service selector 切回 blue 即可秒级回滚

### 4.2 金丝雀发布 (Canary)

**适用场景**：需要逐步验证新版本、降低发布风险

```yaml
# 使用 Flagger 或 Argo Rollouts
apiVersion: argoproj.io/v1alpha1
kind: Rollout
metadata:
  name: myapp-rollout
spec:
  replicas: 10
  strategy:
    canary:
      steps:
        - setWeight: 10      # 先切10%流量
        - pause: {duration: 5m}  # 观察5分钟
        - setWeight: 30      # 切到30%
        - pause: {duration: 5m}
        - setWeight: 50      # 切到50%
        - pause: {duration: 10m}
        - setWeight: 100     # 全量切换
      canaryService: myapp-canary
      stableService: myapp-stable
```

### 4.3 滚动更新 (Rolling Update)

**适用场景**：常规版本更新，K8s 默认策略

```yaml
apiVersion: apps/v1
kind: Deployment
spec:
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1        # 更新时最多多创建1个Pod
      maxUnavailable: 0   # 更新时不允许有Pod不可用
```

---

## 五、环境配置管理

### 5.1 多环境配置方案

| 方案 | 适用场景 | 优点 | 缺点 |
|------|----------|------|------|
| Kustomize | K8s 原生 | 简单、无模板语法 | 复杂场景有限 |
| Helm Chart | 复杂应用 | 灵活、可复用 | 学习曲线 |
| 环境变量注入 | 通用 | 简单直接 | 敏感信息需配合 Secret |
| 配置中心(Nacos/Apollo) | 微服务 | 动态更新 | 引入额外依赖 |

### 5.2 敏感信息管理规则

| 信息类型 | 存储方式 | 示例 |
|----------|----------|------|
| 非敏感配置 | ConfigMap | 日志级别、端口、超时 |
| 数据库密码 | K8s Secret + 外部密钥管理 | AWS Secrets Manager / HashiCorp Vault |
| API密钥 | K8s Secret + 外部密钥管理 | 第三方服务的 API Key |
| TLS证书 | K8s Secret (tls类型) | cert-manager 自动管理 |
| JWT密钥 | K8s Secret + 定期轮换 | HS256/RS256 密钥 |

---

## 六、回滚方案模板

### 6.1 标准回滚流程

```markdown
## 标准回滚操作

### 前置检查
1. 确认当前异常现象和影响范围
2. 确认回滚目标版本（上一个稳定版本）
3. 通知相关干系人

### 回滚步骤

#### 方式1: K8s Rollout Undo（推荐）
# 查看部署历史
kubectl rollout history deployment/{app-name} -n {namespace}

# [WARNING] 回滚到上一版本
kubectl rollout undo deployment/{app-name} -n {namespace}

# 回滚到指定版本
kubectl rollout undo deployment/{app-name} --to-revision={N} -n {namespace}

# 验证回滚状态
kubectl rollout status deployment/{app-name} -n {namespace}
kubectl get pods -n {namespace}

#### 方式2: 镜像版本回退
# [WARNING] 将镜像切回上一版本
kubectl set image deployment/{app-name} \
  {app-name}={registry}/{image}:{previous-version} \
  -n {namespace}

# 验证
kubectl rollout status deployment/{app-name} -n {namespace}
```

### 6.2 紧急回滚流程

```markdown
## 紧急回滚操作（P0级别）

### 触发条件
- 服务完全不可用
- 数据一致性风险
- 安全漏洞被利用

### 紧急回滚步骤（5分钟内完成）
1. [WARNING] 立即回滚
   kubectl rollout undo deployment/{app-name} -n {namespace}

2. 验证服务恢复
   curl -f http://{app-name}.example.com/health

3. 通知
   - 发送告警通知到值班群
   - 记录事件时间线和影响范围

4. 后续
   - 保留现场日志和事件信息
   - 安排问题复盘
   - 修复后重新部署
```

### 6.3 数据库回滚注意事项

```markdown
## 数据库回滚策略

### 原则
1. 数据库变更必须向前兼容（新增列可回滚，删除列不可回滚）
2. 每次数据库变更必须有对应的回滚 SQL
3. 大表变更必须分批执行

### 回滚SQL管理
- 每次变更准备 up.sql 和 down.sql
- down.sql 在测试环境验证过
- 生产执行前备份相关表
```
