---
type: design-system
name: Arco Design
status: verified
source: 官方文档整理
last-updated: 2026-05-19
homepage: https://arco.design
tech-stack: React / Vue 3
---

# Arco Design 设计系统速查

> 字节跳动出品，轻量现代，React + Vue 双端支持

---

## 色彩 Token

### 品牌色
```
主色：#165DFF（蓝色）
色阶（6 级）：
  #E8F3FF -> #BEDAFF -> #94BFFF -> #6AA1FF -> #4080FF -> #165DFF
  浅 -> 深渐变
暗色主题主色：#3C7EFF
```

### 语义色 6 级色阶

```
成功 Success: #00B42A
  light-1: #E8FFEA   light-2: #B9F5C8   light-3: #7BE188
  light-4: #4CD87A   light-5: #23C343   light-6: #00B42A

警告 Warning: #FF7D00
  light-1: #FFF7E8   light-2: #FFE4BA   light-3: #FFCF8B
  light-4: #FFB65D   light-5: #FF9A2E   light-6: #FF7D00

危险 Danger: #F53F3F
  light-1: #FFECE8   light-2: #FDCEC6   light-3: #FCACA3
  light-4: #F98981   light-5: #F76560   light-6: #F53F3F

信息 Info: #86909C （中性灰，非蓝色）
  light-1: #F2F3F5   light-2: #E5E6EB   light-3: #C9CDD4
  light-4: #A9AEB8   light-5: #86909C   light-6: #6B7785
```

### 文字色
```
--color-text-1: #1D2129  标题/重要文字
--color-text-2: #4E5969  正文/常规文字
--color-text-3: #86909C  次要/辅助文字
--color-text-4: #C9CDD4  占位/禁用文字
```

### 背景与边框
```
--color-bg-1: #FFFFFF     页面背景
--color-bg-2: #F7F8FA     内容区背景
--color-bg-3: #F2F3F5     弹出层背景
--color-bg-4: #E5E6EB     特殊背景
--color-bg-white: #FFFFFF 纯白背景

--color-border:       #E5E6EB
--color-border-light: #F2F3F5

--color-fill-1: #F7F8FA   轻填充
--color-fill-2: #F2F3F5   中填充
--color-fill-3: #E5E6EB   重填充
--color-fill-4: #C9CDD4   最重填充
```

### 完整色彩 CSS 变量定义

```css
:root {
  /* 品牌色 */
  --arco-color-primary-1: #E8F3FF;
  --arco-color-primary-2: #BEDAFF;
  --arco-color-primary-3: #94BFFF;
  --arco-color-primary-4: #6AA1FF;
  --arco-color-primary-5: #4080FF;
  --arco-color-primary-6: #165DFF;
  --arco-color-primary-7: #0E42D2;
  --arco-color-primary-8: #072CA6;
  --arco-color-primary-9: #03197A;
  --arco-color-primary-10: #000D4D;

  /* 品牌色快捷引用 */
  --color-primary-light-1: var(--arco-color-primary-1);
  --color-primary-light-4: var(--arco-color-primary-4);
  --color-primary: var(--arco-color-primary-6);
  --color-primary-hover: var(--arco-color-primary-5);
  --color-primary-active: var(--arco-color-primary-7);

  /* 成功色 */
  --color-success-light-1: #E8FFEA;
  --color-success-light-2: #B9F5C8;
  --color-success-light-3: #7BE188;
  --color-success-light-4: #4CD87A;
  --color-success: #00B42A;
  --color-success-hover: #23C343;
  --color-success-active: #009A29;

  /* 警告色 */
  --color-warning-light-1: #FFF7E8;
  --color-warning-light-2: #FFE4BA;
  --color-warning-light-3: #FFCF8B;
  --color-warning-light-4: #FFB65D;
  --color-warning: #FF7D00;
  --color-warning-hover: #FF9A2E;
  --color-warning-active: #D25F00;

  /* 危险色 */
  --color-danger-light-1: #FFECE8;
  --color-danger-light-2: #FDCEC6;
  --color-danger-light-3: #FCACA3;
  --color-danger-light-4: #F98981;
  --color-danger: #F53F3F;
  --color-danger-hover: #F76560;
  --color-danger-active: #CB2634;

  /* 信息色 */
  --color-info-light-1: #F2F3F5;
  --color-info-light-2: #E5E6EB;
  --color-info-light-3: #C9CDD4;
  --color-info-light-4: #A9AEB8;
  --color-info: #86909C;
  --color-info-hover: #6B7785;
  --color-info-active: #4E5969;

  /* 文字色 */
  --color-text-1: #1D2129;
  --color-text-2: #4E5969;
  --color-text-3: #86909C;
  --color-text-4: #C9CDD4;

  /* 背景色 */
  --color-bg-1: #FFFFFF;
  --color-bg-2: #F7F8FA;
  --color-bg-3: #F2F3F5;
  --color-bg-4: #E5E6EB;
  --color-bg-white: #FFFFFF;

  /* 边框色 */
  --color-border: #E5E6EB;
  --color-border-light: #F2F3F5;

  /* 填充色 */
  --color-fill-1: #F7F8FA;
  --color-fill-2: #F2F3F5;
  --color-fill-3: #E5E6EB;
  --color-fill-4: #C9CDD4;

  /* 阴影 */
  --shadow-1: 0 4px 10px rgba(0, 0, 0, 0.1);
  --shadow-2: 0 8px 20px rgba(0, 0, 0, 0.1);
  --shadow-3: 0 12px 32px rgba(0, 0, 0, 0.1);
}
```

