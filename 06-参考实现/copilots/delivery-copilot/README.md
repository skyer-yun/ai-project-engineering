# Delivery Copilot

> AI 交付全能副驾驶 -- 编排部署实施、验收管理、交付文档生成，覆盖 交付后半 阶段

---

## 1. 这是什么

Delivery Copilot 是一个**交付智能体**，它本身不重新实现任何功能逻辑，而是：

- **感知意图**：根据用户输入判断需要什么类型的交付活动
- **调用技能**：自动调用已安装的专业 Skill 完成交付工作
- **管理上下文**：维护交付偏好、部署记录、验收状态，跨会话保持一致性

### 核心理念

```
用户说一句话 → Delivery Copilot 判断意图 → 调用正确的工作流/技能 → 返回交付物
```

### 调用的技能

| 技能 | 用途 | 是否必须 |
|------|------|----------|
| docx | 交付文档 Word 输出 | 否，缺失时输出 Markdown |
| pptx | 培训材料/演示文稿 | 否，缺失时输出 Markdown |
| deployment-planner（未安装） | 部署方案自动生成 | 否，缺失时使用内置模式 |
| acceptance-manager（未安装） | 验收测试管理 | 否，缺失时使用内置流程 |
| delivery-doc-generator（未安装） | 交付文档批量生成 | 否，缺失时使用内置模板 |
| pdf | 文档 PDF 输出 | 否 |
| xlsx | 验收清单/检查表 | 否 |
| brainstorming | 部署风险发散 | 否 |

---

## 2. 目录结构

```
06-delivery-copilot/
├── README.md                          # 本文件
├── skill.md                          # 技能主文件
├── design.md                         # 设计文档（已有）
│
├── config/
│   ├── dependencies.md                #   技能依赖声明
│   ├── triggers.md                    #   触发词映射
│   └── roles.md                       #   角色定义
│
├── workflows/
│   ├── deployment-workflow.md         #   部署管理流程
│   ├── acceptance-workflow.md         #   验收管理流程
│   └── delivery-doc-workflow.md       #   交付文档流程
│
├── knowledge/
│   ├── deployment-patterns/           #   部署模式速查
│   │   └── README.md                  #     Docker/K8s/云服务/私有化
│   └── doc-templates/                 #   文档模板
│       └── README.md                  #     用户手册/运维手册/培训/验收报告
│
└── memory/
    └── preferences.md                 #   用户偏好
```

---

## 3. 安装步骤

```bash
cp -r 06-delivery-copilot/ ~/.claude/skills/delivery-copilot/
```

---

## 4. 依赖检测与降级

| 缺失技能 | 降级行为 | 影响 |
|----------|----------|------|
| docx | 输出 Markdown 格式 | 需手动转换为 Word |
| pptx | 输出 Markdown 格式 | 需手动制作 PPT |
| deployment-planner | 使用内置部署模式库 | 方案需人工补充细节 |
| pdf | 不提供 PDF 输出 | 仅 Word/Markdown |

---

## 5. 上下游智能体协作

```
前置（← testing-copilot）：
  - 测试报告（All Pass / 条件通过）
  - 缺陷清单（P0/P1 已清零）
  - 源码（已冻结的发布版本）

后置（→ project-copilot）：
  - 交付文档包
  - 验收报告（客户签字版）
  - 运维手册（含应急预案）
```

---

## 版本历史

| 版本 | 日期 | 更新内容 |
|------|------|----------|
| 1.0.0 | 2026-05-22 | 初始版本：3 个工作流 + 4 角色 + 部署模式知识库 + 文档模板 |
