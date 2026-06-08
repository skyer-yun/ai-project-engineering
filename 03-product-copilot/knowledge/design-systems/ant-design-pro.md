---
type: design-system
name: Ant Design Pro
status: verified
source: 项目Demo反向提取
last-updated: 2026-04-20
local-path: C:/Users/Admin/ant-design-pro设计系统/
description: 基于 Ant Design 5 + ProComponents 的中后台/Dashboard设计系统
framework: React (Ant Design 5 + ProComponents)
prefix: "--" (CSS变量无前缀)
---

# Ant Design Pro Design System

> 中后台管理系统 / Dashboard 首选设计系统。基于 Ant Design 5 色彩体系 + ProComponents 高级组件 +
> 项目实践整理。适用于管理后台、数据看板、企业内部系统等场景。

---

## 1. Design Philosophy

Ant Design Pro 设计系统的核心理念：

| 原则 | 说明 |
|------|------|
| 确定性 | 设计变量统一，组件规范明确，减少主观决策 |
| 意义感 | 色彩语义清晰（成功/警告/错误/信息），状态一目了然 |
| 生长感 | 动画曲线精心调校，交互反馈自然流畅 |
| 自然 | 间距基于 4px/8px 网格，层次分明 |

适用场景优先级：
1. 中后台管理系统（首选）
2. Dashboard / 数据看板
3. 企业内部工具
4. 表单密集型应用

---

## 2. Color Tokens

### 2.1 Semantic Colors

```css
:root {
    /* -- Primary Colors -- */
    --colorPrimary: #1677ff;        /* 主色：主要按钮、链接、选中态 */
    --colorSuccess: #52c41a;        /* 成功色：正向反馈、完成状态 */
    --colorWarning: #faad14;        /* 警告色：需注意的信息 */
    --colorError: #ff4d4f;          /* 错误色：错误状态、危险操作 */
    --colorInfo: #1677ff;           /* 信息色：一般信息提示（同主色） */
}
```

### 2.2 Background Colors

```css
:root {
    --colorBgContainer: #ffffff;    /* 容器背景（卡片、表格、Modal） */
    --colorBgLayout: #f5f5f5;       /* 布局背景（页面底色） */
}
```

### 2.3 Text Color Hierarchy

```css
:root {
    --colorText: rgba(0, 0, 0, 0.88);         /* 主文字：标题、正文、重要信息 */
    --colorTextSecondary: rgba(0, 0, 0, 0.65); /* 次要文字：副标题、说明、表头 */
    --colorTextTertiary: rgba(0, 0, 0, 0.45);  /* 辅助文字：placeholder、时间戳 */
}
```

| Token | 值 | 场景 |
|-------|-----|------|
| `--colorText` | `rgba(0, 0, 0, 0.88)` | 标题、正文、表格数据 |
| `--colorTextSecondary` | `rgba(0, 0, 0, 0.65)` | 副标题、表头、说明文字 |
| `--colorTextTertiary` | `rgba(0, 0, 0, 0.45)` | placeholder、禁用文字、时间戳 |

### 2.4 Border Colors

```css
:root {
    --colorBorder: #d9d9d9;             /* 主边框：输入框、下拉框 */
    --colorBorderSecondary: #f0f0f0;    /* 次边框：分隔线、卡片边框 */
}
```

### 2.5 Interaction Feedback Colors

| Type | Default | Hover |
|------|---------|-------|
| Primary | `#1677ff` | `#4096ff` |
| Success | `#52c41a` | `#73d13d` |
| Danger | `#ff4d4f` | `#ff7875` |

```css
/* Table row hover */
.table tbody tr:hover {
    background: #e6f4ff;
}

/* Menu item hover (dark sidebar) */
.menu-item:hover {
    background: rgba(255, 255, 255, 0.08);
}
```

### 2.6 Tag Colors

| Type | Background | Border | Text |
|------|-----------|--------|------|
| Default | `#fafafa` | `#d9d9d9` | `rgba(0,0,0,0.65)` |
| Success | `#f6ffed` | `#b7eb8a` | `#52c41a` |
| Warning | `#fffbe6` | `#ffe58f` | `#faad14` |
| Error | `#fff2f0` | `#ffccc7` | `#ff4d4f` |
| Processing | `#e6f4ff` | `#91caff` | `#1677ff` |

