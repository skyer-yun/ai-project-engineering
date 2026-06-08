---
type: design-system
name: Element Plus
status: verified
source: 官方文档整理 + 本地Token待整理
last-updated: 2026-05-19
homepage: https://element-plus.org
tech-stack: Vue 3
---

# Element Plus 设计系统速查

> Vue 3 生态最成熟的中后台组件库，政企信息化系统首选

---

## 色彩 Token

### 品牌色
```
主色：#409EFF（蓝色）
色阶：
  --el-color-primary-light-3:  #79BBFF
  --el-color-primary-light-5:  #A0CFFF
  --el-color-primary-light-7:  #C6E2FF
  --el-color-primary-light-8:  #D9ECFF
  --el-color-primary-light-9:  #ECF5FF
  --el-color-primary-dark-2:   #337ECC
```

### 语义色
```
成功：#67C23A
  light-3: #95D475  light-5: #B3E19D  light-9: #E1F3D8

警告：#E6A23C
  light-3: #EEBE77  light-5: #F3D19E  light-9: #FAECD8

错误：#F56C6C
  light-3: #F89898  light-5: #FAB6B6  light-9: #FDE2E2

信息：#909399
  light-3: #B1B3B8  light-5: #C8C9CC  light-9: #EDEDED
```

### 完整色彩 CSS 变量定义

```css
:root {
  /* 品牌色 */
  --el-color-primary: #409EFF;
  --el-color-primary-light-3: #79BBFF;
  --el-color-primary-light-5: #A0CFFF;
  --el-color-primary-light-7: #C6E2FF;
  --el-color-primary-light-8: #D9ECFF;
  --el-color-primary-light-9: #ECF5FF;
  --el-color-primary-dark-2: #337ECC;

  /* 语义色 */
  --el-color-success: #67C23A;
  --el-color-success-light-3: #95D475;
  --el-color-success-light-5: #B3E19D;
  --el-color-success-light-9: #E1F3D8;
  --el-color-success-dark-2: #529B2E;

  --el-color-warning: #E6A23C;
  --el-color-warning-light-3: #EEBE77;
  --el-color-warning-light-5: #F3D19E;
  --el-color-warning-light-9: #FAECD8;
  --el-color-warning-dark-2: #B88230;

  --el-color-danger: #F56C6C;
  --el-color-danger-light-3: #F89898;
  --el-color-danger-light-5: #FAB6B6;
  --el-color-danger-light-9: #FDE2E2;
  --el-color-danger-dark-2: #C45656;

  --el-color-info: #909399;
  --el-color-info-light-3: #B1B3B8;
  --el-color-info-light-5: #C8C9CC;
  --el-color-info-light-9: #EDEDED;
  --el-color-info-dark-2: #73767A;

  /* 文字色 */
  --el-text-color-primary: #303133;
  --el-text-color-regular: #606266;
  --el-text-color-secondary: #909399;
  --el-text-color-placeholder: #A8ABB2;
  --el-text-color-disabled: #C0C4CC;

  /* 背景色 */
  --el-bg-color: #FFFFFF;
  --el-bg-color-page: #F2F3F5;
  --el-bg-color-overlay: #FFFFFF;

  /* 边框色 */
  --el-border-color: #DCDFE6;
  --el-border-color-light: #E4E7ED;
  --el-border-color-lighter: #EBEEF5;
  --el-border-color-extra-light: #F2F6FC;

  /* 填充色 */
  --el-fill-color: #F0F2F5;
  --el-fill-color-light: #F5F7FA;
  --el-fill-color-lighter: #FAFAFA;
  --el-fill-color-extra-light: #FAFAFA;
  --el-fill-color-blank: #FFFFFF;

  /* 阴影 */
  --el-box-shadow: 0px 12px 32px 4px rgba(0,0,0,0.04),
                   0px 8px 20px rgba(0,0,0,0.08);
  --el-box-shadow-light: 0px 0px 12px rgba(0,0,0,0.12);
  --el-box-shadow-lighter: 0px 0px 6px rgba(0,0,0,0.12);
}
```