### 色彩使用速查表

| Token | 值 | 使用场景 |
|-------|-----|---------|
| --color-primary | #165DFF | 主按钮、选中态、链接 |
| --color-primary-light-1 | #E8F3FF | 选中行背景、标签底色 |
| --color-primary-light-4 | #6AA1FF | 主色悬浮态 |
| --color-success | #00B42A | 成功提示、状态标签 |
| --color-warning | #FF7D00 | 警告提示、待处理标签 |
| --color-danger | #F53F3F | 错误提示、删除操作 |
| --color-info | #86909C | 次要信息、禁用态 |
| --color-text-1 | #1D2129 | 标题、表头 |
| --color-text-2 | #4E5969 | 正文内容 |
| --color-bg-1 | #FFFFFF | 卡片背景 |
| --color-bg-2 | #F7F8FA | 页面底色 |
| --color-border | #E5E6EB | 默认边框 |

---

## 排版规范 Typography

### 字体栈

```css
:root {
  --font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
    "Helvetica Neue", Arial, "Noto Sans", "PingFang SC",
    "Hiragino Sans GB", "Microsoft YaHei", sans-serif;
  --font-family-mono: "SFMono-Regular", Consolas,
    "Liberation Mono", Menlo, Courier, monospace;
  --font-family-number: "DIN Alternate", "Helvetica Neue",
    Arial, "PingFang SC", sans-serif;
}
```

| 平台 | 首选字体 | 说明 |
|------|---------|------|
| macOS | "PingFang SC" | 苹方，系统级 |
| Windows | "Microsoft YaHei" | 微软雅黑 |
| Linux | "Noto Sans" | Google 开源字体 |
| 数字展示 | "DIN Alternate" | 数据大屏、统计数字 |
| 代码/等宽 | SFMono-Regular, Consolas | 代码块 |

### 字号梯度

```css
:root {
  --font-size-display: 36px;   /* 大屏标题 */
  --font-size-title-1: 20px;   /* 页面主标题 */
  --font-size-title-2: 16px;   /* 模块标题 */
  --font-size-title-3: 14px;   /* 小标题 */
  --font-size-body-1: 14px;    /* 正文（默认） */
  --font-size-body-2: 13px;    /* 辅助文字 */
  --font-size-body-3: 12px;    /* 次要文字 */
  --font-size-caption: 12px;   /* 标签说明 */
  --font-size-mini: 10px;      /* 极小标注 */
}
```

| Token | 值 | 使用场景 |
|-------|-----|---------|
| --font-size-display | 36px | 大屏展示页标题 |
| --font-size-title-1 | 20px | 页面主标题 |
| --font-size-title-2 | 16px | 模块标题、Card 标题 |
| --font-size-title-3 | 14px | 小标题、表头 |
| --font-size-body-1 | 14px | 正文（默认字号） |
| --font-size-body-2 | 13px | 表格次要列、描述 |
| --font-size-body-3 | 12px | 标签、辅助文字 |
| --font-size-caption | 12px | 提示说明、Badge |
| --font-size-mini | 10px | 角标、微小标注 |