### 2.7 Gradients

```css
/* Icon gradients (StatCard, Logo) */
.gradient-primary { background: linear-gradient(135deg, #1677ff 0%, #69b1ff 100%); }
.gradient-success { background: linear-gradient(135deg, #52c41a 0%, #95de64 100%); }
.gradient-warning { background: linear-gradient(135deg, #faad14 0%, #ffd666 100%); }
.gradient-error   { background: linear-gradient(135deg, #ff4d4f 0%, #ff7875 100%); }

/* Skeleton shimmer */
.skeleton {
    background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
    background-size: 200% 100%;
}

/* Chart placeholder */
.chart-container {
    background: linear-gradient(135deg, #f5f5f5 0%, #e8e8e8 100%);
}
```

### 2.8 Amount Formatting

```css
.amount-positive { color: var(--colorSuccess); }
.amount-negative { color: var(--colorError); }
.amount {
    font-family: 'SF Mono', 'Monaco', 'Inconsolata', monospace;
    font-weight: 500;
}
```

---

## 3. Typography

### 3.1 Font Family

```css
--fontFamily: 'Noto Sans SC', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
```

| Platform | Primary Font | Fallback |
|----------|-------------|----------|
| macOS/iOS | Noto Sans SC | -apple-system, Helvetica Neue |
| Windows | Noto Sans SC | Segoe UI |
| Android | Noto Sans SC | Roboto |

### 3.2 Font Size Hierarchy

| Size | Usage |
|------|-------|
| `12px` | Tag, helper text, menu group titles, form errors |
| `13px` | StatCard footer, Toast messages |
| `14px` | Body text, forms, buttons, tables, menu items (default) |
| `15px` | Logo text |
| `16px` | Card title, Modal title, Drawer title |
| `18px` | Logo icon |
| `20px` | Page title |
| `28px` | StatCard value |

### 3.3 Line Height

| Context | Value |
|---------|-------|
| Global | `1.5714285714285714` (~22px / 14px) |
| StatCard value | `1.2` |

### 3.4 Font Weight

| Weight | Usage |
|--------|-------|
| `400` | Body text |
| `500` | Buttons, form labels |
| `600` | Titles, card titles, StatCard values |
| `700` | Logo icon |

### 3.5 Typography CSS Variables

```css
:root {
    --fontFamily: 'Noto Sans SC', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    --fontSize: 14px;
    --fontSizeLG: 16px;
}

body {
    font-family: var(--fontFamily);
    font-size: var(--fontSize);
    line-height: 1.5714285714285714;
}
```

---

## 4. Spacing System

### 4.1 Padding Tokens

```css
:root {
    --padding: 24px;       /* 基础：页面内容、卡片内容 */
    --paddingMD: 16px;     /* 中等：Modal header、表格单元格 */
    --paddingSM: 12px;     /* 小：表格单元格、表单项间距 */
    --paddingXS: 8px;      /* 超小：菜单项、Tag */
}
```

| Context | Padding |
|---------|---------|
| Page content | `24px` |
| Card content | `24px` |
| Card header | `16px 24px` |
| Modal/Drawer header | `16px 24px` |
| Modal/Drawer body | `24px` |
| Modal/Drawer footer | `16px 24px` |
| Table cell | `12px 24px` |
| Table toolbar | `16px 24px` |
| Pagination area | `16px 24px` |
| Menu item | `0 16px` |
| Tag | `0 7px` |
| Button | `0 15px` |

### 4.2 Margin Tokens

```css
:root {
    --margin: 16px;        /* 基础外边距 */
    --marginSM: 12px;      /* 小外边距 */
    --marginXS: 8px;       /* 超小外边距 */
}
```

### 4.3 Border Radius

```css
--borderRadius: 6px;    /* 全局圆角 */
```

| Component | Radius |
|-----------|--------|
| Card | `6px` |
| Button | `6px` |
| Input | `6px` |
| Modal | `6px` |
| Tag | `4px` |
| Avatar | `50%` |
| StatCard icon | `8px` |
| Progress bar | `4px` |

### 4.4 Control Heights

```css
:root {
    --controlHeight: 32px;     /* 标准控件高度 */
    --controlHeightLG: 40px;   /* 大控件高度 */
}
```

