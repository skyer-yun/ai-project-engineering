# 依赖定义

## 核心依赖（缺失则核心功能不可用）

### technical-proposal-writer

| 项目 | 说明 |
|------|------|
| 用途 | 技术方案自动生成，标准章节结构填充 |
| 检测路径 | `~/.claude/skills/technical-proposal-writer/skill.md` |
| 缺失影响 | 技术方案无法自动生成，需手动编写 |
| 降级方案 | 提供方案框架模板，手动引导用户逐章填写 |

### web-access

| 项目 | 说明 |
|------|------|
| 用途 | 联网搜索竞品信息、行业资讯、技术资料 |
| 检测路径 | `~/.claude/skills/web-access/skill.md` |
| 缺失影响 | 无法联网获取最新信息，竞品分析受限 |
| 降级方案 | 使用 knowledge/ 中的本地知识库数据，标注时效性 |

## 增强依赖（缺失降级但不阻断）

### brainstorming

| 项目 | 说明 |
|------|------|
| 用途 | 发散思维模式，方案设计前的创意探索 |
| 检测路径 | `~/.claude/skills/brainstorming/skill.md` |
| 缺失影响 | 无法使用发散-收敛思维模式 |
| 降级方案 | 直接进入方案编写，跳过发散阶段 |

### docx

| 项目 | 说明 |
|------|------|
| 用途 | 输出 .docx 格式文档 |
| 检测路径 | `~/.claude/skills/docx/skill.md` |
| 缺失影响 | 无法输出 Word 格式 |
| 降级方案 | 输出 .md 格式，用户可手动转存 |

### pptx

| 项目 | 说明 |
|------|------|
| 用途 | 输出 .pptx 格式演示文稿 |
| 检测路径 | `~/.claude/skills/pptx/skill.md` |
| 缺失影响 | 无法输出 PPT 格式 |
| 降级方案 | 输出 .md 大纲，用户可手动制作 PPT |

### xlsx

| 项目 | 说明 |
|------|------|
| 用途 | 输出 .xlsx 格式表格（报价单、功能清单等） |
| 检测路径 | `~/.claude/skills/xlsx/skill.md` |
| 缺失影响 | 无法输出 Excel 格式 |
| 降级方案 | 输出 .md 表格 |

### pdf

| 项目 | 说明 |
|------|------|
| 用途 | 读取 PDF 格式招标文件 |
| 检测路径 | `~/.claude/skills/pdf/skill.md` |
| 缺失影响 | 无法直接读取 PDF |
| 降级方案 | 提示用户将 PDF 内容复制为文本提供 |

### product-copilot

| 项目 | 说明 |
|------|------|
| 用途 | 售前到产品的自动交接 |
| 检测路径 | `~/.claude/skills/product-copilot/skill.md` |
| 缺失影响 | 无法自动启动产品阶段 |
| 降级方案 | 手动提示用户交接产物和下一步操作 |

## 降级策略总表

| 场景 | 缺失依赖 | 降级行为 |
|------|----------|----------|
| 技术方案编写 | technical-proposal-writer | 提供模板 + 手动引导 |
| 竞品分析 | web-access | 使用本地知识库 + 标注时效 |
| Word 输出 | docx | 输出 .md |
| PPT 输出 | pptx | 输出 .md 大纲 |
| Excel 输出 | xlsx | 输出 .md 表格 |
| PDF 读取 | pdf | 提示用户提供文本 |
| 产品交接 | product-copilot | 手动提示交接 |

## 检测脚本

启动时执行以下逻辑：

```
1. 扫描 ~/.claude/skills/ 目录
2. 对每个依赖检查 {skill-name}/skill.md 是否存在
3. 读取 YAML 头部确认 name 和 version
4. 分类结果：已安装核心 / 已安装增强 / 缺失核心 / 缺失增强
5. 缺失核心 → 提示安装 + 继续降级运行
6. 缺失增强 → 提示可选 + 正常运行
```

### 检测伪代码

```python
dependencies = {
    "core": ["technical-proposal-writer", "web-access"],
    "enhanced": ["brainstorming", "docx", "pptx", "xlsx", "pdf", "product-copilot"]
}

for category, skills in dependencies.items():
    for skill in skills:
        path = f"~/.claude/skills/{skill}/skill.md"
        if exists(path):
            status[f"installed_{category}"].append(skill)
        else:
            status[f"missing_{category}"].append(skill)
```
