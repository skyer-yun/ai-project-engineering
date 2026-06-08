# Dev Copilot

> AI 研发全能副驾驶 —— 架构设计、详细设计、编码开发、代码审查、接口文档

---

## 1. 这是什么

Dev Copilot 是一个**研发编排技能**，覆盖从技术设计到编码交付的全流程：

- **架构设计**：选择架构模式、划分模块、技术选型、输出架构文档
- **详细设计**：接口设计、数据模型、时序图、输出详细设计文档
- **编码开发**：按规范实现代码、自测、提交
- **代码审查**：四维度审查、四级问题分级、输出审查报告
- **接口文档**：生成 OpenAPI/Swagger 或 Markdown 格式接口文档

### 核心理念

```
用户说一句话 → Dev Copilot 判断意图 → 调用正确的工作流 → 返回交付物
```

### 与 product-copilot 的关系

```
product-copilot（N1-N6）          dev-copilot（N7-N10）
  PRD + Demo + 设计规范    →      架构设计 → 编码 → 审查 → 联调

dev-copilot（N7-N10）             testing-copilot（N11+）
  源码 + 接口文档 + 联调    →     测试 + 部署 + 上线
```

### 覆盖的技能

| 能力 | 工作流 | 是否必须 |
|------|--------|----------|
| 架构设计 | architecture-workflow | 是（内置流程） |
| 详细设计 | detailed-design-workflow | 是（内置流程） |
| 编码开发 | coding-workflow | 是（内置流程） |
| 代码审查 | review-workflow | 是（内置流程） |
| 接口文档 | 日常路由 | 否 |
| 技术选型 | 日常路由 + 知识库 | 否 |

> Dev Copilot **不会**重新实现 Claude Code 原生的编码能力。它负责「判断 → 编排 → 衔接」。

---

## 2. 目录结构

```
04-dev-copilot/
├── README.md                              # 本文件：安装与使用指南
├── skill.md                              # 技能主文件：Agent 角色定义与核心流程
├── design.md                             # 设计文档（已有，不动）
│
├── config/                               # 配置文件
│   ├── dependencies.md                    #   技能依赖声明与检测规则
│   ├── triggers.md                        #   触发词关键词映射
│   └── roles.md                           #   角色定义与切换规则
│
├── workflows/                             # 工作流定义
│   ├── architecture-workflow.md           #   架构设计工作流
│   ├── detailed-design-workflow.md        #   详细设计工作流
│   ├── coding-workflow.md                 #   编码开发工作流
│   └── review-workflow.md                 #   代码审查工作流
│
├── knowledge/                             # 知识库
│   ├── tech-stacks/                       #   技术栈速查
│   │   └── README.md                      #     React/Vue/Node.js/Python + 决策树
│   └── architecture-patterns/             #   架构模式速查
│       └── README.md                      #     单体/微服务/Serverless/事件驱动 + 决策树
│
└── memory/                                # 记忆文件（用户可编辑）
    └── preferences.md                     #   用户偏好设置
```

### 文件分类说明

| 类别 | 路径 | 说明 | 是否需要用户修改 |
|------|------|------|------------------|
| 核心 | skill.md | Agent 角色与流程 | 不需要 |
| 配置 | config/* | 触发词、依赖、角色 | 按需定制 |
| 流程 | workflows/* | 各场景工作流 | 按需定制 |
| 知识 | knowledge/* | 技术栈/架构模式参考 | 按需扩展 |
| 记忆 | memory/* | 用户偏好 | **需要用户填写** |

---

## 3. 安装步骤

### 前提条件

- Claude Code CLI 已安装并配置
- 已安装 product-copilot（前置技能，提供 PRD 输入）
- Git（代码提交需要）

### 安装

**第 1 步：复制技能目录**

```bash
cp -r 04-dev-copilot/ ~/.claude/skills/dev-copilot/
```

**第 2 步：验证安装**

```bash
ls ~/.claude/skills/dev-copilot/
# 应看到：README.md  skill.md  design.md  config/  workflows/  knowledge/  memory/
```

**第 3 步：检查依赖技能**

打开 `config/dependencies.md`，对照其中列出的技能，确认哪些已安装。

**第 4 步：首次运行**

在 Claude Code 中输入任意研发相关请求即可触发，例如：

```
帮我做架构设计
根据这个PRD设计系统架构
审查一下这个模块的代码
```

**30 秒验证**

```
测试 1："根据PRD做架构设计"
  → 应触发 dev-copilot 架构设计工作流
  → Agent 应显示启动问候 + 依赖检测结果

测试 2："帮我写个 React 组件"
  → 应由 Claude Code 原生路由直接处理
  → dev-copilot 不应介入
```

### 卸载

```bash
rm -rf ~/.claude/skills/dev-copilot/
```

---

## 4. 触发示例

| 你说的话 | Agent 识别为 | 调用工作流 |
|----------|-------------|-----------|
| "根据PRD做架构设计" | 架构设计 | architecture-workflow |
| "先做架构再写详细设计" | 架构→详细设计编排 | architecture → detailed-design |
| "实现这个模块的代码" | 编码开发 | coding-workflow |
| "审查一下代码质量" | 代码审查 | review-workflow |
| "做个技术选型" | 日常路由 | 参考 knowledge/tech-stacks/ |
| "写个接口文档" | 日常路由 | 生成 OpenAPI/Swagger |
| "继续上次那个模块" | 上下文恢复 | 读取原生记忆 |

---

## 5. 生命周期覆盖（N7-N10）

| 阶段 | 编号 | 本技能工作流 | 核心产物 |
|------|------|-------------|---------|
| 技术设计 | N7 | architecture-workflow + detailed-design-workflow | 架构文档 + 详细设计文档 |
| 编码开发 | N8 | coding-workflow | 源码 + 单元测试 |
| 代码审查 | N9 | review-workflow | 审查报告 |
| 联调集成 | N10 | coding-workflow（联调扩展） | 联调报告 + 接口文档 |

---

## 6. 定制指南

### 6.1 config/ — 添加触发词/依赖/角色

参考 product-copilot 的定制方式，修改对应配置文件即可。

### 6.2 knowledge/ — 添加技术栈/架构模式

在 `knowledge/tech-stacks/` 或 `knowledge/architecture-patterns/` 下添加新的 `.md` 文件。

### 6.3 memory/ — 偏好设置

编辑 `memory/preferences.md` 填写你的技术栈偏好、编码习惯等。

---

## 7. 组件关系矩阵

| 修改的文件 | 需要检查 | 原因 |
|-----------|----------|------|
| `config/dependencies.md` | `skill.md` | 新增依赖可能需要更新工作流路由 |
| `config/triggers.md` | `config/roles.md` | 新触发词可能需要匹配对应角色 |
| `config/roles.md` | `workflows/*` | 新角色可能需要配套工作流 |
| `knowledge/tech-stacks/*` | `config/triggers.md` | 新技术栈可能需要添加触发关键词 |
| `workflows/*` | `config/dependencies.md` | 新工作流可能引入新的技能依赖 |
| `memory/preferences.md` | 无 | 用户偏好独立，不影响其他文件 |
| `skill.md` | 所有文件 | 核心流程变更需要全量检查 |

---

## 版本历史

| 版本 | 日期 | 更新内容 |
|------|------|----------|
| 1.0.0 | 2026-05-22 | 初始版本：4 工作流 + 2 知识库 + 角色系统 + 依赖管理 |
