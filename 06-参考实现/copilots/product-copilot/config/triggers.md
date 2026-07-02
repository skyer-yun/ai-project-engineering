# 意图触发映射

> 本文件为意图识别的**兜底参考**。优先使用 LLM 语义理解判断意图，仅在置信度不足时查阅此文件进行关键词匹配。
> 单一技能可完成的任务（纯写PRD、纯做Demo等）由 Claude Code 原生路由直接处理，不经过本技能。

## 工作流触发

| 关键词 | 工作流 | 优先级 |
|--------|--------|--------|
| 写PRD / 需求文档 / 产品需求 / 需求分析 / 写需求 | prd-workflow | 高 |
| 做Demo / 原型 / 前端页面 / Web应用 / 落地页 / 系统演示 | demo-workflow | 高 |
| WBS / 甘特图 / 进度 / 风险管理 / 项目计划 / 排期 / 项目汇报 | project-management-workflow | 高 |
| 标注需求 / 添加备注 / PRD标注 / 挂载需求 / 产品备注 | prd-notes（直接调用技能） | 高 |

## 技能直接触发

| 关键词 | 技能 | 产物 | 说明 |
|--------|------|------|------|
| Landing / 营销页 / 官网 / 海报 / 活动页 | frontend-design | HTML | 营销类页面 |
| Dashboard / 管理后台 / 工具界面 / SaaS / 数据平台 | interface-design | HTML | 功能型界面 |
| 动效 / 微交互 / 过渡动画 / 交互细节 | interaction-design | HTML/CSS | 交互打磨 |
| Word / 报告 / docx / 方案文档 | docx | .docx | Word 文档 |
| PPT / 演示 / 汇报 / pitch / pptx | pptx | .pptx | 演示文稿 |
| Excel / 表格 / 数据分析 / xlsx | xlsx | .xlsx | 电子表格 |
| PDF / 合并PDF / 拆分PDF / 转PDF | pdf | .pdf | PDF 操作 |
| 搜索 / 查资料 / 网页 / 联网 / 抓取 | web-access | — | 联网操作 |
| 流程图 / 架构图 / 时序图 | DrawIO MCP | .drawio | 图表 |
| 头脑风暴 / 发散 / 创意 / 探索 | brainstorming | — | 创意发散 |

## 角色自动切换

| 场景关键词 | 默认角色 | 关注点偏移 |
|-----------|---------|-----------|
| PRD / 需求 / 用户故事 / 功能 | 产品经理 | 用户价值、功能完整性 |
| 排期 / 里程碑 / 资源 / 风险 | 项目经理 | 交付质量、时间节点 |
| 技术选型 / 架构 / 性能 / 安全 | 技术顾问 | 技术可行性 |
| 竞品 / 市场 / 定位 / 商业 | 产品经理（战略视角） | 市场竞争、商业模式 |

## 匹配规则

```
1. 精确匹配 → 直接触发对应工作流/技能
2. 包含匹配 → 按优先级匹配第一个命中项
3. 多关键词 → 取最高优先级
4. 无法匹配 → 使用 daily-workflow + 询问用户意图

优先级：工作流触发 > 技能触发 > 角色切换 > 日常工作流
```

## 组合场景识别

| 场景 | 技能组合 | 顺序 |
|------|---------|------|
| 完整产品交付 | write-a-prd → ai-product-dev-kit-modular → prd-notes | PRD → Demo → 标注 |
| Demo + 排期 | ai-product-dev-kit-modular → project-manager | Demo → WBS/甘特图 |
| PRD + 项目计划 | write-a-prd → project-manager | PRD → 项目规划 |
| 竞品调研 | web-access → write-a-prd | 采集 → 分析文档 |
| 会议汇报 | docx（会议纪要）/ pptx（演示） | 按需 |
