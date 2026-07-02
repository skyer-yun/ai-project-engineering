# 05-适配层

> **定位**：本目录是「工具中立适配层」，把体系标准与具体 AI 工具解耦。
>
> **核心承诺**：本体系的 [01-标准层/](../01-标准层/) + [02-产物层/](../02-产物层/) + [03-执行层/](../03-执行层/) **不绑定任何具体 AI 工具**。任意支持"读 markdown + 执行 prompt + 生成产物"的 AI 工具都能接入本体系。

---

## 文件清单

| 文件 | 用途 |
|------|------|
| [Claude-Code适配指南.md](./Claude-Code适配指南.md) | Anthropic Claude Code CLI 适配方案 |
| [Codex适配指南.md](./Codex适配指南.md) | OpenAI Codex / GPT 工具适配方案 |
| [Cursor适配指南.md](./Cursor适配指南.md) | Cursor IDE 适配方案 |
| [自带工具适配指南.md](./自带工具适配指南.md) | 用户自带任意 AI 工具接入指南 |
| [README.md](./README.md) | 本文件 |

---

## 适配原则

### 1. 体系是契约，工具是执行者

体系定义：
- **DSBL 五阶段**（D/S/B/Ship/L）
- **Loop 微循环**（Plan/Act/Observe/Reflect/Exit）
- **质量门禁**（QG-D/S/B/Ship）
- **交接契约**（YAML Schema）
- **HITL 模式**（In/On/Fallback）
- **产物模板**（markdown 格式）

工具执行：
- 读模板 → 填字段 → 生成产物
- 跑 Eval（客观指标）
- 人审 / 自动审（主观判断）
- 写交接契约

### 2. 1 角色 = 多工具可承担

- Spec-Writer 可同时用 Claude Code + Codex
- Builder 可用 Cursor 写代码 + Claude Code 跑审查
- 用户自选组合，体系不强求

### 3. 1 工具 = 多角色可承担

- 同一 Claude Code 会话可切换角色（Spec-Writer → Builder）
- 同一 copilot 可跨阶段（详见 [06-参考实现/](../06-参考实现/)）

### 4. 适配是双向的

- 体系 → 工具：体系约定规则，工具按规则执行
- 工具 → 体系：工具反馈执行痛点，体系演进

---

## 选适配方案的决策树

```
你的团队主要用什么 AI 工具？
   ↓
单一 Claude Code ──────→ Claude-Code 适配
单一 Codex ────────────→ Codex 适配
单一 Cursor ───────────→ Cursor 适配
混合多工具 ────────────→ 各自适配 + 自带工具兜底
自研/未列工具 ──────────→ 自带工具适配
不确定 ────────────────→ 先用 Claude-Code（参考实现已就绪）
```

---

## 部署方式

详见 [install.sh](../install.sh)：

```bash
./install.sh --adapter claude-code   # 部署参考实现到 ~/.claude/skills/
./install.sh --adapter codex         # 转换为 AGENTS.md 部署到 ~/.codex/
./install.sh --adapter cursor        # 转换为 .cursorrules 部署到 .cursor/
./install.sh --adapter custom        # 只部署模板+schema+QG checklist
./install.sh --templates-only        # 只部署体系模板（产物层/标准层）
./install.sh --tools                 # 部署 snapshot/rollback/validate-handoff 到 ~/bin/
```

**核心**：体系标准层和产物层模板始终部署（工具无关）；参考实现按适配方案可选部署。

---

## 工具中立性校验

执行 [install.sh --check-neutral](../install.sh) 或手动校验：

```bash
# 体系标准层不应出现具体工具名
grep -rn "Claude Code\|Codex\|Cursor" 01-标准层/ 00-理论层/  → 应仅在业界共识引用中出现
grep -rn "Claude Code\|Codex\|Cursor" 02-产物层/ 03-执行层/  → 应仅在适配引用中出现
```

工具名只允许在：
- [00-理论层/02-业界共识与权威锚点.md](../00-理论层/02-业界共识与权威锚点.md)（业界引用）
- [05-适配层/](./) （适配指南本身）
- [06-参考实现/](../06-参考实现/) （参考样例）
- 交接契约的 `tool_used` 字段（记录用，非依赖）

---

*本目录是工具中立适配层。新增 AI 工具适配方案时，按本目录现有 5 份指南的格式新增。*