### 色彩使用速查表

| Token | 值 | 使用场景 |
|-------|-----|---------|
| --el-color-primary | #409EFF | 主按钮、选中态、链接 |
| --el-color-primary-light-3 | #79BBFF | 主色悬浮态 |
| --el-color-primary-light-9 | #ECF5FF | 主色背景、选中行背景 |
| --el-color-success | #67C23A | 成功提示、状态标签 |
| --el-color-warning | #E6A23C | 警告提示、待处理标签 |
| --el-color-danger | #F56C6C | 错误提示、删除操作、必填标记 |
| --el-color-info | #909399 | 次要信息、禁用态文字 |
| --el-text-color-primary | #303133 | 标题、表头文字 |
| --el-text-color-regular | #606266 | 正文内容 |
| --el-bg-color-page | #F2F3F5 | 页面底色 |
| --el-border-color | #DCDFE6 | 默认边框、分割线 |

### 暗色主题变量

```css
html.dark {
  --el-color-primary: #409EFF;
  --el-color-primary-light-3: #3375B4;
  --el-color-primary-light-5: #2A5F95;
  --el-color-primary-light-7: #204A76;
  --el-color-primary-light-9: #173457;

  --el-text-color-primary: #E5EAF3;
  --el-text-color-regular: #CFD3DC;
  --el-text-color-secondary: #A3A6AD;
  --el-text-color-placeholder: #8D9095;

  --el-bg-color: #141414;
  --el-bg-color-page: #0A0A0A;
  --el-bg-color-overlay: #1D1E1F;

  --el-border-color: #4C4D4F;
  --el-border-color-light: #414243;
  --el-border-color-lighter: #363637;

  --el-fill-color: #303030;
  --el-fill-color-light: #262727;
}
```

---

## 排版规范 Typography

### 字体栈

```css
:root {
  --el-font-family: "Helvetica Neue", Helvetica, "PingFang SC",
    "Hiragino Sans GB", "Microsoft YaHei", "WenQuanYi Micro Hei",
    Arial, sans-serif;
  --el-font-family-monospace: "SFMono-Regular", Consolas,
    "Liberation Mono", Menlo, Courier, monospace;
}
```

| 平台 | 首选字体 | 说明 |
|------|---------|------|
| macOS | "PingFang SC" | 苹方，系统默认 |
| Windows | "Microsoft YaHei" | 微软雅黑 |
| Linux | "WenQuanYi Micro Hei" | 文泉驿微米黑 |
| 代码/等宽 | SFMono-Regular, Consolas | 代码块、数字对齐 |

### 字号梯度

```css
:root {
  --el-font-size-extra-large: 20px;
  --el-font-size-large: 16px;
  --el-font-size-medium: 14px;
  --el-font-size-base: 14px;
  --el-font-size-small: 13px;
  --el-font-size-extra-small: 12px;
}
```

| Token | 值 | 使用场景 |
|-------|-----|---------|
| --el-font-size-extra-large | 20px | 页面主标题 |
| --el-font-size-large | 16px | 模块标题、Dialog 标题 |
| --el-font-size-medium | 14px | 正文（默认） |
| --el-font-size-base | 14px | 组件内文字（默认） |
| --el-font-size-small | 13px | 辅助文字、表格次要列 |
| --el-font-size-extra-small | 12px | 标签、Badge、提示文字 |

### 行高

```
--el-font-line-height-primary: 24px  （对应 14px 字号，1.71 倍）
默认行高：1.5 ~ 1.8
标题行高：1.3
```

### 字重

| Token | 值 | 使用场景 |
|-------|-----|---------|
| --el-font-weight-primary | 700 | 页面标题 |
| --el-font-weight-secondary | 400 | 正文、常规文字 |
| bold | 700 | 强调 |
| normal | 400 | 默认 |
| lighter | 300 | 辅助说明 |

---

## 间距与尺寸 Spacing

### 间距梯度

