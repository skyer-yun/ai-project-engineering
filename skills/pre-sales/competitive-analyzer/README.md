# Competitive Analyzer - 竞品分析

## 定位

竞品分析技能，支持 5维度矩阵对比 + SWOT分析，输出竞品分析报告和策略建议。

## 分析框架

### 5维度对比矩阵
| 维度 | 关键指标 |
|------|----------|
| 功能对比 | 功能覆盖度、差异化功能 |
| 技术对比 | 架构、性能、安全、集成 |
| 价格对比 | 定价模式、性价比 |
| 用户体验 | 界面、操作、评价、学习成本 |
| 市场定位 | 目标客户、份额、品牌 |

### SWOT 分析
- S（优势）/ W（劣势）/ O（机会）/ T（威胁）
- 交叉策略：SO增长 / WO转型 / ST防御 / WT生存

## 目录结构

```
competitive-analyzer/
  skill.md                            # 主技能文件
  config/
    dependencies.md                   # 依赖配置
    triggers.md                       # 触发关键词
    roles.md                          # 角色定义
  workflows/
    competitive-analysis.md           # 竞品分析工作流（4阶段）
  knowledge/
    analysis-frameworks/
      README.md                       # 分析框架说明
  memory/
    preferences.md                    # 用户偏好
```

## 依赖

- **核心**：`web-access`（联网获取竞品信息）
- **增强**：`brainstorming`（多角度分析）、`docx`（报告输出）

## 快速开始

1. 告诉我要分析的产品/领域
2. 自动识别核心竞品
3. 5维度对比 + SWOT分析
4. 输出竞品分析报告和策略建议