| Component | Height |
|-----------|--------|
| Standard button | `32px` |
| Small button | `24px` |
| Large button | `40px` |
| Input | `32px` |
| Select | `32px` |
| Tag | `22px` |
| Menu item | `40px` |
| Pagination item | `32px` |

### 4.5 Layout Dimensions

```css
:root {
    --siderWidth: 208px;       /* 侧边栏展开宽度 */
    --headerHeight: 56px;      /* 头部高度 */
}
```

| Component | Dimension |
|-----------|-----------|
| Sidebar (desktop) | `208px` |
| Sidebar (collapsed) | `60px` |
| Header height | `56px` |
| Logo area height | `56px` |
| Modal width (default) | `520px` |
| Modal width (confirm) | `400px` |
| Drawer width | `500px` |
| Toast width | `280px ~ 400px` |

### 4.6 Grid Layouts

```css
.stat-cards { display: grid; grid-template-columns: repeat(4, 1fr); gap: 24px; }
.grid-2     { display: grid; grid-template-columns: repeat(2, 1fr); gap: 24px; }
.grid-3     { display: grid; grid-template-columns: repeat(3, 1fr); gap: 24px; }
```

---

## 5. Motion / Animation

### 5.1 Easing Curves

```css
:root {
    --ease-out: cubic-bezier(0.16, 1, 0.3, 1);       /* 极速缓出：进入/展开 */
    --ease-in: cubic-bezier(0.55, 0, 1, 0.45);       /* 快速缓入：退出/收起 */
    --ease-in-out: cubic-bezier(0.65, 0, 0.35, 1);   /* 对称缓入缓出：状态切换 */
    --spring: cubic-bezier(0.34, 1.56, 0.64, 1);     /* 弹性过冲：强调动画 */
}
```

### 5.2 Keyframes

```css
@keyframes fadeIn       { from { opacity: 0; transform: translateY(12px); } to { opacity: 1; transform: translateY(0); } }
@keyframes fadeInUp     { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
@keyframes fadeInScale  { from { opacity: 0; transform: scale(0.95); } to { opacity: 1; transform: scale(1); } }
@keyframes scaleIn      { from { opacity: 0; transform: scale(0.8); } to { opacity: 1; transform: scale(1); } }
@keyframes slideInRight { from { transform: translateX(100%); } to { transform: translateX(0); } }
@keyframes slideOutRight{ from { transform: translateX(0); } to { transform: translateX(100%); } }
@keyframes slideDown    { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }
@keyframes ripple       { 0% { transform: scale(0); opacity: 0.5; } 100% { transform: scale(4); opacity: 0; } }
@keyframes pulse        { 0%, 100% { opacity: 1; } 50% { opacity: 0.5; } }
@keyframes shake        { 0%, 100% { transform: translateX(0); } 25% { transform: translateX(-5px); } 75% { transform: translateX(5px); } }
@keyframes spin         { to { transform: rotate(360deg); } }
@keyframes shimmer      { 0% { background-position: -200% 0; } 100% { background-position: 200% 0; } }
```

### 5.3 Transition Durations

| Scenario | Duration | Notes |
|----------|----------|-------|
| Fast interaction (hover, active) | `0.15s` | Instant feedback |
| Standard (border, background) | `0.2s` | Smooth change |
| Medium (Modal/Drawer overlay) | `0.25s` | Layer transitions |
| Entrance (Modal, Toast, cards) | `0.3s` | Content appears |
| Page transition | `0.35s` | Full page switch |
| Stagger delay (StatCards) | `0.05s` | Sequential entrance |
| Skeleton shimmer | `1.5s` | Loading loop |
| Spinner rotation | `0.8s` | Loading cycle |

---

## 6. Component Specs

### 6.1 Button

**Variants (5):**