### 行高

| 字号 | 行高 | 比例 |
|------|------|------|
| 36px | 44px | 1.22 |
| 20px | 28px | 1.40 |
| 16px | 24px | 1.50 |
| 14px | 22px | 1.57 |
| 13px | 20px | 1.54 |
| 12px | 20px | 1.67 |
| 10px | 16px | 1.60 |

### 字重

| 名称 | 值 | 使用场景 |
|------|-----|---------|
| Regular | 400 | 正文、辅助文字 |
| Medium | 500 | 按钮文字、表头 |
| Semibold | 600 | 标题、强调 |
| Bold | 700 | 大标题、数据指标 |

---

## 间距与尺寸 Spacing

### 间距梯度

```css
:root {
  --spacing-1: 2px;
  --spacing-2: 4px;
  --spacing-3: 8px;
  --spacing-4: 12px;
  --spacing-5: 16px;
  --spacing-6: 20px;
  --spacing-7: 24px;
  --spacing-8: 32px;
  --spacing-9: 40px;
  --spacing-10: 48px;
  --spacing-11: 56px;
  --spacing-12: 64px;
}
```

| Token | 值 | 典型用途 |
|-------|-----|---------|
| --spacing-1 | 2px | 微小间距、图标偏移 |
| --spacing-2 | 4px | 图标与文字间距 |
| --spacing-3 | 8px | 组件内紧凑间距 |
| --spacing-4 | 12px | 组件内默认间距 |
| --spacing-5 | 16px | 组件间标准间距 |
| --spacing-6 | 20px | 区块内边距 |
| --spacing-7 | 24px | 区块间距 |
| --spacing-8 | 32px | 大区块间距 |
| --spacing-9 | 40px | 页面级间距 |
| --spacing-10 | 48px | 大页面级间距 |

### 组件内间距

```
紧凑(compact)：  8px 内边距
默认(default)：  12px 内边距
宽松(loose)：    16px 内边距
```

### 圆角梯度

```css
:root {
  --border-radius-none: 0px;
  --border-radius-small: 2px;
  --border-radius-medium: 4px;
  --border-radius-large: 8px;
  --border-radius-round: 16px;  /* 等于高度的一半 */
  --border-radius-circle: 50%;
}
```

| Token | 值 | 使用场景 |
|-------|-----|---------|
| --border-radius-small | 2px | 标签、Badge |
| --border-radius-medium | 4px | 按钮、输入框、卡片 |
| --border-radius-large | 8px | Dialog、Dropdown |
| --border-radius-round | 16px | 圆角按钮、Tag |
| --border-radius-circle | 50% | 头像、圆形图标按钮 |

### 控件高度

| 组件 | mini | small | default | large |
|------|------|-------|---------|-------|
| Button | 24px | 28px | 32px | 36px |
| Input | 24px | 28px | 32px | 36px |
| Select | 24px | 28px | 32px | 36px |
| DatePicker | 24px | 28px | 32px | 36px |
| Switch | -- | -- | 20px(h) | 24px(h) |

---

## 组件规范（含 CSS 代码）

### Button 按钮

#### 变体与 CSS

```css
/* Primary - 实心主要按钮 */
.arco-btn-primary {
  background-color: var(--color-primary);
  border: 1px solid var(--color-primary);
  color: #FFFFFF;
  border-radius: var(--border-radius-medium);
  padding: 0 15px;
  font-size: 14px;
  height: 32px;
  line-height: 32px;
  cursor: pointer;
  transition: all 0.2s;
}
.arco-btn-primary:hover {
  background-color: var(--color-primary-hover);
  border-color: var(--color-primary-hover);
}

/* Secondary - 次要按钮（默认） */
.arco-btn-secondary {
  background-color: transparent;
  border: 1px solid var(--color-border);
  color: var(--color-text-2);
  border-radius: var(--border-radius-medium);
  padding: 0 15px;
  font-size: 14px;
  height: 32px;
}
.arco-btn-secondary:hover {
  color: var(--color-primary);
  border-color: var(--color-primary);
}

/* Dashed - 虚线按钮 */
.arco-btn-dashed {
  background-color: transparent;
  border: 1px dashed var(--color-border);
  color: var(--color-text-2);
}

/* Outline - 描边按钮 */
.arco-btn-outline {
  background-color: transparent;
  border: 1px solid var(--color-primary);
  color: var(--color-primary);
}

/* Text - 文字按钮 */
.arco-btn-text {
  background-color: transparent;
  border: none;
  color: var(--color-primary);
  padding: 0 4px;
}
```