```css
:root {
  /* 内边距/外边距梯度 */
  --el-spacing-0: 0px;
  --el-spacing-4: 4px;
  --el-spacing-8: 8px;
  --el-spacing-12: 12px;
  --el-spacing-16: 16px;
  --el-spacing-20: 20px;
  --el-spacing-24: 24px;
  --el-spacing-32: 32px;
  --el-spacing-40: 40px;
  --el-spacing-48: 48px;
}
```

| Token | 值 | 典型用途 |
|-------|-----|---------|
| --el-spacing-4 | 4px | 图标与文字间距 |
| --el-spacing-8 | 8px | 组件内紧凑间距 |
| --el-spacing-12 | 12px | 组件内默认间距 |
| --el-spacing-16 | 16px | 组件间标准间距 |
| --el-spacing-20 | 20px | 区块内边距 |
| --el-spacing-24 | 24px | 区块间距、页面边距 |
| --el-spacing-32 | 32px | 大区块间距 |
| --el-spacing-48 | 48px | 页面级间距 |

### 圆角梯度

```css
:root {
  --el-border-radius-base: 4px;
  --el-border-radius-small: 2px;
  --el-border-radius-round: 20px;
  --el-border-radius-circle: 100%;
}
```

| Token | 值 | 使用场景 |
|-------|-----|---------|
| --el-border-radius-base | 4px | 按钮、输入框、卡片 |
| --el-border-radius-small | 2px | 标签、小徽章 |
| --el-border-radius-round | 20px | 圆角按钮、胶囊标签 |
| --el-border-radius-circle | 100% | 头像、圆形图标 |

### 控件高度

| 组件 | large | default | small |
|------|-------|---------|-------|
| Button | 40px | 32px | 24px |
| Input | 40px | 32px | 24px |
| Select | 40px | 32px | 24px |
| DatePicker | 40px | 32px | 24px |
| Switch | -- | 20px（高度） | 16px（高度） |
| Checkbox | -- | 14px（方块） | 12px（方块） |
| Radio | -- | 14px（圆形） | 12px（圆形） |
| 圆角 | 4px | 4px | 4px |

---

## 组件规范（含 CSS 代码）

### Button 按钮

#### 5 种变体

```css
/* Primary - 主要按钮 */
.el-button--primary {
  background-color: var(--el-color-primary);
  border-color: var(--el-color-primary);
  color: #FFFFFF;
  border-radius: var(--el-border-radius-base);
  padding: 8px 16px;
  font-size: var(--el-font-size-base);
  height: 32px;
}
.el-button--primary:hover {
  background-color: var(--el-color-primary-light-3);
  border-color: var(--el-color-primary-light-3);
}
.el-button--primary:active {
  background-color: var(--el-color-primary-dark-2);
  border-color: var(--el-color-primary-dark-2);
}

/* Success - 成功按钮 */
.el-button--success {
  background-color: var(--el-color-success);
  border-color: var(--el-color-success);
  color: #FFFFFF;
}

/* Warning - 警告按钮 */
.el-button--warning {
  background-color: var(--el-color-warning);
  border-color: var(--el-color-warning);
  color: #FFFFFF;
}

/* Danger - 危险按钮 */
.el-button--danger {
  background-color: var(--el-color-danger);
  border-color: var(--el-color-danger);
  color: #FFFFFF;
}

/* Info - 信息按钮 */
.el-button--info {
  background-color: var(--el-color-info);
  border-color: var(--el-color-info);
  color: #FFFFFF;
}
```

#### 尺寸对照表

| 尺寸 | 高度 | 内边距 | 字号 | 圆角 |
|------|------|--------|------|------|
| large | 40px | 12px 20px | 14px | 4px |
| default | 32px | 8px 16px | 14px | 4px |
| small | 24px | 5px 11px | 12px | 4px |

#### 状态