```css
/* Base */
.btn {
    display: inline-flex; align-items: center; justify-content: center;
    gap: 6px; height: var(--controlHeight); padding: 0 15px;
    font-size: 14px; font-weight: 500; border-radius: var(--borderRadius);
    cursor: pointer; transition: all 0.2s; border: 1px solid transparent;
    white-space: nowrap; position: relative; overflow: hidden;
}

/* Primary */
.btn-primary { background: var(--colorPrimary); color: white; border-color: var(--colorPrimary); }
.btn-primary:hover { background: #4096ff; border-color: #4096ff; }

/* Default */
.btn-default { background: white; color: var(--colorText); border-color: var(--colorBorder); }
.btn-default:hover { color: var(--colorPrimary); border-color: var(--colorPrimary); }

/* Success */
.btn-success { background: var(--colorSuccess); color: white; border-color: var(--colorSuccess); }
.btn-success:hover { background: #73d13d; border-color: #73d13d; }

/* Danger */
.btn-danger { background: var(--colorError); color: white; border-color: var(--colorError); }
.btn-danger:hover { background: #ff7875; border-color: #ff7875; }

/* Link */
.btn-link { background: transparent; border: none; color: var(--colorPrimary); padding: 0 4px; height: auto; }
.btn-link:hover { color: #4096ff; }
```

**Sizes (2):**

| Size | Height | Padding | Font Size |
|------|--------|---------|-----------|
| Default | `32px` | `0 15px` | `14px` |
| Small | `24px` | `0 7px` | `12px` |

**States:**

```css
.btn.loading { pointer-events: none; opacity: 0.7; }

.loading-spinner {
    width: 16px; height: 16px;
    border: 2px solid rgba(255, 255, 255, 0.3);
    border-top-color: white; border-radius: 50%;
    animation: spin 0.8s linear infinite;
}
```

**Usage Guide:**

| Scenario | Variant | Size |
|----------|---------|------|
| Table toolbar (Add) | Primary | Default |
| Table actions (Edit/View) | Link | -- |
| Table actions (Delete) | Link + Confirm | -- |
| Modal confirm | Primary | Default |
| Modal cancel | Default | Default |
| Search reset | Default | Default |
| Form submit | Primary | Default |
| Status change (Approve/Reject) | Success / Danger | Default |

### 6.2 Input

```css
.form-input {
    height: var(--controlHeight);       /* 32px */
    padding: 0 11px;
    border: 1px solid var(--colorBorder);
    border-radius: var(--borderRadius);
    font-size: 14px;
    transition: border-color 0.2s ease, box-shadow 0.2s ease, transform 0.15s ease;
}

.form-input:focus {
    outline: none;
    border-color: var(--colorPrimary);
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(22, 119, 255, 0.15);
}

.form-input::placeholder {
    color: var(--colorTextTertiary);
}
```

### 6.3 Table

```css
.table-wrapper {
    background: var(--colorBgContainer);
    border-radius: var(--borderRadius);
    border: 1px solid var(--colorBorderSecondary);
}

.table th {
    background: #fafafa; padding: 12px 24px;
    font-weight: 600; text-align: left;
    border-bottom: 1px solid var(--colorBorderSecondary);
}

.table td {
    padding: 12px 24px;
    border-bottom: 1px solid var(--colorBorderSecondary);
}

.table tbody tr:hover { background: #e6f4ff; }
```

| Attribute | Value |
|-----------|-------|
| Header height | ~44px (12px padding + line-height) |
| Row height | ~44px (12px padding + line-height) |
| Hover background | `#e6f4ff` |
| Pagination alignment | `flex-end` |

**Column Width Guide:**

| Column Type | Width |
|-------------|-------|
| ID / Index | `60px ~ 80px` |
| Status / Type | `100px ~ 120px` |
| Name / Code | `150px ~ 200px` |
| Amount | `120px ~ 150px` (monospace) |
| DateTime | `160px ~ 180px` |
| Actions | `120px ~ 180px` |

### 6.4 Form

```css
.form { display: flex; flex-direction: column; gap: var(--paddingMD); }
.form-row { display: flex; gap: var(--padding); }
.form-item { flex: 1; display: flex; flex-direction: column; gap: 8px; }
.form-item-label { font-size: 14px; font-weight: 500; }
.form-item-label .required { color: var(--colorError); margin-right: 4px; }

/* Error state */
.form-item.error .form-input { border-color: var(--colorError); animation: shake 0.3s ease; }
.form-item-error { color: var(--colorError); font-size: 12px; margin-top: 4px; }
```

| Spacing | Value |
|---------|-------|
| Form items | `16px` gap |
| Form rows | `16px` gap |
| Same row items | `24px` gap |
| Label to input | `8px` gap |
| Error message | `4px` margin-top |

