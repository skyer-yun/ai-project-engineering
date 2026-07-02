# FAQ - 常见问题

> **方法论**：DSBL 五阶段 × Loop 微循环 × 五角色 × HITL × 工具中立

---

## 目录

- [一、概念与架构](#一概念与架构)
- [二、工具中立与适配](#二工具中立与适配)
- [三、DSBL 阶段与 Loop 微循环](#三dsbl-阶段与-loop-微循环)
- [四、HITL 模式选择](#四hitl-模式选择)
- [五、Claude Code 使用](#五claude-code-使用)
- [六、其他工具接入](#六其他工具接入)
- [七、工具脚本](#七工具脚本)
- [八、数据存储与备份](#八数据存储与备份)
- [九、定制与扩展](#九定制与扩展)

---

## 一、概念与架构

### Q1：本体系的核心模型是什么？

**A**：三层嵌套：
- **外环**：项目级 Sprint（迭代骨架）
- **中环**：DSBL 五阶段（Discover / Spec / Build / Ship / Learn）
- **内环**：Loop 微循环（Plan / Act / Observe / Reflect / Exit）

每阶段内跑 Loop 直到满足出口 QG，写 handoff.yaml 交接给下游角色。

### Q2：DSBL 五阶段和瀑布式节点链的区别？

**A**：
| 维度 | 瀑布式节点链 | DSBL |
|------|------------|------|
| 颗粒度 | 16+ 个细粒度节点 | 5 阶段（每阶段内嵌 Loop 保持颗粒度） |
| 切换灵活度 | 必须顺序走 | 按项目类型路由（瀑布/迭代/敏捷） |
| 业界对齐 | 偏传统 | 对齐 AWS AI-DLC 三阶段主流共识 |
| 阶段交接 | 节点级签名 | 阶段级 YAML 契约（schema 完整） |

详见 `00-理论层/01-DSBL阶段模型与Loop微循环原理.md`。

### Q3：5 角色和 copilot 是什么关系？

**A**：
- **5 角色**（Spec-Writer / Builder / Reviewer / Shipper / Keeper）：体系定义的逻辑角色
- **6 copilot**（pre-sales / product / dev / testing / delivery / project）：Claude-Code 参考实现

**关键声明**（见 [06-参考实现/README.md](../06-参考实现/README.md)）：
- 1 角色 = 多 copilot 可承担（Spec-Writer ← pre-sales + product）
- 1 copilot = 可跨角色（dev-copilot 既做 Builder 又部分承担 Reviewer）
- copilot 是**参考样例**，不是标准；用户可用任意 AI 工具替代

### Q4：HITL 不可逆等级 L1-L4 怎么用？

**A**：定义见 `00-理论层/03-HITL模式与不可逆性矩阵.md`：
- **L1** 触发级（用户唤起 AI）
- **L2** 可逆（产物文件、代码提交）
- **L3** 可逆但代价高（需求共识、方案、PRD）→ 强制 HITL-In
- **L4** 不可逆（生产部署、DB 迁移、客户验收）→ 强制 HITL-In + 多人签

完整 DSBL × HITL × 角色 交叉矩阵见 `03-执行层/03-HITL规则表.md`。

### Q5：必须按 D→S→B→Ship→L 顺序走吗？

**A**：不一定。`00-理论层/01-DSBL阶段模型与Loop微循环原理.md` §项目类型路由给了 3 种走法：
- **瀑布型**：D→S→B→Ship→L 全程一次
- **迭代 MVP**：Sprint 1 只走 D/S 部分，后续 Sprint 补回 B/Ship
- **敏捷型**：每 Sprint 走完整 S→B→Ship 闭环

---

## 二、工具中立与适配

### Q6：本体系是否依赖 Claude Code？

**A**：**不依赖**。体系标准层（[01-标准层/](../01-标准层/)）+ 产物层（[02-产物层/](../02-产物层/)）是纯 markdown，任意能「读 markdown + 执行 prompt + 生成产物」的 AI 工具都能接入。

Claude Code 只是首选参考实现之一。

### Q7：怎么选适配方案？

**A**：见 [05-适配层/README.md](../05-适配层/README.md) 决策树：

```
单一 Claude Code ──────→ Claude-Code 适配
单一 Codex ────────────→ Codex 适配
单一 Cursor ───────────→ Cursor 适配
混合多工具 ────────────→ 各自适配 + 自带工具兜底
自研/未列工具 ──────────→ 自带工具适配
不确定 ────────────────→ 先用 Claude-Code（参考实现已就绪）
```

### Q8：自带工具如何接入？

**A**：见 [05-适配层/自带工具适配指南.md](../05-适配层/自带工具适配指南.md)，3 种形态：
- **形态 A（Prompt 模板派）**：通义灵码/文心快码/Copilot Chat，复制模板到 prompt 库
- **形态 B（Agent 编排派）**：Dify/扣子/自研 LangChain Agent，按 5 角色建 Agent
- **形态 C（IDE 集成派）**：自研 IDE 插件/WorkBuddy，RAG 加载标准层

最小接入清单：能读模板 / 能写 handoff.yaml / L3-L4 能暂停 / 能跑 QG checklist / 能解析上游 handoff。

### Q9：工具中立性如何校验？

**A**：
```bash
./install.sh --check-neutral
```
或手动：
```bash
grep -rn "Claude Code\|Codex\|Cursor" 01-标准层/ 00-理论层/  # 应仅在业界共识引用中
```

工具名只允许在 `00-理论层/02-业界共识` / `05-适配层/` / `06-参考实现/` / handoff.yaml 的 `tool_used` 字段出现。

---

## 三、DSBL 阶段与 Loop 微循环

### Q10：Loop 微循环 5 字段是什么？

**A**：`01-标准层/02-Loop微循环规范.md` 定义：
1. **Plan**：本阶段要做什么（产出物 + 验收标准）
2. **Act**：执行（AI + 人 + 工具）
3. **Observe**：客观 Eval（覆盖率/通过率/响应时间等数字指标）
4. **Reflect**：主观人审（HITL 合规）
5. **Exit**：满足退出条件 → 写 handoff.yaml → 交接下游

### Q11：为什么 Observe 和 Reflect 分开？

**A**：
- **Observe（客观）**：工具跑出来的数字（unit_coverage=0.92），AI 自评无主观成分
- **Reflect（主观）**：人审「这真的是用户想要的吗？」「架构合理吗？」

分开避免「数字好看但产物错」的陷阱。详见 `01-标准层/02-Loop微循环规范.md`。

### Q12：DSBL 和 Loop Engineering / 敏捷的关系？

**A**：
| 维度 | Scrum/Kanban | Loop Engineering | 本体系 |
|------|-------------|-----------------|--------|
| 颗粒度 | Sprint（2-4 周） | 任务级 4 步 | Sprint × DSBL × Loop 5 字段 |
| AI 协作 | 不涉及 | 核心设计 | 五角色 × HITL × QG |
| 度量 | Velocity | — | 38 KPI + handoff.yaml 链 |
| 风险管理 | 风险登记册 | — | 不可逆性矩阵 + Checkpoint |
| 跨智能体 | 不涉及 | — | handoff YAML 强制交接 |

**关系**：DSBL 嵌套在敏捷外环内，给每个 Sprint 提供阶段级工序标准和 AI 协作模式。

---

## 四、HITL 模式选择

### Q13：什么时候用 HITL In / On / Fallback？

**A**：见 `00-理论层/03-HITL模式与不可逆性矩阵.md`：

| L 级 | 不可逆性 | HITL 模式 | 代表阶段 |
|------|---------|---------|---------|
| L4 | 不可逆（生产部署/DB 迁移） | **In** | Ship 部署 / Ship 验收 |
| L3 | 可逆但代价高 | **In** | D 共识 / S 方案 |
| L2 | 可逆（产物文件） | **On / Fallback** | B 编码（关键模块 On，CRUD Fallback） |
| L1 | 触发级 | — | 用户唤起 AI |

完整交叉矩阵见 `03-执行层/03-HITL规则表.md`。

### Q14：73% HITL 这个数字哪来的？

**A**：**Anthropic 2026-02 论文**实证数据（详见 `00-理论层/02-业界共识与权威锚点.md`）：
- 73% 任务含 HITL 节点
- 27% 全 AI 自主（其中只有 0.8% 是无任何监督的纯自主闭环）

**推广口径**：AI 自动化的是回路里的重复劳动，不是替代人。

### Q15：Fallback 模式下出问题怎么办？

**A**：Fallback 有「安全网」：
- 产物级：Git history + atomic commit（小步提交，可回滚）
- 项目级：Checkpoint 快照 + rollback.sh
- 全局级：QG 门禁（不通过不让进下一阶段）

---

## 五、Claude Code 使用

### Q16：触发语不响应？

**A**：排查顺序：
1. `ls ~/.claude/skills/ | grep copilot` —— 是否装了
2. 触发语拼写 —— 参考各 Playbook 第 1 节
3. 当前会话是否被其他 copilot 占用 —— `/clear` 后重试
4. skill.md 是否有语法错误 —— `cat ~/.claude/skills/pre-sales-copilot/skill.md | head`

### Q17：Claude 找不到技能？

**A**：
```bash
# 检查
ls ~/.claude/skills/
# 应有 6 copilot + 18 skills

# 没有就重装
cd ai-project-engineering
./install.sh --adapter claude-code
```

### Q18：每个 copilot 的 skill.md §8 是什么？

**A**：体系强制约束节（DSBL × HITL × QG × 交接契约），包含：
- DSBL 阶段覆盖与 HITL 模式表
- 阶段交接契约（handoff.yaml）处理规则
- QG-D/S/B/Ship 引用
- 产物模板 + 工具引用

让 Claude 真正执行 HITL/契约，不只停留在人读文档。

### Q19：6 copilot 是否必须全装？

**A**：**不**。最小化部署只装 1 个（如 dev-copilot 走 Builder 角色），其余靠 Claude Code 原生路由。详见 [05-适配层/Claude-Code适配指南.md](../05-适配层/Claude-Code适配指南.md)。

---

## 六、其他工具接入

### Q20：Cursor 怎么用？

**A**：
```bash
./install.sh --adapter cursor
```
生成 `.cursorrules` + `.cursor/rules/{role}.mdc` + QG .mdc。详见 [05-适配层/Cursor适配指南.md](../05-适配层/Cursor适配指南.md)。

Cursor 强项在 B 阶段（编码）。D（需求）和 Ship（部署）建议配合外部工具或 Claude-Code/Codex。

### Q21：Codex 怎么用？

**A**：
```bash
./install.sh --adapter codex
```
生成 `AGENTS.md` + `.codex/roles/`。详见 [05-适配层/Codex适配指南.md](../05-适配层/Codex适配指南.md)。

Codex 用 AGENTS.md 约定而非 skill 包，模板/schema 原样可用。

### Q22：自研 Agent 怎么接入？

**A**：参考 [05-适配层/自带工具适配指南.md](../05-适配层/自带工具适配指南.md) §六，把体系 5 份 Playbook 喂给 Agent，handoff.yaml 作为 Agent 间传递协议。

最小实现 QG-D + QG-B 两关即可（QG-S/QG-Ship 可人工 checklist 兜底）。

---

## 七、工具脚本

### Q23：snapshot.sh 报「缺少 mysqldump」？

**A**：
```bash
# Ubuntu/Debian
sudo apt install default-mysql-client
# macOS
brew install mysql-client
# Windows (Git Bash)
choco install mysql.cli  # 或用 WSL
```

或：`DB_TYPE=none` 跳过 DB 备份，只备份配置+AI 上下文。

### Q24：rollback.sh 在 CI/CD 怎么用？

**A**：
```bash
./rollback.sh --to <tag-timestamp> --yes
```
`--yes` 跳过双签确认。**生产环境禁用**，只用于预发/测试环境自动化。

### Q25：handoff.yaml 报「缺少必填字段」？

**A**：校验规则见 `01-标准层/04-阶段交接契约Schema.md`。必填：
```yaml
schema_version / from_stage / to_stage / quality_gate / gate_status /
output_artifacts / loop_signs / handoff (to_role+from_role) / hitl_signature
```

`gate_status: passed` 时还必须有 `exit_met: true` + 完整 `hitl_signature.approved_by`。

详见 `04-工具层/04-交接契约工具/validate-handoff.sh`。

### Q26：HTML 看板数据丢了？

**A**：浏览器 localStorage 可能被清（隐私模式 / 清缓存）。恢复：
1. 别再点「重置」
2. 从备份 CSV 导入：右上角「导入」选择 `loop-dashboard-*.csv`

**预防**：每周「导出 CSV」一次，归档到 `项目文档/{项目}/`。

---

## 八、数据存储与备份

### Q27：哪些数据存在哪里？

| 数据 | 位置 | 持久性 |
|------|------|--------|
| 项目文档（PRD/方案/代码） | Git 仓库 | 永久 |
| handoff.yaml 链 | `项目文档/{项目}/` | 永久（Git） |
| Checkpoint 快照 | `snapshots/{tag}-{timestamp}/` | 本地 / 备份策略决定 |
| Loop 度量看板数据 | 浏览器 localStorage | 易失（清缓存丢） |
| AI 上下文 backup | Checkpoint 内 `ai-context-backup.tar.gz` | 跟快照同生命周期 |

### Q28：handoff 链断了怎么排查？

**A**：
```bash
# 批量校验整个项目
./04-工具层/04-交接契约工具/validate-handoff.sh --batch \
   项目文档/{项目}/

# 看哪个文件 FAIL
# 看哪个 DSBL 阶段缺 YAML（应有 D/S/B/Ship 完整链）
```

---

## 九、定制与扩展

### Q29：能添加自己的 KPI 吗？

**A**：能。编辑 `04-工具层/02-Loop度量看板/` 内 HTML 的 `KPI_GROUPS` 常量，按现有结构追加 `{id, name, desc, target, type, direction}`。

`id` 必须全局唯一。改完刷新页面即生效。

### Q30：能添加新的角色/corps 吗？

**A**：能。两条路径：
1. **加角色**（体系扩展）：参考 `03-执行层/01-角色Playbook/` 5 份格式新增，但要更新 DSBL 覆盖矩阵
2. **加 copilot**（参考实现扩展）：参考 `06-参考实现/copilots/` 结构新增，必填 §1 触发场景 + §8 体系契约 + §9 启动流程

### Q31：能修改 QG checklist 吗？

**A**：能。编辑 `01-标准层/03-质量门禁QG-D至QG-Ship.md`。但注意：
- **修改即权威源**——其他位置全部引用本文件
- 修改后跑一遍 grep 确认无矛盾：`grep -rn "QG-" 03-执行层/ 06-参考实现/`

### Q32：能换 PRD 模板吗？

**A**：`02-产物层/S-Spec/PRD模板.md` 是唯一权威源。修改本文件即生效，但保留章节骨架（其他角色依赖此结构）。

示例项目示例不要写回模板正文，留在 `02-产物层/附录-示例项目示例集.md`。

### Q33：能在企业内网部署吗？

**A**：能。本体系无外部依赖（除选用的 AI 工具本身）：
- HTML 看板：纯原生 JS + SVG，无 CDN
- 脚本：bash + Python 标准库
- 校验：PyYAML（pip 装）

企业内网部署只需：
```bash
git clone <内网仓库>
./install.sh --adapter custom
```

---

## 反馈

未覆盖的问题 → 提 GitHub Issue，标签 `faq-request`。