```css
/* 禁用态 */
.el-button.is-disabled {
  cursor: not-allowed;
  opacity: 0.6;
  background-image: none;
}

/* 加载态 */
.el-button.is-loading {
  pointer-events: none;
  position: relative;
}
.el-button.is-loading::before {
  content: "";
  display: inline-block;
  width: 14px;
  height: 14px;
  border: 2px solid currentColor;
  border-top-color: transparent;
  border-radius: 50%;
  animation: el-rotate 0.6s linear infinite;
  margin-right: 6px;
}
@keyframes el-rotate {
  to { transform: rotate(360deg); }
}

/* 文字按钮 */
.el-button--text {
  background: transparent;
  border-color: transparent;
  color: var(--color-primary);
  padding: 0;
  height: auto;
}
.el-button--text:hover {
  background: transparent;
  color: var(--color-primary-light-3);
}
```

### Input 输入框

```css
/* 基础样式 */
.el-input__wrapper {
  background-color: var(--el-bg-color);
  border: 1px solid var(--el-border-color);
  border-radius: var(--el-border-radius-base);
  padding: 1px 11px;
  height: 32px;
  box-shadow: 0 0 0 1px var(--el-border-color) inset;
  transition: box-shadow 0.2s;
}

/* 聚焦态 */
.el-input__wrapper.is-focus {
  box-shadow: 0 0 0 1px var(--el-color-primary) inset;
}

/* 错误态 */
.el-form-item.is-error .el-input__wrapper {
  box-shadow: 0 0 0 1px var(--el-color-danger) inset;
}

/* 禁用态 */
.el-input.is-disabled .el-input__wrapper {
  background-color: var(--el-fill-color-light);
  cursor: not-allowed;
  color: var(--el-text-color-disabled);
}

/* 前缀/后缀图标 */
.el-input__prefix,
.el-input__suffix {
  display: flex;
  align-items: center;
  color: var(--el-text-color-placeholder);
}

/* 带字数统计的文本域 */
.el-textarea__inner {
  padding: 5px 11px;
  resize: vertical;
  min-height: 32px;
}
```

### Table 表格

```css
/* 表头 */
.el-table__header th {
  background-color: var(--el-fill-color-light);
  color: var(--el-text-color-primary);
  font-weight: 600;
  height: 54px;
  padding: 0;
  font-size: 14px;
}

/* 数据行 */
.el-table__body td {
  height: 48px;
  padding: 0;
  color: var(--el-text-color-regular);
  font-size: 14px;
}

/* 悬浮行 */
.el-table__body tr:hover > td {
  background-color: var(--el-fill-color-light) !important;
}

/* 斑马纹 */
.el-table--striped .el-table__body tr.el-table__row--striped td {
  background-color: #FAFAFA;
}

/* 边框模式 */
.el-table--border .el-table__cell {
  border-right: 1px solid var(--el-border-color-lighter);
}
.el-table--border th.el-table__cell {
  border-bottom: 1px solid var(--el-border-color-lighter);
}

/* 空状态 */
.el-table__empty-block {
  min-height: 60px;
  text-align: center;
  color: var(--el-text-color-secondary);
}

/* 展开行 */
.el-table__expanded-cell {
  padding: 20px 50px;
  background-color: var(--el-fill-color-lighter);
}
```

### Form 表单

```css
/* 标签 */
.el-form-item__label {
  color: var(--el-text-color-regular);
  font-size: var(--el-font-size-base);
  padding: 0 12px 0 0;
  line-height: 32px;
}

/* 左对齐标签（默认） */
.el-form--label-left .el-form-item__label {
  text-align: left;
  justify-content: flex-start;
}

/* 顶部对齐标签 */
.el-form--label-top .el-form-item__label {
  padding: 0 0 8px 0;
  text-align: left;
}

/* 校验错误 */
.el-form-item.is-error .el-form-item__label {
  color: var(--el-color-danger);
}
.el-form-item__error {
  color: var(--el-color-danger);
  font-size: 12px;
  line-height: 1;
  padding-top: 4px;
}

/* 行内表单 */
.el-form--inline .el-form-item {
  display: inline-flex;
  margin-right: 16px;
  margin-bottom: 0;
}

/* 表单项间距 */
.el-form-item {
  margin-bottom: 18px;
}
```

### Dialog 对话框

