# 依赖配置

> 产品助手通过检测本地路径判断技能是否安装，缺失时不影响其他功能

## 核心依赖（必须）

| 技能包 | 用途 | 检测路径 |
|--------|------|---------|
| ai-product-dev-kit-modular | Demo/PRD/标注/多文件模块化 | ~/.claude/skills/ai-product-dev-kit-modular/skill.md |
| write-a-prd | PRD 编写（4 种方式/12 部分结构） | ~/.claude/skills/write-a-prd/SKILL.md |

## 增强依赖（可选）

| 技能包 | 用途 | 检测路径 |
|--------|------|---------|
| project-manager | 项目管理（4 阶段/4 项目类型） | ~/.claude/skills/project-manager/skill.md |
| prd-notes | PRD 页面标注（初始化/增量更新） | ~/.claude/skills/prd-notes/SKILL.md |
| frontend-design | 营销/Landing 页面设计 | ~/.claude/skills/frontend-design/SKILL.md |
| interface-design | Dashboard/管理后台界面设计 | ~/.claude/skills/interface-design/SKILL.md |
| interaction-design | 微交互/动效设计 | ~/.claude/skills/interaction-design/SKILL.md |
| docx | Word 文档生成 | ~/.claude/skills/docx/ |
| pptx | PPT 演示文稿 | ~/.claude/skills/pptx/ |
| xlsx | Excel 电子表格 | ~/.claude/skills/xlsx/ |
| pdf | PDF 操作 | ~/.claude/skills/pdf/ |
| web-access | 联网操作/搜索/网页抓取 | ~/.claude/skills/web-access/ |
| brainstorming | 创意发散/需求探索 | ~/.claude/skills/brainstorming/ |
| ui-ux-pro-max | UI/UX 设计智能（50+ 风格/161 色板/10 技术栈） | ~/.claude/skills/ui-ux-pro-max/ |
| design-lab | 设计访谈 + 5 种 UI 变体对比 | ~/.claude/skills/design-lab/ |

## 工具依赖（内置，无需安装）

| 工具 | 位置 | 版本 | 说明 |
|------|------|------|------|
| visual-editor | ai-product-dev-kit-modular/tools/visual-editor/ | v4.1 | 可视化 HTML 编辑器（注入版） |
| visual-editor-extension | ai-product-dev-kit-modular/tools/visual-editor-extension/ | v4.1 | Chrome 扩展版 |
| annotation-runtime | ai-product-dev-kit-modular/tools/ | v1.3 | 标注运行时 JS |

## 设计系统资源（本地参考）

| 系统 | 路径 | 文件数 | 适用场景 |
|------|------|--------|---------|
| Ant Design Pro | C:/Users/Admin/ant-design-pro设计系统/ | 18 | 中后台/Dashboard |
| TDesign | C:/Users/Admin/tdesign设计系统/ | 15 | 腾讯系项目 |
| Element Plus | C:/Users/Admin/element-plus设计系统/ | 13 | Vue 生态/政企 |
| Arco Design | C:/Users/Admin/arco-design设计系统/ | 14 | 字节系/现代化后台 |
| Semi Design | C:/Users/Admin/semi-design设计系统/ | 13 | 暗色模式/多品牌 SaaS |
| shadcn/ui | C:/Users/Admin/shadcn-ui设计系统/ | 13 | React + Tailwind/Next.js |

每套目录结构：README.md + 开发指南 + tokens/(色彩/排版/间距/动画) + components/(按钮/表单/数据展示/反馈/导航) + patterns/(布局/仪表盘)

## 降级策略

```
缺失技能时的处理：
  write-a-prd 未安装 → 使用 ai-product-dev-kit-modular 内置 12 部分模板
  project-manager 未安装 → 使用 ai-product-dev-kit-modular 内置轻量项目管理
  frontend-design 未安装 → 降级为 interface-design
  interface-design 未安装 → 降级为 frontend-design
  docx/pptx/xlsx 未安装 → 输出 Markdown 格式
```

## 检测方式

```bash
# 逐一检测技能是否存在
for skill in ai-product-dev-kit-modular write-a-prd project-manager prd-notes; do
  if [ -f ~/.claude/skills/$skill/skill.md ] || [ -f ~/.claude/skills/$skill/SKILL.md ]; then
    echo "✅ $skill"
  else
    echo "⬜ $skill (未安装)"
  fi
done
```