#### 尺寸对照表

| 尺寸 | 高度 | 内边距 | 字号 |
|------|------|--------|------|
| mini | 24px | 0 7px | 12px |
| small | 28px | 0 11px | 14px |
| default | 32px | 0 15px | 14px |
| large | 36px | 0 19px | 14px |

#### 加载与涟漪

```css
/* 加载态 */
.arco-btn-loading {
  pointer-events: none;
  opacity: 0.8;
}
.arco-btn-loading .arco-btn-icon {
  animation: arco-spin 1s linear infinite;
}

/* 涟漪效果（点击时水波纹） */
.arco-btn .arco-ripple {
  position: absolute;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.35);
  transform: scale(0);
  animation: arco-ripple-effect 0.5s ease-out;
}
@keyframes arco-ripple-effect {
  to { transform: scale(2.5); opacity: 0; }
}

/* 禁用态 */
.arco-btn-disabled {
  cursor: not-allowed;
  opacity: 0.5;
}

@keyframes arco-spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}
```

### Input 输入框

```css
/* 基础样式 */
.arco-input-wrapper {
  display: inline-flex;
  align-items: center;
  height: 32px;
  padding: 0 12px;
  border: 1px solid var(--color-border);
  border-radius: var(--border-radius-medium);
  background-color: var(--color-bg-white);
  transition: all 0.2s;
}

/* 聚焦态 */
.arco-input-wrapper:focus-within,
.arco-input-wrapper.arco-input-focus {
  border-color: var(--color-primary);
  box-shadow: 0 0 0 2px rgba(22, 93, 255, 0.2);
}

/* 错误态 */
.arco-input-wrapper.arco-input-error {
  border-color: var(--color-danger);
  box-shadow: 0 0 0 2px rgba(245, 63, 63, 0.2);
}

/* 禁用态 */
.arco-input-wrapper.arco-input-disabled {
  background-color: var(--color-fill-2);
  cursor: not-allowed;
  color: var(--color-text-4);
}

/* 前缀/后缀插槽 */
.arco-input-prefix,
.arco-input-suffix {
  display: inline-flex;
  align-items: center;
  color: var(--color-text-3);
  white-space: nowrap;
}

/* 搜索模式 */
.arco-input-search .arco-input-suffix {
  background-color: var(--color-primary);
  color: #FFFFFF;
  border-radius: 0 var(--border-radius-medium) var(--border-radius-medium) 0;
  padding: 0 12px;
  cursor: pointer;
  height: calc(100% + 2px);
  margin: -1px -13px -1px 8px;
}
```

### Table 表格

```css
/* 表头 */
.arco-table-th {
  background-color: var(--color-fill-1);
  color: var(--color-text-1);
  font-weight: 500;
  font-size: 14px;
  height: 48px;
  padding: 0 16px;
}

/* 数据行 */
.arco-table-td {
  height: 48px;
  padding: 0 16px;
  color: var(--color-text-2);
  font-size: 14px;
  border-bottom: 1px solid var(--color-border-light);
}

/* 悬浮行 */
.arco-table-tr:hover .arco-table-td {
  background-color: var(--color-fill-1);
}

/* 边框模式 */
.arco-table-border .arco-table-th,
.arco-table-border .arco-table-td {
  border-right: 1px solid var(--color-border-light);
}
.arco-table-border .arco-table-th {
  border-bottom: 1px solid var(--color-border);
}

/* 斑马纹 */
.arco-table-striped .arco-table-tr:nth-child(even) .arco-table-td {
  background-color: var(--color-fill-1);
}

/* 固定列阴影 */
.arco-table-col-fixed-left-last {
  box-shadow: 2px 0 6px rgba(0, 0, 0, 0.08);
}
.arco-table-col-fixed-right-first {
  box-shadow: -2px 0 6px rgba(0, 0, 0, 0.08);
}

/* 虚拟滚动配置说明 */
/*
  <Table
    virtualListProps={{ height: 400 }}
    scroll="{ y: 400 }"
    data={largeData}
  />
*/
```