```css
/* 基础样式 */
.el-dialog {
  --el-dialog-width: 50%;
  --el-dialog-margin-top: 15vh;
  border-radius: var(--el-border-radius-base);
  box-shadow: var(--el-box-shadow);
  overflow: hidden;
}

/* 标题栏 */
.el-dialog__header {
  padding: 16px 20px 10px;
  color: var(--el-text-color-primary);
  font-size: var(--el-font-size-large);
  font-weight: 700;
}

/* 内容区 */
.el-dialog__body {
  padding: 20px;
  color: var(--el-text-color-regular);
  font-size: var(--el-font-size-base);
}

/* 底部按钮栏 */
.el-dialog__footer {
  padding: 10px 20px 16px;
  text-align: right;
}

/* 遮罩层 */
.el-overlay {
  background-color: rgba(0, 0, 0, 0.5);
}

/* 全屏模式 */
.el-dialog.is-fullscreen {
  --el-dialog-width: 100%;
  --el-dialog-margin-top: 0;
  margin-bottom: 0;
  border-radius: 0;
  height: 100vh;
}

/* 打开动画 */
.el-overlay-dialog {
  animation: el-dialog-fade-in 0.3s ease;
}
@keyframes el-dialog-fade-in {
  from { opacity: 0; transform: translateY(-20px); }
  to { opacity: 1; transform: translateY(0); }
}
```

#### 尺寸推荐

| 场景 | 宽度 | 说明 |
|------|------|------|
| 确认对话框 | 420px | 简单提示、确认删除 |
| 表单对话框 | 600px | 单表单编辑 |
| 详情对话框 | 800px | 复杂表单、多 Tab |
| 全屏 | 100% | 大量内容编辑 |

### Select 选择器

```css
/* 选择器触发器 */
.el-select__wrapper {
  min-height: 32px;
  padding: 0 8px;
  border: 1px solid var(--el-border-color);
  border-radius: var(--el-border-radius-base);
  background: var(--el-bg-color);
  cursor: pointer;
}

/* 下拉面板 */
.el-select-dropdown {
  border-radius: var(--el-border-radius-base);
  box-shadow: var(--el-box-shadow-light);
  border: 1px solid var(--el-border-color-lighter);
  max-height: 274px;
  overflow-y: auto;
}

/* 选项 */
.el-select-dropdown__item {
  height: 34px;
  padding: 0 32px 0 20px;
  font-size: var(--el-font-size-base);
  color: var(--el-text-color-regular);
  line-height: 34px;
}

/* 选中态 */
.el-select-dropdown__item.is-selected {
  color: var(--el-color-primary);
  font-weight: 700;
}

/* 悬浮态 */
.el-select-dropdown__item:hover {
  background-color: var(--el-fill-color-light);
}

/* 搜索输入 */
.el-select__input {
  border: none;
  outline: none;
  font-size: var(--el-font-size-base);
  height: 24px;
}

/* 多选标签 */
.el-select__tags .el-tag {
  max-width: 160px;
  margin: 2px 0 2px 6px;
}
```

---

## 布局模式

### 后台管理标准布局

```
+----------------------------------------------+
| Logo  [折叠按钮]               [用户信息]     |  顶栏 60px
+--------+-------------------------------------+
|        |  面包屑 / Tab 标签                    |
| 菜单1  +-------------------------------------+
| 菜单2  |                                     |
| 菜单3  |  内容区                              |
|        |  padding: 20px                      |
|        |                                     |
|        |  +-------------------------------+  |
|        |  | 搜索栏 / 操作按钮             |  |
|        |  +-------------------------------+  |
|        |  | 表格 / 卡片列表               |  |
|        |  |                               |  |
|        |  +-------------------------------+  |
|        |  | 分页器                         |  |
|        |  +-------------------------------+  |
|        |                                     |
+--------+-------------------------------------+
| 折叠按钮                                      |
+--------+-------------------------------------+
侧边栏：210px（展开）/ 64px（折叠）
```

### CSS Grid 布局实现