### 6.5 Modal / Drawer

**Modal:**

```css
.modal-overlay {
    position: fixed; inset: 0; background: rgba(0, 0, 0, 0.45);
    display: flex; align-items: center; justify-content: center;
    z-index: 1000;
}
.modal {
    background: white; border-radius: var(--borderRadius);
    width: 520px; max-width: 90vw; max-height: 90vh;
    display: flex; flex-direction: column;
    transform: scale(0.9) translateY(-20px); opacity: 0;
    transition: transform 0.3s var(--ease-out), opacity 0.3s var(--ease-out);
}
.modal-overlay.active .modal { transform: scale(1) translateY(0); opacity: 1; }
```

| Attribute | Modal | Confirm | Drawer |
|-----------|-------|---------|--------|
| Width | `520px` | `400px` | `500px` |
| Overlay z-index | `1000` | `1000` | `1000` |
| Body z-index | -- | -- | `1001` |
| Animation | scale + translateY | scale + translateY | translateX |

**Drawer:**

```css
.drawer {
    position: fixed; right: 0; top: 0; bottom: 0;
    width: 500px; max-width: 90vw;
    transform: translateX(100%);
    transition: transform 0.3s var(--ease-out);
    z-index: 1001;
}
.drawer-overlay.active .drawer { transform: translateX(0); }
```

### 6.6 Navigation

**Sidebar:**

```css
.sider {
    width: var(--siderWidth); background: #001529;
    position: fixed; left: 0; top: 0; bottom: 0;
    z-index: 100; display: flex; flex-direction: column;
    transition: width 0.2s;
}
```

| State | Width | Notes |
|-------|-------|-------|
| Expanded (desktop) | `208px` | Full menu text |
| Collapsed (mobile) | `60px` | Icons only |

**Header:**

```css
.header {
    height: var(--headerHeight); background: var(--colorBgContainer);
    display: flex; align-items: center; justify-content: space-between;
    padding: 0 var(--padding); box-shadow: 0 1px 4px rgba(0, 0, 0, 0.08);
    position: sticky; top: 0; z-index: 99;
}
```

| Attribute | Value |
|-----------|-------|
| Height | `48px ~ 56px` |
| Sticky | yes |
| Box shadow | `0 1px 4px rgba(0, 0, 0, 0.08)` |

---

## 7. Layout Patterns

### 7.1 Standard Admin Layout

```
+--.layout (flex, min-height: 100vh)---------------------------------+
| +--.sider (208px, fixed)--+ +--.main (flex:1, margin-left:208px)--+ |
| |                          | | +--.header (56px, sticky)--------+ | |
| | +--.sider-logo (56px)--+| | | Breadcrumb         User actions | | |
| | | [icon] System Name   || | +---------------------------------+ | |
| | +----------------------+| | +--.content (flex:1, padding:24px)+| |
| | +--.sider-menu---------+| | |                                 || |
| | | Menu Group Title     || | |   +--.page-container----------+|| |
| | | > Active Item        || | |   |                            ||| |
| | |   Menu Item          || | |   |   Page Content             ||| |
| | |   Menu Item          || | |   |                            ||| |
| | | Menu Group Title     || | |   +----------------------------+|| |
| | |   Menu Item          || | +----------------------------------+ |
| | +----------------------+| +-------------------------------------+ |
| +--------------------------+                                        |
+---------------------------------------------------------------------+
```

### 7.2 Dashboard Layout

```
+--.page-container (bg: white, radius: 6px, padding: 24px)------------+
| +--.page-header (margin-bottom: 24px, border-bottom: #f0f0f0)-----+|
| | Page Title (20px, weight: 600)                                    |
| | Page Subtitle (14px, color: secondary)                            |
| +-------------------------------------------------------------------+
| +--.stat-cards (grid: 4fr, gap: 24px)------------------------------+
| | +--.stat-card--+ +--.stat-card--+ +--.stat-card--+ +--.stat-card-+|
| | | [icon 48px]  | | [icon 48px]  | | [icon 48px]  | | [icon 48px] ||
| | | Title        | | Title        | | Title        | | Title       ||
| | | 1,234 (28px) | | 567 (28px)   | | 89 (28px)    | | 0.5% (28px) ||
| | | trend footer | | trend footer | | trend footer | | trend footer||
| | +--------------+ +--------------+ +--------------+ +-------------+|
| +-------------------------------------------------------------------+
| +--.grid-2 (grid: 2fr, gap: 24px)----------------------------------+
| | +--.card (todo list)-----------+ +--.card (chart area)----------+|
| | | .card-header (16px 24px)     | | .card-header (16px 24px)     ||
| | | .card-body (padding: 24px)   | | .card-body                   ||
| | | - list item (hover: x+4px)   | | [chart placeholder 300px]    ||
| | | - list item                  | |                              ||
| | +------------------------------+ +------------------------------+|
| +-------------------------------------------------------------------+
+---------------------------------------------------------------------+
```

