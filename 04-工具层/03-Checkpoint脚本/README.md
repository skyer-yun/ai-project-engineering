# Checkpoint 脚本工具

> **版本**：v1.1 / 2026-07-06
> **用途**：开发/开发/交付 节点出口 + 部署前快照 + 回滚
> **关联**：[01-标准层/03-质量门禁QG-需求至QG-交付.md](../../01-标准层/03-质量门禁QG-需求至QG-交付.md) §六 / [02-产物层/05-交付阶段/部署与验收文档模板.md](../../02-产物层/05-交付阶段/部署与验收文档模板.md)

---

## 文件清单

| 文件 | 用途 |
|------|------|
| `snapshot.sh` | 打快照（DB + 配置 + AI 上下文 + sha256） |
| `rollback.sh` | 回滚到指定快照（含双签 + 冒烟钩子） |
| `checkpoint-template.md` | 人工记录模板（无 DB 权限场景） |

---

## 快速上手

### 1. 交付阶段 部署前快照（强制前置）

```bash
cd {project-root}

# 配置数据库连接（建议从 .env 读，不硬编码）
export DB_TYPE=mysql
export DB_HOST=localhost
export DB_PORT=3306
export DB_USER=root
export DB_PASSWORD=$(grep DB_PASSWORD .env | cut -d= -f2)
export DB_NAME=myapp

# 打部署前快照
./04-工具层/03-Checkpoint脚本/snapshot.sh \
  --type deploy \
  --node Ship \
  --tag pre-deploy-$(date +%Y%m%d)

# 输出示例
# 📁 Snapshot directory: snapshots/pre-deploy-20260701-1430/
# ✓ DB dump: db-backup.sql (245MB)
# ✓ Config: config-backup.tar.gz (12KB)
# ✓ AI context: ai-context-backup.json (45KB)
# ✓ Manifest: manifest.sha256
# ✅ Snapshot created successfully!
```

### 2. B 特性完成时打 Checkpoint

```bash
./snapshot.sh --type node --node B --tag feat-auth-done
```

### 3. 列出可用快照

```bash
./rollback.sh --list
```

### 4. 回滚到指定快照

```bash
# 交互模式（推荐，强制双签）
./rollback.sh --to pre-deploy-20260701-1430

# 跳过数据库回滚（仅配置+AI上下文）
./rollback.sh --to pre-deploy-20260701-1430 --skip-db

# 自动化场景（仅 CI/CD，需谨慎）
./rollback.sh --to pre-deploy-20260701-1430 --yes
```

---

## 配置

### 环境变量

| 变量 | 默认 | 说明 |
|------|------|------|
| `PROJECT_ROOT` | `$(pwd)` | 项目根目录 |
| `DB_TYPE` | `mysql` | `mysql` / `postgres` / `none` |
| `DB_HOST` / `DB_PORT` | `localhost` / `3306` | 数据库连接 |
| `DB_USER` / `DB_PASSWORD` | `root` / 空 | 数据库账号（建议从 `.env` 读） |
| `DB_NAME` | `app` | 数据库名 |

### 自定义备份路径

修改脚本顶部的常量：

```bash
CONFIG_PATHS=("config/" ".env" ".env.production")
AI_CONTEXT_PATHS=("项目文档/" "ai-context/" "CLAUDE.md")
```

---

## 与阶段集成

| 节点 | 强制 Checkpoint | 触发时机 |
|------|----------------|---------|
| **开发阶段编码** | 推荐 | 每特性完成 → atomic commit 前 |
| **开发阶段联调** | 推荐 | 集成测试通过后 → 提测前 |
| **交付阶段部署** | **强制**（QG 部署门禁） | 生产部署前 → 必须 snapshot |
| 交付阶段验收 | 可选 | 客户验收后归档 |

详见 [01-标准层/03-质量门禁QG-需求至QG-交付.md](../../01-标准层/03-质量门禁QG-需求至QG-交付.md) §六。

---

## 与 HITL 集成

> 交付阶段部署 = L4 不可逆 → 强制 HITL-In（详见 [00-理论层/03-HITL模式与不可逆性矩阵.md](../../00-理论层/03-HITL模式与不可逆性矩阵.md) §四）

`rollback.sh` 强制双签：
- 运维签字（确认操作可行性）
- 业务签字（确认数据丢失可接受）

`--yes` 参数仅供 CI/CD 使用，生产环境禁用。

---

## 回滚后冒烟测试

`rollback.sh` 会自动执行 `${PROJECT_ROOT}/scripts/smoke-after-rollback.sh`（如存在）：

```bash
#!/usr/bin/env bash
# scripts/smoke-after-rollback.sh
curl -fsS https://app.example.com/health || exit 1
curl -fsS https://app.example.com/api/v1/ping || exit 1
# 核心业务流程验证
curl -fsS -X POST https://app.example.com/api/v1/auth/login \
  -d '{"phone":"13800138000","password":"smoke-test"}' || exit 1
echo "✓ Smoke test passed"
```

---

## 验证工具可用

```bash
# 创建测试快照（不连真实 DB）
./snapshot.sh test

# 列出快照
./rollback.sh --list

# 回滚测试快照（不影响生产）
./rollback.sh --to smoke-test-{timestamp} --skip-db --yes
```

预期：
- `snapshots/smoke-test-{timestamp}/` 目录创建成功
- `manifest.sha256` 校验通过
- 回滚流程跑通

---

## FAQ

**Q: snapshot 失败提示"缺少 mysqldump"**
A: 安装 MySQL client：`apt install default-mysql-client` 或 `brew install mysql-client`

**Q: 生产环境 DB 太大，dump 慢**
A: 用 RDS 快照代替脚本 dump：
1. 在 AWS/阿里云控制台打 RDS 快照
2. 把 snapshot ID 写入 `checkpoint-template.md` 的人工记录
3. `snapshot.sh` 设 `DB_TYPE=none` 跳过自动 dump

**Q: K8s 环境如何回滚**
A: 用 K8s 原生 rollback：
```bash
kubectl rollout undo deployment/myapp --to-revision=N
```
本工具的 DB/配置/AI 上下文回滚仍然适用。

---

## 版本记录

| 版本 | 日期 | 修订 |
|------|------|------|
| v1.0 | 2026-06-30 | 初始版本 |
| v1.1 | 2026-07-06 | 全仓一致性复盘 + 五角色/新 schema 对齐 |

---

*本工具是 Checkpoint 协议的落地实现。配合 `04-工具层/04-交接契约引用工具/` 一起使用。*