```css
.admin-layout {
  display: grid;
  grid-template-columns: 210px 1fr;
  grid-template-rows: 60px 1fr;
  grid-template-areas:
    "sidebar header"
    "sidebar content";
  height: 100vh;
}
.admin-layout.is-collapsed {
  grid-template-columns: 64px 1fr;
}
.admin-header  { grid-area: header; }
.admin-sidebar { grid-area: sidebar; }
.admin-content { grid-area: content; overflow-y: auto; padding: 20px; }
```

### 24 列栅格系统

```css
/* 基于 flex 的 24 列栅格 */
.el-row { display: flex; flex-wrap: wrap; }
.el-col-1  { width: 4.1667%; }
.el-col-6  { width: 25%; }
.el-col-8  { width: 33.3333%; }
.el-col-12 { width: 50%; }
.el-col-16 { width: 66.6667%; }
.el-col-18 { width: 75%; }
.el-col-24 { width: 100%; }

/* 栅格间距 */
.el-row--gutter-16 { margin-left: -8px; margin-right: -8px; }
.el-row--gutter-16 .el-col { padding-left: 8px; padding-right: 8px; }
```

### 响应式断点

```css
/* xs: <768px */
@media screen and (max-width: 767px) {
  .el-col-xs-24 { width: 100%; }
  .admin-layout { grid-template-columns: 0 1fr; }
}

/* sm: >=768px */
@media screen and (min-width: 768px) {
  .el-col-sm-12 { width: 50%; }
}

/* md: >=992px */
@media screen and (min-width: 992px) {
  .el-col-md-8 { width: 33.3333%; }
  .el-col-md-16 { width: 66.6667%; }
}

/* lg: >=1200px */
@media screen and (min-width: 1200px) {
  .el-col-lg-6 { width: 25%; }
}

/* xl: >=1920px */
@media screen and (min-width: 1920px) {
  .admin-content { max-width: 1680px; margin: 0 auto; }
}
```

---

## 设计示例

### 按钮组示例

```html
<!-- 操作按钮组 -->
<div class="action-bar">
  <el-button type="primary" icon="Plus">新增</el-button>
  <el-button type="danger" icon="Delete" plain>批量删除</el-button>
  <el-button icon="Download">导出</el-button>
  <el-button icon="Refresh" circle></el-button>
</div>

<style>
.action-bar {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 16px;
}
.action-bar .el-button + .el-button { margin-left: 0; }
</style>
```

### 水平表单布局

```html
<!-- 标签左对齐的搜索表单 -->
<el-form :model="query" :inline="true" label-width="80px">
  <el-form-item label="关键词">
    <el-input v-model="query.keyword" placeholder="请输入" clearable />
  </el-form-item>
  <el-form-item label="状态">
    <el-select v-model="query.status" placeholder="全部" clearable>
      <el-option label="启用" value="active" />
      <el-option label="禁用" value="disabled" />
    </el-select>
  </el-form-item>
  <el-form-item label="创建日期">
    <el-date-picker v-model="query.dateRange" type="daterange"
      start-placeholder="开始日期" end-placeholder="结束日期" />
  </el-form-item>
  <el-form-item>
    <el-button type="primary" icon="Search">查询</el-button>
    <el-button icon="RefreshLeft">重置</el-button>
  </el-form-item>
</el-form>

<style>
.el-form--inline .el-form-item {
  margin-right: 16px;
  margin-bottom: 16px;
}
/* 搜索表单通常放在卡片内 */
.search-card {
  background: #fff;
  border-radius: 4px;
  padding: 20px 20px 4px;
  margin-bottom: 16px;
}
</style>
```

### 表格带工具栏