### 7.3 Responsive Breakpoints

| Breakpoint | Condition | Layout Change |
|-----------|-----------|---------------|
| Large | `> 1200px` | Default layout (4-col StatCards, full sidebar) |
| Medium | `<= 1200px` | StatCards 4-col -> 2-col |
| Small | `<= 768px` | Sidebar collapses to 60px, StatCards -> 1-col |

```css
@media (max-width: 1200px) {
    .stat-cards { grid-template-columns: repeat(2, 1fr); }
}
@media (max-width: 768px) {
    .sider { width: 60px; }
    .sider-logo-text { display: none; }
    .menu-item span { display: none; }
    .main { margin-left: 60px; }
    .stat-cards { grid-template-columns: 1fr; }
}
```

---

## 8. z-index Management

| Element | z-index | Notes |
|---------|---------|-------|
| Header | `99` | Sticky header |
| Sidebar | `100` | Fixed sidebar |
| Modal overlay | `1000` | Modal backdrop |
| Drawer overlay | `1000` | Drawer backdrop |
| Drawer body | `1001` | Drawer content |
| Toast container | `2000` | Notification toasts |

---

## 9. Accessibility

```css
@media (prefers-reduced-motion: reduce) {
    *, *::before, *::after {
        animation-duration: 0.01ms !important;
        animation-iteration-count: 1 !important;
        transition-duration: 0.01ms !important;
    }
}
```

---

## 10. Local File Reference

| Category | File | Path |
|----------|------|------|
| Overview | README | `C:/Users/Admin/ant-design-pro设计系统/README.md` |
| React Guide | Dev Guide | `C:/Users/Admin/ant-design-pro设计系统/react-dev-guide.md` |
| Colors | Token | `C:/Users/Admin/ant-design-pro设计系统/tokens/colors.md` |
| Typography | Token | `C:/Users/Admin/ant-design-pro设计系统/tokens/typography.md` |
| Spacing | Token | `C:/Users/Admin/ant-design-pro设计系统/tokens/spacing.md` |
| Motion | Token | `C:/Users/Admin/ant-design-pro设计系统/tokens/motion.md` |
| Button | Component | `C:/Users/Admin/ant-design-pro设计系统/components/button.md` |
| Table | Component | `C:/Users/Admin/ant-design-pro设计系统/components/table.md` |
| Form | Component | `C:/Users/Admin/ant-design-pro设计系统/components/form.md` |
| Feedback | Component | `C:/Users/Admin/ant-design-pro设计系统/components/feedback.md` |
| Data Display | Component | `C:/Users/Admin/ant-design-pro设计系统/components/data-display.md` |
| Navigation | Component | `C:/Users/Admin/ant-design-pro设计系统/components/navigation.md` |
| Dashboard | Pattern | `C:/Users/Admin/ant-design-pro设计系统/patterns/dashboard.md` |
| Layout | Pattern | `C:/Users/Admin/ant-design-pro设计系统/patterns/layout.md` |
| Auth | Pattern | `C:/Users/Admin/ant-design-pro设计系统/patterns/auth.md` |
| Task Mgmt | Pattern | `C:/Users/Admin/ant-design-pro设计系统/patterns/task-management.md` |
| Settings | Pattern | `C:/Users/Admin/ant-design-pro设计系统/patterns/settings.md` |
| Team | Pattern | `C:/Users/Admin/ant-design-pro设计系统/patterns/team.md` |

---

*Last updated: 2026-04-20 | Source: Ant Design Pro Demo*