### Modal 对话框

```css
/* 基础样式 */
.arco-modal {
  width: 520px;
  max-height: 70vh;
  border-radius: var(--border-radius-large);
  box-shadow: var(--shadow-3);
  background-color: var(--color-bg-white);
}

/* 标题栏 */
.arco-modal-header {
  padding: 16px 20px;
  font-size: 16px;
  font-weight: 600;
  color: var(--color-text-1);
  border-bottom: 1px solid var(--color-border-light);
}

/* 内容区 */
.arco-modal-body {
  padding: 20px;
  font-size: 14px;
  color: var(--color-text-2);
  overflow-y: auto;
  max-height: calc(70vh - 120px);
}

/* 底部按钮栏 */
.arco-modal-footer {
  padding: 12px 20px;
  text-align: right;
  border-top: 1px solid var(--color-border-light);
}

/* 遮罩层 */
.arco-modal-mask {
  background-color: rgba(29, 33, 41, 0.6);
}

/* 全屏模式 */
.arco-modal-fullscreen {
  width: 100vw;
  height: 100vh;
  max-height: 100vh;
  border-radius: 0;
  margin: 0;
}

/* 动画 */
.arco-modal-mask {
  animation: arco-modal-mask-fade-in 0.25s ease;
}
@keyframes arco-modal-mask-fade-in {
  from { opacity: 0; }
  to { opacity: 1; }
}
```

#### 尺寸推荐

| 场景 | 宽度 | 说明 |
|------|------|------|
| 确认框 | 400px | 简单提示 |
| 表单编辑 | 520px | 单表单 |
| 详情/多Tab | 720px | 复杂内容 |
| 全屏 | 100vw | 大量数据编辑 |

### DatePicker 日期选择

```css
/* 选择器触发器 */
.arco-picker {
  height: 32px;
  padding: 0 12px;
  border: 1px solid var(--color-border);
  border-radius: var(--border-radius-medium);
}

/* 范围选择器 */
.arco-picker-range {
  display: inline-flex;
  align-items: center;
  width: 280px;
}
.arco-picker-range .arco-picker-separator {
  color: var(--color-text-4);
  padding: 0 4px;
}

/* 快捷面板说明 */
/*
  <DatePicker
    shortcuts={[
      { label: "今天", value: () => Date.now() },
      { label: "近7天", value: () => dayjs().subtract(7, "day") },
      { label: "近30天", value: () => dayjs().subtract(30, "day") },
    ]}
  />
*/
```

---

## 暗色主题

### CSS 变量覆盖

```css
body[arco-theme="dark"] {
  /* 品牌色 */
  --color-primary: #3C7EFF;
  --color-primary-hover: #5A94FF;
  --color-primary-active: #206CCF;
  --arco-color-primary-6: #3C7EFF;
  --arco-color-primary-1: #0D1B3E;

  /* 文字色 */
  --color-text-1: #F5F5F5;
  --color-text-2: #C9CDD4;
  --color-text-3: #86909C;
  --color-text-4: #4E5969;

  /* 背景色 */
  --color-bg-1: #17171A;
  --color-bg-2: #232324;
  --color-bg-3: #2A2A2B;
  --color-bg-4: #3D3D3E;
  --color-bg-white: #17171A;

  /* 边框色 */
  --color-border: #3D3D3E;
  --color-border-light: #333334;

  /* 填充色 */
  --color-fill-1: #262626;
  --color-fill-2: #2E2E2E;
  --color-fill-3: #3D3D3E;
  --color-fill-4: #4E5969;

  /* 语义色微调 */
  --color-success: #23C343;
  --color-warning: #FF9A2E;
  --color-danger: #F76560;
}

/* 组件暗色适配 */
body[arco-theme="dark"] .arco-table-th {
  background-color: var(--color-fill-2);
}
body[arco-theme="dark"] .arco-btn-secondary {
  border-color: var(--color-border);
  color: var(--color-text-2);
}
body[arco-theme="dark"] .arco-input-wrapper {
  background-color: var(--color-fill-2);
  border-color: var(--color-border);
}
```