```html
<!-- 标准表格页面结构 -->
<div class="table-page">
  <!-- 搜索区域 -->
  <div class="search-card">
    <el-form :inline="true">...</el-form>
  </div>

  <!-- 表格区域 -->
  <div class="table-card">
    <div class="table-toolbar">
      <span class="table-title">用户列表</span>
      <div class="table-actions">
        <el-button type="primary" size="small">新增</el-button>
        <el-button size="small">导出</el-button>
      </div>
    </div>

    <el-table :data="tableData" stripe border style="width: 100%">
      <el-table-column type="selection" width="55" />
      <el-table-column prop="name" label="姓名" min-width="120" />
      <el-table-column prop="role" label="角色" min-width="100" />
      <el-table-column prop="status" label="状态" width="100">
        <template #default="{ row }">
          <el-tag :type="row.status === 'active' ? 'success' : 'info'">
            {{ row.status === 'active' ? '启用' : '禁用' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="200" fixed="right">
        <template #default="{ row }">
          <el-button link type="primary" size="small">编辑</el-button>
          <el-button link type="danger" size="small">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <div class="table-pagination">
      <el-pagination background layout="total, sizes, prev, pager, next, jumper"
        :total="total" :page-sizes="[10, 20, 50, 100]" />
    </div>
  </div>
</div>

<style>
.table-page { padding: 20px; background: var(--el-bg-color-page); }
.table-card {
  background: #fff;
  border-radius: 4px;
  padding: 20px;
}
.table-toolbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}
.table-title { font-size: 16px; font-weight: 600; }
.table-actions { display: flex; gap: 8px; }
.table-pagination { display: flex; justify-content: flex-end; margin-top: 16px; }
</style>
```

---

## CSS 变量覆盖指南

### 品牌色定制（3 步）

```css
/* Step 1: 在 :root 中覆盖主色 */
:root {
  --el-color-primary: #1A73E8;          /* 改为你的品牌色 */
  --el-color-primary-light-3: #5BA0F0;  /* 自动计算或手动设置 */
  --el-color-primary-light-5: #8DC1F7;
  --el-color-primary-light-7: #BDD9FB;
  --el-color-primary-light-8: #D1E6FD;
  --el-color-primary-light-9: #E8F2FF;
  --el-color-primary-dark-2: #155CB8;
}

/* Step 2: 覆盖圆角（如需要更圆润） */
:root {
  --el-border-radius-base: 6px;
  --el-border-radius-small: 4px;
  --el-border-radius-round: 24px;
}

/* Step 3: 覆盖字号（如需要更大字体） */
:root {
  --el-font-size-base: 14px;
  --el-font-size-small: 13px;
}
```

### 通过 SCSS 变量定制（构建时）

```scss
/* styles/element-variables.scss */
$--color-primary: #1A73E8;
$--font-size-base: 14px;
$--border-radius-base: 6px;

/* vite.config.ts 中配置 */
/* css: { preprocessorOptions: { scss: { additionalData: `@use "@/styles/element-variables.scss" as *;` } } } */
```

### 常见定制场景

| 场景 | 需要覆盖的变量 |
|------|---------------|
| 品牌色 | --el-color-primary 系列 |
| 圆角风格 | --el-border-radius-base |
| 字号 | --el-font-size-base 系列 |
| 页面底色 | --el-bg-color-page |
| 紧凑布局 | 减小 spacing + 控件高度 |
| 暗色模式 | html.dark 块中覆盖所有色值 |

---

## 特色组件

| 组件 | 特色能力 |
|------|---------|
| Table | 虚拟滚动、树形数据、展开行、合并单元格 |
| Form | 内置校验引擎（async-validator）、动态表单 |
| Dialog | 命令式调用（ElMessageBox）、拖拽 |
| Cascader | 级联选择、懒加载、多选 |
| Transfer | 穿梭框 |
| Tree | 虚拟滚动、拖拽排序、懒加载 |
| DatePicker | 日期范围、快捷选项、周/月/年 |
| Upload | 拖拽上传、手动上传、图片墙 |
| InfiniteScroll | 无限滚动指令 |
| Loading | 全局/局部加载指令 |

## 适用场景

| 场景 | 推荐度 | 说明 |
|------|--------|------|
| 政企信息化 | 5/5 | 最成熟选择，生态完善 |
| 内部管理系统 | 5/5 | 开箱即用 |
| 数据中台 | 4/5 | 表格/表单能力强 |
| SaaS 产品 | 4/5 | 定制成本适中 |
| 移动端 | 2/5 | 不推荐，用 NutUI 或 Vant |
