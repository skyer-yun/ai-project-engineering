# 依赖配置

> 测试用例生成器无硬性依赖，增强依赖缺失时降级为 Markdown 输出

## 核心依赖

无。

## 增强依赖（可选）

| 技能 | 用途 | 检测路径 | 缺失降级 |
|------|------|---------|---------|
| docx | 测试用例 Word 输出 | ~/.claude/skills/docx/ | 输出 Markdown |
| xlsx | 测试用例 Excel 输出 | ~/.claude/skills/xlsx/ | 输出 Markdown 表格 |

## 检测方式

```bash
for skill in docx xlsx; do
  if [ -d ~/.claude/skills/$skill ]; then
    echo "OK $skill"
  else
    echo "-- $skill (未安装，Markdown 输出)"
  fi
done
```
