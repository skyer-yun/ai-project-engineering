# Testing Copilot

> AI 测试全能副驾驶 -- 编排测试策略、用例设计、测试执行、缺陷管理，覆盖 N11-N12 阶段

---

## 1. 这是什么

Testing Copilot 是一个**测试智能体**，它本身不重新实现任何功能逻辑，而是：

- **感知意图**：根据用户输入判断需要什么类型的测试活动
- **调用技能**：自动调用已安装的专业 Skill 完成测试工作
- **管理上下文**：维护测试偏好、缺陷统计、质量指标，跨会话保持一致性

### 核心理念

```
用户说一句话 → Testing Copilot 判断意图 → 调用正确的工作流/技能 → 返回测试交付物
```

### 调用的技能

| 技能 | 用途 | 是否必须 |
|------|------|----------|
| test-case-generator（待建） | 测试用例自动生成 | 否，缺失时使用内置方法降级 |
| test-automator（待建） | 自动化测试脚本 | 否，缺失时提供手动步骤 |
| defect-analyzer（待建） | 缺陷根因分析 | 否，缺失时人工分析模式 |
| xlsx | 测试用例/缺陷表格 | 否，缺失时输出 Markdown |
| docx | 测试报告 Word | 否，缺失时输出 Markdown |
| brainstorming | 测试场景发散 | 否，缺失时使用内置清单 |
| web-access | 安全漏洞查询 | 否，缺失时使用知识库 |

> Testing Copilot **不会**重新实现这些 Skill 的逻辑。它只负责「判断 → 调度 → 拼装」。

---

## 2. 目录结构

```
05-testing-copilot/
├── README.md                          # 本文件：安装与使用指南
├── skill.md                          # 技能主文件：Agent 角色定义与核心流程
├── design.md                         # 设计文档（已有）
│
├── config/                            # 配置文件
│   ├── dependencies.md                 #   技能依赖声明与检测规则
│   ├── triggers.md                     #   触发词关键词映射
│   └── roles.md                        #   角色定义与切换规则
│
├── workflows/                          # 工作流定义
│   ├── test-strategy-workflow.md       #   测试策略制定流程
│   ├── test-case-workflow.md           #   测试用例设计流程
│   ├── test-execution-workflow.md      #   测试执行流程
│   └── defect-management-workflow.md   #   缺陷管理流程
│
├── knowledge/                          # 知识库
│   ├── test-methods/                   #   测试方法速查
│   │   └── README.md                   #     功能/边界值/性能/安全/兼容性 + 决策树
│   └── test-templates/                 #   测试模板
│       └── README.md                   #     测试方案/用例/报告/缺陷 模板结构
│
└── memory/                             # 记忆文件（用户可编辑）
    └── preferences.md                  #   用户偏好设置
```

### 文件分类说明

| 类别 | 路径 | 说明 | 是否需要用户修改 |
|------|------|------|------------------|
| 核心 | skill.md | Agent 角色与流程 | 不需要 |
| 配置 | config/* | 触发词、依赖、角色 | 按需定制 |
| 流程 | workflows/* | 各场景工作流 | 按需定制 |
| 知识 | knowledge/* | 测试方法/模板 | 按需扩展 |
| 记忆 | memory/* | 用户偏好 | **需要用户填写** |

---

## 3. 安装步骤

### 前提条件

- Claude Code CLI 已安装并配置
- 项目已进入测试阶段（开发完成/代码冻结）

### 安装

**第 1 步：复制技能目录**

```bash
cp -r 05-testing-copilot/ ~/.claude/skills/testing-copilot/
```

**第 2 步：验证安装**

```bash
ls ~/.claude/skills/testing-copilot/
# 应看到：README.md  skill.md  config/  workflows/  knowledge/  memory/
```

**第 3 步：首次运行**

在 Claude Code 中输入任意测试相关请求即可触发：

```
帮我制定测试策略
写个登录模块的测试用例
执行一轮冒烟测试
```

---

## 4. 依赖检测与降级

### 降级策略

| 缺失技能 | 降级行为 | 影响 |
|----------|----------|------|
| test-case-generator | 使用内置 6 种测试设计方法 | 用例需人工补充细节 |
| test-automator | 提供手动测试步骤 | 无自动化脚本 |
| defect-analyzer | 人工分析模式 | 根因分析依赖经验判断 |
| xlsx/docx | 输出 Markdown 格式 | 需手动转换为格式文档 |

---

## 5. 使用指南

### 5.1 触发示例

| 你说的话 | Agent 识别为 | 调用工作流 |
|----------|-------------|-----------|
| "制定测试策略" | 测试策略制定 | test-strategy-workflow |
| "写测试用例" | 测试用例设计 | test-case-workflow |
| "开始测试执行" | 测试执行 | test-execution-workflow |
| "报个Bug" | 缺陷记录 | defect-management-workflow |
| "联调完了开始测试" | 全流程衔接 | strategy → case → execution |
| "性能测试" | 性能测试 | 切换性能工程师角色 |

### 5.2 角色自动切换

| 角色 | 触发条件 | 关注点 |
|------|----------|--------|
| 测试经理 | 测试策略/计划/范围 | 测试规划、资源分配 |
| 测试设计师 | 用例设计/等价类/边界值 | 用例质量、覆盖率 |
| 自动化工程师 | 自动化/脚本/CI/CD | 自动化覆盖率 |
| 性能工程师 | 性能/压力/负载/并发 | 性能指标、瓶颈分析 |
| 安全工程师 | 安全/渗透/漏洞 | 安全风险、漏洞等级 |

---

## 6. 上下游智能体协作

```
前置（← dev-copilot）：
  - 源码（Git 仓库/分支）
  - 接口文档（API 规范/数据模型）
  - 联调报告（联调通过/待修复项）

后置（→ delivery-copilot）：
  - 测试报告（All Pass / 条件通过）
  - 缺陷清单（P0/P1 必须清零）
  - 性能测试报告（指标达标证明）
```

---

## 7. 组件关系矩阵

| 修改的文件 | 需要检查 | 原因 |
|-----------|----------|------|
| `config/dependencies.md` | `skill.md` | 新增依赖可能需要更新流程 |
| `config/triggers.md` | `config/roles.md` | 新触发词可能需要匹配角色 |
| `config/roles.md` | `workflows/*` | 新角色可能需要配套工作流 |
| `knowledge/test-methods/*` | `config/triggers.md` | 新方法可能需要触发关键词 |
| `workflows/*` | `config/dependencies.md` | 新工作流可能引入新依赖 |
| `memory/preferences.md` | 无 | 用户偏好独立 |

---

## 版本历史

| 版本 | 日期 | 更新内容 |
|------|------|----------|
| 1.0.0 | 2026-05-22 | 初始版本：4 个工作流 + 5 角色 + 测试方法知识库 + 缺陷管理 |
