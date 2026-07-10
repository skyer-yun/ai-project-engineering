# UI/UX 设计规范模板

> **阶段**：跨阶段（PRD 原型 + 架构视觉规范）
> **主责智能体**：product-copilot + dev-copilot
> **关联**：本规范为前端开发 + 视觉设计提供约束；Design Token 集中管理
> **示例参考**：[附录-示例项目示例集.md](./附录-示例项目示例集.md) §2.3

---

## 文档信息

| 项目 | 内容 |
|------|------|
| 项目名称 | {填写} |
| 文档编号 | {UIUX-{项目缩写}-2026-001} |
| 文档版本 | V1.0 |
| 编写日期 | {YYYY-MM-DD} |
| 设计师 | {姓名} |
| 评审状态 | 待评审 / 已评审 / 已通过 |

### 修订记录

| 版本 | 日期 | 修订人 | 修订内容 |
|------|------|--------|---------|
| V1.0 | {date} | {name} | 初始版本 |

---

## 正文

### 一、设计原则

- **一致性**：组件库统一，跨页面体验一致
- **简洁性**：少即是多；一页一焦点
- **反馈性**：每个操作必有反馈（视觉/听觉/触觉）
- **容错性**：可撤销；错误友好提示
- **可达性**：WCAG 2.1 AA 级

---

### 二、Design Token（统一引用）

> Design Token 必须集中管理，前端代码引用变量而非硬编码。
>
> **选择设计系统**（参考用户全局 CLAUDE.md）：

| 设计系统 | 适用场景 | 路径 |
|---------|---------|------|
| TDesign | 腾讯系项目 | `C:/Users/Admin/tdesign设计系统/` |
| Ant Design Pro | 中后台/Dashboard | `C:/Users/Admin/ant-design-pro设计系统/` |
| Element Plus | Vue 生态/政企 | `C:/Users/Admin/element-plus设计系统/` |
| Arco Design | 字节系/现代化后台 | `C:/Users/Admin/arco-design设计系统/` |
| Semi Design | 暗色模式/多品牌 SaaS | `C:/Users/Admin/semi-design设计系统/` |
| shadcn/ui | React+Tailwind/Next.js | `C:/Users/Admin/shadcn-ui设计系统/` |

#### 2.1 颜色 Token

```css
:root {
  /* 主色 */
  --color-primary: #1677FF;     /* 主操作 */
  --color-primary-hover: #4096FF;
  --color-primary-active: #0958D9;

  /* 语义色 */
  --color-success: #52C41A;
  --color-warning: #FAAD14;
  --color-error: #FF4D4F;
  --color-info: #1677FF;

  /* 中性色 */
  --color-text-primary: rgba(0,0,0,0.88);
  --color-text-secondary: rgba(0,0,0,0.65);
  --color-text-tertiary: rgba(0,0,0,0.45);
  --color-border: #D9D9D9;
  --color-bg-base: #FFFFFF;
  --color-bg-subtle: #FAFAFA;
}
```

#### 2.2 字号 Token

```css
:root {
  --font-size-xs: 12px;   /* 辅助文字 */
  --font-size-sm: 14px;   /* 正文（默认）*/
  --font-size-md: 16px;   /* 标题 */
  --font-size-lg: 18px;   /* 大标题 */
  --font-size-xl: 24px;   /* 页面标题 */
}
```

#### 2.3 间距 Token（8 倍数原则）

```css
:root {
  --space-xs: 4px;
  --space-sm: 8px;
  --space-md: 16px;
  --space-lg: 24px;
  --space-xl: 32px;
  --space-2xl: 48px;
}
```

#### 2.4 圆角 Token

```css
:root {
  --radius-sm: 2px;
  --radius-md: 4px;
  --radius-lg: 8px;
  --radius-full: 9999px;
}
```

#### 2.5 阴影 Token

```css
:root {
  --shadow-sm: 0 1px 2px rgba(0,0,0,0.06);
  --shadow-md: 0 2px 8px rgba(0,0,0,0.08);
  --shadow-lg: 0 4px 16px rgba(0,0,0,0.12);
}
```

---

### 三、组件规范

#### 3.1 按钮

| 类型 | 用途 | 视觉 |
|------|------|------|
| Primary | 主操作 | 主色背景 + 白字 |
| Default | 次要操作 | 白底 + 灰边框 |
| Text | 辅助操作 | 无背景 + 主色字 |
| Danger | 危险操作 | 红色背景 |

