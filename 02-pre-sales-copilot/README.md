# pre-sales-copilot

售前专家智能体，覆盖 N1-N4 全阶段：需求收集与分析、技术方案编写、投标文件、客户演示。

## 安装

将 `02-pre-sales-copilot/` 目录复制到 `~/.claude/skills/pre-sales-copilot/`。

### 依赖

**核心**（必须安装）：
- `technical-proposal-writer` — 技术方案生成
- `web-access` — 联网搜索

**增强**（可选）：
- `brainstorming` — 发散思维
- `docx` — Word 文档输出
- `pptx` — PPT 输出
- `xlsx` — Excel 输出
- `pdf` — PDF 读取
- `product-copilot` — 自动交接

## 触发示例

| 用户输入 | 匹配工作流 | 角色 |
|----------|-----------|------|
| "写一份技术方案" | proposal-workflow | 售前方案工程师 |
| "分析一下客户需求" | requirement-workflow | 售前方案工程师 |
| "对比一下竞品" | requirement-workflow（竞品分支） | 市场分析师 |
| "准备投标文件" | bid-workflow | 商务顾问 |
| "做一个客户演示PPT" | demo-presentation-workflow | 演示工程师 |

## 生命周期覆盖

```
N1 需求收集 → N2 需求分析 → N3 方案编写 → N4 方案评审
     |              |              |              |
  requirement    requirement    proposal       bid
  -workflow      -workflow      -workflow     -workflow
                               demo-presentation
                                -workflow
```

### N1-N2：需求收集与分析

- 收集客户原始需求
- 结构化整理与分类
- 需求优先级排序
- 可选：竞品分析
- 产出：需求分析报告

### N3：方案编写

- 标准 11 章技术方案
- 7 章解决方案
- 8 章架构设计
- 架构图生成
- 产出：技术方案文档

### N3-N4：投标文件

- 招标文件解析
- 技术标编写
- 商务标编写
- 格式化自检
- 产出：投标全套文件

### N3-N4：客户演示

- 演示规划
- PPT 制作
- 配套材料
- 产出：演示 PPT + 大纲

## 定制

### 添加行业方案

在 `knowledge/industry-solutions/` 下新增行业目录：

```
knowledge/industry-solutions/
├── README.md          # 行业索引
├── government.md      # 政务（已有）
├── finance.md         # 金融（已有）
├── education.md       # 教育（已有）
└── {新行业}.md        # 新增
```

### 添加方案模板

在 `knowledge/proposal-templates/` 下新增模板。

### 修改触发规则

编辑 `config/triggers.md` 添加新的关键词或工作流映射。

## 版本历史

| 版本 | 日期 | 说明 |
|------|------|------|
| v1.0 | 2026-05-22 | 初始版本，4 工作流 + 4 角色 + 3 知识库 |
