# Dependencies - solution-architect

## 核心依赖（Core）

| 技能 | 用途 | 必要性 |
|------|------|--------|
| `docx` | 方案文档输出为 .docx 格式 | 必须，未安装降级为 Markdown |

## 增强依赖（Enhanced）

| 技能 | 用途 | 效果 |
|------|------|------|
| `technical-proposal-writer` | 复用方案写作经验、行业模板、措辞库 | 提升方案专业度和一致性 |
| `web-access` | 联网获取行业数据、竞品信息、技术趋势 | 增强数据支撑的准确性 |
| `brainstorming` | 方案创意发散、架构设计多方案对比 | 提升方案的深度和创新性 |

## 依赖检测逻辑

```
IF docx 可用:
  输出格式 = .docx
ELSE:
  输出格式 = Markdown
  提示: 安装 docx 技能可获得更好的文档体验

IF technical-proposal-writer 可用:
  加载行业模板和写作经验
ELSE:
  使用内置模板

IF web-access 可用:
  支持联网调研模式
ELSE:
  基于已有知识生成

IF brainstorming 可用:
  架构设计阶段先发散再收敛
ELSE:
  直接生成最佳方案
```