**状态**：default / hover / active / disabled / loading

#### 3.2 表单

- 标签左对齐（桌面）/ 顶对齐（移动）
- 校验：失焦校验 + 提交校验
- 错误提示：红字 + 图标，定位在字段下方
- 必填项：*标记 + 红色

#### 3.3 表格

- 行高 48px（密集 32px）
- 斑马纹（可选）
- 排序/筛选/分页标配
- 空状态友好提示

#### 3.4 弹窗 / 抽屉

- Modal：临时重要操作（确认/简单表单）
- Drawer：复杂表单/详情，从右侧滑出
- 全屏：超复杂操作流

#### 3.5 反馈

- Toast：3s 自动消失，轻量提示
- Notification：可关闭，重要通知
- Alert：嵌入页面，持续提示
- Loading：spinner / skeleton

---

### 四、布局规范

#### 4.1 栅格

- 桌面：24 栅格，gutter 16px
- 平板：12 栅格
- 移动：4 栅格

#### 4.2 响应式断点

| 断点 | 宽度 | 设备 |
|------|------|------|
| xs | <576px | 手机 |
| sm | ≥576px | 大手机 |
| md | ≥768px | 平板 |
| lg | ≥992px | 桌面 |
| xl | ≥1200px | 大桌面 |
| xxl | ≥1600px | 超大桌面 |

#### 4.3 间距规则

- 页面边距：桌面 24px / 平板 16px / 移动 12px
- 卡片间距：16px
- 模块间距：24px
- 页面区块间距：32px

---

### 五、交互规范

#### 5.1 操作反馈时间

| 操作 | 反馈 |
|------|------|
| 点击 | <100ms |
| 简单查询 | <1s（同步） |
| 复杂操作 | 1-3s（loading） |
| 长任务 | >3s（进度条） |

#### 5.2 微交互

- 按钮 hover/active：颜色变化 + 轻微缩放
- Modal 出现：淡入 + 上滑
- Toast 出现：从顶部滑入
- 加载：骨架屏优于 spinner

#### 5.3 错误处理

- 表单错误：字段下方红字
- 接口错误：Toast + 重试按钮
- 404：友好空状态 + 返回首页
- 网络断开：全局横幅提示

---

### 六、可达性（Accessibility）

### 6.1 颜色对比

- 普通文本：对比度 ≥ 4.5:1
- 大文本（≥18pt）：对比度 ≥ 3:1
- 交互元素：对比度 ≥ 3:1

### 6.2 键盘可达

- 所有交互元素 Tab 可达
- 焦点可见（focus 样式）
- 快捷键：Esc 关闭弹窗 / Enter 提交

### 6.3 屏幕阅读器

- 语义化 HTML（nav/header/main/footer）
- alt 文本（图片）
- aria-label（图标按钮）

---

### 七、图标规范

- 图标库：{选定的 Design System 配套}
- 大小：16/20/24/32px
- 颜色：跟随 currentColor
- 状态：默认/hover/active/disabled

---

### 八、动效规范

| 场景 | 时长 | 缓动 |
|------|------|------|
| hover | 100ms | ease-out |
| 弹窗 | 200ms | ease-out |
| 页面切换 | 300ms | ease-in-out |
| 数据加载 | 400ms | ease-out |

> **慎用动效**：动效服务于体验，不是炫技。详见 [interaction-design skill](../../05-技能库/)。

---

## 验收标准

| 检查项 | 通过标准 |
|--------|---------|
| Design Token 集中管理 | 所有颜色/字号/间距通过 CSS 变量 |
| 响应式断点 | 5 个断点全覆盖 |
| 组件规范 | 6 大类组件（按钮/表单/表格/弹窗/反馈/导航）有规范 |
| 可达性 | WCAG 2.1 AA 级 |
| 视觉一致性 | 跨页面体验一致 |

---

## 版本记录

| 版本 | 日期 | 修订人 | 修订内容 |
|------|------|--------|---------|
| V1.0 | {date} | {name} | 初始版本 |

---

*本模板是「UI/UX 设计规范」的标准结构。示例项目完整示例见 [附录-示例项目示例集.md](./附录-示例项目示例集.md) §2.3。*
