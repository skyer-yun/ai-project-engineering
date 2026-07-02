# user-trainer 依赖配置

## 核心依赖

| 依赖 | 类型 | 版本要求 | 用途 | 缺失影响 |
|------|------|----------|------|----------|
| 06-delivery-copilot | 技能 | >=1.0 | 交付上下文、部署/验收信息 | 降级为独立模式 |
| docx | 技能 | >=1.0 | 操作手册 Word 文档输出 | 操作手册仅 Markdown |

## 增强依赖

| 依赖 | 类型 | 版本要求 | 用途 | 缺失影响 |
|------|------|----------|------|----------|
| pptx | 技能 | >=1.0 | 培训课件 PPT 输出 | 课件仅 Markdown 大纲 |

## 依赖检测流程

```
1. 检测 06-delivery-copilot
   - 读取 ~/.claude/skills/06-delivery-copilot/skill.md
   - 存在 → 加载交付上下文（部署方案/验收标准/运维手册）
   - 不存在 → 标记为独立模式

2. 检测 docx
   - 读取 ~/.claude/skills/docx/skill.md
   - 存在 → 启用 .docx 输出
   - 不存在 → 仅 Markdown

3. 检测 pptx
   - 读取 ~/.claude/skills/pptx/skill.md
   - 存在 → 启用 .pptx 输出
   - 不存在 → 仅 Markdown 大纲
```

## 降级策略

| 场景 | 降级方案 |
|------|----------|
| 06-delivery-copilot 缺失 | 独立模式，需要用户手动提供产品功能说明 |
| docx 缺失 | 操作手册输出 Markdown 格式，用户可自行转换 |
| pptx 缺失 | 培训课件输出 Markdown 大纲格式，用户可自行制作 PPT |
| docx + pptx 都缺失 | 全部输出 Markdown，提供格式建议 |