---

## 布局模式

### 后台管理标准布局

```
+--------------------------------------------------+
| Logo    [折叠]                [通知] [用户头像]   |  顶栏 60px
+--------+-----------------------------------------+
|        |  面包屑 / Tab 导航                        |
| 仪表盘 +-----------------------------------------+
| 用户管理|                                         |
| 角色管理|  内容区                                  |
| 系统设置|  padding: 20px                          |
|        |                                         |
|        |  +-------------------------------------+ |
|        |  | 搜索筛选栏                           | |
|        |  +-------------------------------------+ |
|        |  | 数据表格                             | |
|        |  |                                     | |
|        |  +-------------------------------------+ |
|        |  | 分页器                               | |
|        |  +-------------------------------------+ |
|        |                                         |
+--------+-----------------------------------------+
侧边栏：220px（展开）/ 60px（折叠）
```

### CSS Grid 布局实现

```css
.arco-layout {
  display: grid;
  grid-template-columns: 220px 1fr;
  grid-template-rows: 60px 1fr;
  grid-template-areas:
    "sidebar header"
    "sidebar content";
  height: 100vh;
  overflow: hidden;
}
.arco-layout.is-collapsed {
  grid-template-columns: 60px 1fr;
}
.arco-layout-header  { grid-area: header; background: var(--color-bg-white); border-bottom: 1px solid var(--color-border); }
.arco-layout-sidebar { grid-area: sidebar; background: var(--color-bg-white); border-right: 1px solid var(--color-border); overflow-y: auto; }
.arco-layout-content { grid-area: content; background: var(--color-bg-2); overflow-y: auto; padding: 20px; }
```

### 24 列栅格系统

```css
.arco-row { display: flex; flex-wrap: wrap; }
.arco-col-1  { width: 4.1667%; }
.arco-col-6  { width: 25%; }
.arco-col-8  { width: 33.3333%; }
.arco-col-12 { width: 50%; }
.arco-col-16 { width: 66.6667%; }
.arco-col-18 { width: 75%; }
.arco-col-24 { width: 100%; }

/* 栅格间距 */
.arco-row-gutter-16 { margin-left: -8px; margin-right: -8px; }
.arco-row-gutter-16 .arco-col { padding-left: 8px; padding-right: 8px; }
```

### 响应式断点

```css
/* xs: <576px */
@media screen and (max-width: 575px) {
  .arco-col-xs-24 { width: 100%; }
  .arco-layout { grid-template-columns: 0 1fr; }
}

/* sm: >=576px */
@media screen and (min-width: 576px) {
  .arco-col-sm-12 { width: 50%; }
}

/* md: >=768px */
@media screen and (min-width: 768px) {
  .arco-col-md-8 { width: 33.3333%; }
}

/* lg: >=992px */
@media screen and (min-width: 992px) {
  .arco-col-lg-6 { width: 25%; }
}

/* xl: >=1200px */
@media screen and (min-width: 1200px) {
  .arco-col-xl-6 { width: 25%; }
}

/* xxl: >=1600px */
@media screen and (min-width: 1600px) {
  .arco-layout-content { max-width: 1400px; margin: 0 auto; }
}
```

---

## 设计示例

### 搜索筛选栏

```html
<!-- 搜索筛选栏 -->
<div class="filter-bar">
  <Form layout="inline" :model="query">
    <FormItem label="关键词">
      <Input v-model="query.keyword" placeholder="请输入关键词" allow-clear />
    </FormItem>
    <FormItem label="状态">
      <Select v-model="query.status" placeholder="全部" allow-clear style="width: 120px">
        <Option value="active">启用</Option>
        <Option value="disabled">禁用</Option>
      </Select>
    </FormItem>
    <FormItem label="日期范围">
      <DatePicker v-model="query.dateRange" range style="width: 260px" />
    </FormItem>
    <FormItem>
      <Button type="primary" html-type="submit">查询</Button>
      <Button style="margin-left: 8px">重置</Button>
    </FormItem>
  </Form>
</div>

<style>
.filter-bar {
  background: var(--color-bg-white);
  border-radius: var(--border-radius-medium);
  padding: 16px 20px 0;
  margin-bottom: 16px;
}
</style>
```

### CRUD 表格

```html
<!-- 标准增删改查表格页面 -->
<div class="table-page">
  <!-- 搜索栏 -->
  <div class="filter-bar">...</div>

  <!-- 表格 -->
  <div class="table-card">
    <div class="table-toolbar">
      <span class="table-title">用户管理</span>
      <Space>
        <Button type="primary">新增用户</Button>
        <Button>批量导出</Button>
      </Space>
    </div>

    <Table :data="data" :bordered="false" :stripe="true"
           :pagination="{ pageSize: 20, showTotal: true, showPageSize: true }">
      <TableColumn title="姓名" data-index="name" :width="140" />
      <TableColumn title="邮箱" data-index="email" :ellipsis="true" />
      <TableColumn title="角色" data-index="role" :width="120" />
      <TableColumn title="状态" data-index="status" :width="100">
        <template #cell="{ record }">
          <Tag :color="record.status === 'active' ? 'green' : 'orangered'">
            {{ record.status === 'active' ? '启用' : '禁用' }}
          </Tag>
        </template>
      </TableColumn>
      <TableColumn title="操作" :width="160" fixed="right">
        <template #cell="{ record }">
          <Button type="text" size="mini">编辑</Button>
          <Button type="text" size="mini" status="danger">删除</Button>
        </template>
      </TableColumn>
    </Table>
  </div>
</div>

<style>
.table-page { padding: 20px; background: var(--color-bg-2); min-height: 100vh; }
.table-card {
  background: var(--color-bg-white);
  border-radius: var(--border-radius-medium);
  padding: 20px;
}
.table-toolbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}
.table-title { font-size: 16px; font-weight: 600; color: var(--color-text-1); }
</style>
```

### 表单带校验

```html
<!-- 带校验的表单 -->
<Form :model="form" :rules="rules" layout="vertical" ref="formRef">
  <Row :gutter="16">
    <Col :span="12">
      <FormItem field="name" label="姓名" required>
        <Input v-model="form.name" placeholder="请输入姓名" />
      </FormItem>
    </Col>
    <Col :span="12">
      <FormItem field="email" label="邮箱" required>
        <Input v-model="form.email" placeholder="请输入邮箱" />
      </FormItem>
    </Col>
  </Row>
  <FormItem field="role" label="角色" required>
    <Select v-model="form.role" placeholder="请选择角色">
      <Option value="admin">管理员</Option>
      <Option value="editor">编辑</Option>
      <Option value="viewer">查看者</Option>
    </Select>
  </FormItem>
  <FormItem field="remark" label="备注">
    <Textarea v-model="form.remark" placeholder="可选" :max-length="200" show-word-limit />
  </FormItem>
  <FormItem>
    <Space>
      <Button type="primary" @click="handleSubmit">提交</Button>
      <Button @click="handleCancel">取消</Button>
    </Space>
  </FormItem>
</Form>

<script>
const rules = {
  name: [{ required: true, message: "姓名不能为空" }],
  email: [
    { required: true, message: "邮箱不能为空" },
    { type: "email", message: "请输入有效邮箱" },
  ],
  role: [{ required: true, message: "请选择角色" }],
};
</script>
```

---

## 特色组件

| 组件 | 特色能力 |
|------|---------|
| Table | 虚拟滚动、树形数据、可编辑单元格、列固定 |
| Form | 动态增减表单项、联动校验 |
| Modal | 命令式调用、全屏、拖拽 |
| Tree | 虚拟滚动、可搜索、拖拽 |
| Transfer | 搜索过滤、懒加载 |
| DatePicker | 范围选择、快捷面板 |
| Trigger | 弹出层引擎（底层组件） |
| ResizeBox | 可拖拽调整大小 |
| Skeleton | 骨架屏 |
| Watermark | 水印 |
| Image | 图片预览、懒加载 |

---

## 适用场景

| 场景 | 推荐度 | 说明 |
|------|--------|------|
| 字节系项目 | 5/5 | 内部标准 |
| 现代化后台 | 5/5 | 设计感好，交互流畅 |
| SaaS 产品 | 4/5 | 定制灵活 |
| 数据可视化平台 | 4/5 | 与字节 ECharts 生态配合好 |
| 传统政企 | 3/5 | 风格偏现代，不一定合适 |
