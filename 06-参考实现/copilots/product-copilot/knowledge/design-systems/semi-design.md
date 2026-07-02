---
type: design-system
name: Semi Design
status: verified
source: 官方文档整理
last-updated: 2026-05-19
homepage: https://semi.design
tech-stack: React
---

# Semi Design 设计系统速查

> 抖音前端团队出品，Design Token 体系最完善，暗色主题原生支持

## Design Token 体系（核心特色）

### 三层 Token 架构

Semi Design 的核心差异化优势在于完善的三层 Token 体系，实现从设计到代码的全链路主题管理。

```
Layer 1 - 基础 Token（Primitive）：
  原始颜色值，直接对应色板
  示例：#6B53F4、#00B368、#E6A23C

Layer 2 - 语义 Token（Semantic）：
  语义化命名，描述用途而非色值
  示例：--semi-color-primary、--semi-color-success
  暗色主题时自动映射到不同的基础 Token

Layer 3 - 组件 Token（Component）：
  绑定到具体组件具体部位的 Token
  示例：--semi-button-bg-primary、--semi-input-border-focus
  粒度最细，控制最精确

覆盖优先级：
  组件 Token > 语义 Token > 基础 Token
  即：如果同时设置了 --semi-button-bg-primary 和 --semi-color-primary
  Button 组件会优先使用 --semi-button-bg-primary
```

### 语义色 Token 完整定义

```css
:root {
  /* 品牌色 */
  --semi-color-primary:                  #6B53F4;
  --semi-color-primary-hover:            #7D68F6;
  --semi-color-primary-active:           #5A40E8;
  --semi-color-primary-disabled:         #B8B0F9;
  --semi-color-primary-light:            rgba(107, 83, 244, 0.08);

  /* 功能语义色 */
  --semi-color-success:                  #00B368;
  --semi-color-success-hover:            #00C976;
  --semi-color-success-active:           #009E5C;
  --semi-color-success-disabled:         #8FD9B9;
  --semi-color-success-light:            rgba(0, 179, 104, 0.08);

  --semi-color-warning:                  #E6A23C;
  --semi-color-warning-hover:            #EDB34E;
  --semi-color-warning-active:           #D4912A;
  --semi-color-warning-disabled:         #F2D48A;
  --semi-color-warning-light:            rgba(230, 162, 60, 0.08);

  --semi-color-danger:                   #F93920;
  --semi-color-danger-hover:             #FA5A44;
  --semi-color-danger-active:            #E02D16;
  --semi-color-danger-disabled:          #FB9C92;
  --semi-color-danger-light:             rgba(249, 57, 32, 0.08);

  --semi-color-info:                     #0077FA;
  --semi-color-info-hover:               #1A8CFF;
  --semi-color-info-active:              #006ADB;
  --semi-color-info-disabled:            #80BFEC;

  /* 文字色层级 */
  --semi-color-text-0:                   #000000;
  --semi-color-text-1:                   #141A24;
  --semi-color-text-2:                   #5C6370;
  --semi-color-text-3:                   #A9AEB8;

  /* 背景色层级 */
  --semi-color-bg-0:                     #FFFFFF;
  --semi-color-bg-1:                     #F9F9F9;
  --semi-color-bg-2:                     #F1F1F1;
  --semi-color-bg-3:                     #E8E8E8;
  --semi-color-bg-4:                     #DDDDDD;

  /* 边框与阴影 */
  --semi-color-border:                   #E1E1E1;
  --semi-color-border-light:             #F3F3F3;
  --semi-color-shadow:                   rgba(0, 0, 0, 0.08);
  --semi-color-focus-border:             #6B53F4;

  /* 链接 */
  --semi-color-link:                     #6B53F4;
  --semi-color-link-hover:               #7D68F6;
  --semi-color-link-active:              #5A40E8;
  --semi-color-link-visited:             #5B3EBF;
}
```

### 暗色主题完整色板

```css
body[theme-mode="dark"] {
  /* 品牌色（暗色下微调） */
  --semi-color-primary:                  #8172EC;
  --semi-color-primary-hover:            #9486F0;
  --semi-color-primary-active:           #6B53F4;
  --semi-color-primary-disabled:         #4A3D8F;
  --semi-color-primary-light:            rgba(129, 114, 236, 0.15);

  /* 功能语义色（暗色适配） */
  --semi-color-success:                  #00C976;
  --semi-color-success-hover:            #33D491;
  --semi-color-success-active:           #00B368;
  --semi-color-success-disabled:         #2D6B4A;

  --semi-color-warning:                  #EDB34E;
  --semi-color-warning-hover:            #F1C467;
  --semi-color-warning-active:           #E6A23C;
  --semi-color-warning-disabled:         #7A5B2A;

  --semi-color-danger:                   #FA5A44;
  --semi-color-danger-hover:             #FB7B68;
  --semi-color-danger-active:            #F93920;
  --semi-color-danger-disabled:          #843428;

  /* 文字色（暗色反转） */
  --semi-color-text-0:                   #F5F5F5;
  --semi-color-text-1:                   #D9D9D9;
  --semi-color-text-2:                   #8C8C8C;
  --semi-color-text-3:                   #595959;

  /* 背景色（暗色层级） */
  --semi-color-bg-0:                     #141414;
  --semi-color-bg-1:                     #1C1C1C;
  --semi-color-bg-2:                     #242424;
  --semi-color-bg-3:                     #2C2C2C;
  --semi-color-bg-4:                     #363636;

  /* 边框 */
  --semi-color-border:                   #3D3D3D;
  --semi-color-border-light:             #2C2C2C;
  --semi-color-shadow:                   rgba(0, 0, 0, 0.3);
}
```

### 主题切换 API

```javascript
import { setTheme, getTheme } from '@douyinfe/semi-ui';

// 方式 1：切换为暗色（内置方案）
document.body.setAttribute('theme-mode', 'dark');

// 方式 2：通过 setTheme 精确控制
setTheme({
  '--semi-color-bg-0': '#141414',
  '--semi-color-bg-1': '#1C1C1C',
  '--semi-color-text-0': '#F5F5F5',
  '--semi-color-text-1': '#D9D9D9',
  '--semi-color-border': '#3D3D3D',
});

// 方式 3：切换品牌色
setTheme({
  '--semi-color-primary': '#1677FF',
  '--semi-color-primary-hover': '#4096FF',
  '--semi-color-primary-active': '#0958D9',
  '--semi-color-link': '#1677FF',
});

// 读取当前主题配置
const currentTheme = getTheme();
```

### 组件 Token 示例

```css
/* Button 组件 Token */
--semi-button-bg-primary:          var(--semi-color-primary);
--semi-button-bg-primary-hover:    var(--semi-color-primary-hover);
--semi-button-bg-primary-active:   var(--semi-color-primary-active);
--semi-button-bg-primary-disabled: var(--semi-color-primary-disabled);
--semi-button-text-primary:       #FFFFFF;
--semi-button-radius:             var(--semi-border-radius-small);

/* Input 组件 Token */
--semi-input-bg:                   var(--semi-color-bg-0);
--semi-input-border:               var(--semi-color-border);
--semi-input-border-focus:         var(--semi-color-primary);
--semi-input-border-hover:         var(--semi-color-primary-hover);
--semi-input-placeholder:          var(--semi-color-text-3);
--semi-input-text:                 var(--semi-color-text-1);
--semi-input-radius:               var(--semi-border-radius-small);

/* Table 组件 Token */
--semi-table-bg:                   var(--semi-color-bg-0);
--semi-table-header-bg:            var(--semi-color-bg-1);
--semi-table-row-hover-bg:         var(--semi-color-primary-light);
--semi-table-border:               var(--semi-color-border);
--semi-table-text:                 var(--semi-color-text-1);
```

## 色彩系统

### 文字色层级说明

| Token | 色值 | 用途 | 使用场景 |
|-------|------|------|---------|
| text-0 | #000000 / #F5F5F5 | 标题/强调 | 页面标题、弹窗标题 |
| text-1 | #141A24 / #D9D9D9 | 正文/常规 | 段落文字、表格内容 |
| text-2 | #5C6370 / #8C8C8C | 次要/辅助 | 描述文字、表格次级 |
| text-3 | #A9AEB8 / #595959 | 占位/禁用 | placeholder、禁用态 |

### 背景层级说明

| Token | 色值 | 用途 | 使用场景 |
|-------|------|------|---------|
| bg-0 | #FFFFFF / #141414 | 页面底色 | 最底层背景 |
| bg-1 | #F9F9F9 / #1C1C1C | 内容区底色 | 卡片背景、表头 |
| bg-2 | #F1F1F1 / #242424 | 弹出层底色 | 下拉菜单、弹窗 |
| bg-3 | #E8E8E8 / #2C2C2C | 特殊底色 | 选中态背景 |
| bg-4 | #DDDDDD / #363636 | 强调底色 | hover 态、活跃标签 |

## 排版规范

### 字体栈

```css
:root {
  --semi-font-family: -apple-system, BlinkMacSystemFont, "Segoe UI",
    "PingFang SC", "Hiragino Sans GB", "Microsoft YaHei",
    "Helvetica Neue", Helvetica, Arial, sans-serif;
  --semi-font-family-code: "SFMono-Regular", Consolas, "Liberation Mono",
    Menlo, Courier, monospace;
}
```

### 字号梯度

| Token | 字号 | 行高 | 字重 | 用途 |
|-------|------|------|------|------|
| font-size-title-1 | 24px | 32px | 600 | 页面主标题 |
| font-size-title-2 | 20px | 28px | 600 | 模块标题 |
| font-size-title-3 | 16px | 24px | 600 | 区块标题 |
| font-size-heading-1 | 16px | 24px | 500 | 段落标题 |
| font-size-heading-2 | 14px | 20px | 500 | 小标题 |
| font-size-heading-3 | 14px | 20px | 400 | 正文强调 |
| font-size-body-1 | 14px | 20px | 400 | 正文（默认） |
| font-size-body-2 | 13px | 20px | 400 | 辅助文字 |
| font-size-body-3 | 12px | 20px | 400 | 次要文字 |
| font-size-body-4 | 12px | 16px | 400 | 标签/徽章 |
| font-size-caption | 12px | 16px | 400 | 说明文字 |

### 组合字重

```
标题字重：600（Semi Bold）
强调字重：500（Medium）
正文字重：400（Regular）
辅助字重：400（Regular）
```

## 间距规范

### 间距梯度

| Token | 值 | 常用场景 |
|-------|----|---------|
| spacing-tight-1 | 4px | 图标与文字间距 |
| spacing-tight-2 | 8px | 组件内间距 |
| spacing-tight-3 | 12px | 组件内间距 |
| spacing-base | 16px | 组件间间距 |
| spacing-loose-1 | 20px | 区块内间距 |
| spacing-loose-2 | 24px | 区块间距 |
| spacing-loose-3 | 32px | 大区块间距 |
| spacing-loose-4 | 40px | 页面区块间距 |
| spacing-loose-5 | 48px | 页面大区块间距 |
| spacing-extreme-1 | 56px | 特大间距 |
| spacing-extreme-2 | 64px | 特大间距 |

### 圆角梯度

| Token | 值 | 使用场景 |
|-------|----|---------|
| --semi-border-radius-small | 3px | Button、Input、Select |
| --semi-border-radius-medium | 6px | Card、Modal |
| --semi-border-radius-large | 12px | Tag、Badge |
| --semi-border-radius-extra-large | 16px | 大尺寸容器 |
| --semi-border-radius-circle | 50% | Avatar、Icon Button |

### 阴影层级

```css
:root {
  --semi-shadow-elevated:  0 4px 12px rgba(0, 0, 0, 0.08);
  --semi-shadow-overlay:   0 8px 24px rgba(0, 0, 0, 0.12);
  --semi-shadow-modal:     0 12px 48px rgba(0, 0, 0, 0.16);
}
```

## 组件规格

### Button 按钮

```jsx
import { Button } from '@douyinfe/semi-ui';
import { IconSearch } from '@douyinfe/semi-icons';

// 变体
<Button theme="solid">主要按钮</Button>
<Button theme="light">次要按钮</Button>
<Button theme="borderless">文字按钮</Button>
<Button theme="outline">线框按钮</Button>

// 语义色
<Button theme="solid" type="primary">品牌色</Button>
<Button theme="solid" type="success">成功</Button>
<Button theme="solid" type="warning">警告</Button>
<Button theme="solid" type="danger">危险</Button>
<Button theme="solid" type="tertiary">三级</Button>

// 尺寸
<Button size="large">大号 40px</Button>
<Button size="default">默认 32px</Button>
<Button size="small">小号 24px</Button>

// 图标按钮
<Button icon={<IconSearch />}>搜索</Button>
<Button icon={<IconSearch />} iconPosition="right">搜索</Button>
<Button icon={<IconSearch />} aria-label="搜索" />

// 加载态
<Button loading>提交中</Button>

// 块级
<Button block>占满宽度</Button>

// 禁用
<Button disabled>禁用态</Button>
```

### Table 表格

```jsx
import { Table } from '@douyinfe/semi-ui';

const columns = [
  {
    title: '名称',
    dataIndex: 'name',
    sorter: (a, b) => a.name.localeCompare(b.name),
    filters: [
      { text: '活跃', value: 'active' },
      { text: '禁用', value: 'inactive' },
    ],
    onFilter: (value, record) => record.status === value,
  },
  {
    title: '状态',
    dataIndex: 'status',
    render: (text) => (
      <Tag color={text === 'active' ? 'green' : 'grey'}>{text}</Tag>
    ),
  },
  {
    title: '操作',
    render: (text, record) => (
      <ButtonGroup>
        <Button theme="borderless">编辑</Button>
        <Button theme="borderless" type="danger">删除</Button>
      </ButtonGroup>
    ),
  },
];

// 虚拟滚动（大数据量）
<Table
  columns={columns}
  dataSource={data}
  virtualized
  scroll={{ y: 400 }}
  pagination={false}
/>

// 可编辑单元格
<Table
  columns={columns}
  dataSource={data}
  editable={true}
  onRow={(record, index) => ({
    onDoubleClick: () => startEditing(record),
  })}
/>
```

| 特性 | API | 说明 |
|------|-----|------|
| 虚拟滚动 | virtualized | 大数据量性能优化 |
| 列固定 | fixed: 'left' / 'right' | 固定首列/末列 |
| 列排序 | sorter | 支持自定义排序函数 |
| 列筛选 | filters + onFilter | 内置筛选菜单 |
| 列拖拽排序 | draggable | 拖拽调整列顺序 |
| 树形数据 | expandRowByClick | 树形展开 |
| 行选择 | rowSelection | 复选框/单选 |
| 可编辑 | editable | 双击编辑单元格 |

### Form 表单

```jsx
import { Form, Input, Select, Button } from '@douyinfe/semi-ui';

const validateRules = {
  username: [
    { required: true, message: '请输入用户名' },
    { pattern: /^[a-zA-Z0-9_]{4,20}$/, message: '4-20位字母数字下划线' },
  ],
  email: [
    { required: true, message: '请输入邮箱' },
    { type: 'email', message: '邮箱格式不正确' },
  ],
  role: [
    { required: true, message: '请选择角色' },
  ],
};

() => (
  <Form
    labelPosition="left"
    labelWidth={100}
    validateFields={validateRules}
    onSubmit={(values) => handleSubmit(values)}
    style={{ maxWidth: 600 }}
  >
    <Form.Input field="username" label="用户名" />
    <Form.Input field="email" label="邮箱" />
    <Form.Select
      field="role"
      label="角色"
      optionList={[
        { value: 'admin', label: '管理员' },
        { value: 'user', label: '普通用户' },
        { value: 'viewer', label: '只读' },
      ]}
    />
    <Form.TextArea field="bio" label="简介" maxlength={200} showClear />
    <Button htmlType="submit" theme="solid" type="primary">
      提交
    </Button>
  </Form>
);
```

| API | 说明 |
|-----|------|
| labelPosition | top / left / right |
| labelWidth | 标签宽度（left/right 时生效） |
| validateFields | 声明式校验规则 |
| onSubmit(values) | 提交回调，校验通过后触发 |
| onValueChange(values) | 任意字段变化回调 |
| getFormApi() | 获取 Form API 实例 |
| Form.ArrayField | 动态增减表单项 |
| Form.API.validate() | 手动触发校验 |
| Form.API.reset() | 重置表单 |
| Form.API.scrollToField() | 滚动到指定字段 |

### Modal 弹窗

```jsx
import { Modal } from '@douyinfe/semi-ui';

// 基础用法
<Modal
  title="确认删除"
  visible={visible}
  onOk={() => handleDelete()}
  onCancel={() => setVisible(false)}
  okText="确认"
  cancelText="取消"
  okButtonProps={{ type: 'danger' }}
>
  <p>确定要删除该条记录吗？此操作不可撤销。</p>
</Modal>

// 尺寸
<Modal size="small" />   {/* 400px */}
<Modal size="medium" />  {/* 600px（默认） */}
<Modal size="large" />   {/* 800px */}

// 动画配置
<Modal
  motion={true}            {/* 开启动画 */}
  closeOnEsc={true}        {/* ESC 关闭 */}
  maskClosable={false}     {/* 点击遮罩不关闭 */}
  preventScroll={true}     {/* 防止背景滚动 */}
/>

// 确认弹窗（命令式）
Modal.confirm({
  title: '确认操作',
  content: '确认要执行此操作？',
  onOk: () => doAction(),
  onCancel: () => {},
});
```

### Toast / Notification

```jsx
import { Toast, Notification } from '@douyinfe/semi-ui';

// Toast - 轻量提示
Toast.success('操作成功');
Toast.error('操作失败');
Toast.warning('请注意');
Toast.info('提示信息');
Toast.closeAll();  // 关闭全部

// 自定义时长
Toast.success({ content: '已保存', duration: 3 });

// Notification - 复杂通知
Notification.info({
  title: '系统通知',
  content: '您有一条新的审批待处理',
  duration: 5,
  position: 'topRight',
  showClose: true,
});

// Promise 链式调用（特色）
Toast.success(Promise.resolve('异步成功'));
```

## 布局模式

### Admin 管理后台布局

```
+---------------------------------------------------+
| Nav (Navigation)           height: 60px            |
+--------+------------------------------------------+
| Side   |  Breadcrumb                              |
| Nav    |  +------------------------------------+  |
| 220px  |  | Content Area                       |  |
|        |  | padding: 24px                      |  |
| /60px  |  |                                    |  |
| fold   |  |  +-----------+ +-----------+       |  |
|        |  |  | Stat Card | | Stat Card |       |  |
|        |  |  +-----------+ +-----------+       |  |
|        |  |                                    |  |
|        |  |  +------------------------------+  |  |
|        |  |  | Table                         |  |  |
|        |  |  |                               |  |  |
|        |  |  +------------------------------+  |  |
|        |  +------------------------------------+  |
+--------+------------------------------------------+
```

```jsx
import { Layout, Nav } from '@douyinfe/semi-ui';
const { Header, Sider, Content } = Layout;

() => (
  <Layout style={{ minHeight: '100vh' }}>
    <Header style={{ height: 60 }}>
      <Nav
        header={{ logo: <Logo />, text: '管理平台' }}
        mode="horizontal"
      />
    </Header>
    <Layout>
      <Sider style={{ width: 220 }}>
        <Nav
          mode="vertical"
          items={[
            { itemKey: 'dashboard', text: '仪表盘', icon: <IconDashboard /> },
            { itemKey: 'users', text: '用户管理', icon: <IconUser /> },
            { itemKey: 'settings', text: '系统设置', icon: <IconSetting /> },
          ]}
        />
      </Sider>
      <Content style={{ padding: 24 }}>
        {/* 页面内容 */}
      </Content>
    </Layout>
  </Layout>
);
```

### 内容区布局模式

```
卡片网格（2 列）：
  +-------------------+-------------------+
  | Card              | Card              |
  | p-6               | p-6               |
  +-------------------+-------------------+

表单布局（居中）：
  +---------------------------------------+
  |         Form (max-width: 600px)       |
  |         margin: 0 auto               |
  +---------------------------------------+

列表 + 详情：
  +------------------+--------------------+
  | List (30%)       | Detail (70%)       |
  | overflow-y: auto | padding: 24px      |
  +------------------+--------------------+
```

## Design to Code（D2C）

### DSM 工作流

```
Semi Design System Manager (DSM) 完整工作流：

1. 设计阶段
   Figma 中使用 Semi Design Kit
     ↓
   Figma Plugin 导出 Token

2. Token 管理阶段
   DSM 主题编辑器中调整 Token
     - 可视化拖拽调色
     - 实时预览组件效果
     - 多主题并行管理
     ↓
   导出 Token JSON / CSS 变量

3. 开发阶段
   import { setTheme } from '@douyinfe/semi-ui'
   setTheme({ /* Token 配置 */ })
     ↓
   组件自动响应主题变化
```

### 主题编辑器使用

```
1. 访问 Semi DSM（https://semi.design/dsm）
2. 创建主题 → 选择基础主题（亮色/暗色）
3. 调整 Token：
   - 品牌色：拖拽色相/饱和度/明度
   - 语义色：自动基于品牌色推导
   - 圆角/间距：滑块调节
   - 字号：自定义梯度
4. 预览：实时查看所有组件效果
5. 导出：JSON / CSS / Less 变量文件
```

### Figma 插件集成

```
1. 安装 Semi Design Figma Plugin
2. 在 Figma 中选中组件
3. 插件自动读取 Design Token
4. 修改 Token → Figma 组件同步更新
5. 支持导出 Token 到代码项目
```

## 多品牌主题

### 多主题配置

```javascript
// themeConfig.js
export const themes = {
  brandA: {
    name: '品牌A（科技蓝）',
    vars: {
      '--semi-color-primary': '#1677FF',
      '--semi-color-primary-hover': '#4096FF',
      '--semi-color-primary-active': '#0958D9',
      '--semi-color-link': '#1677FF',
    },
  },
  brandB: {
    name: '品牌B（活力橙）',
    vars: {
      '--semi-color-primary': '#FF6A00',
      '--semi-color-primary-hover': '#FF8533',
      '--semi-color-primary-active': '#E05E00',
      '--semi-color-link': '#FF6A00',
    },
  },
};

// 切换品牌
import { setTheme } from '@douyinfe/semi-ui';
function switchBrand(brandKey) {
  const theme = themes[brandKey];
  document.body.setAttribute('theme-mode', 'light');
  setTheme(theme.vars);
  localStorage.setItem('currentBrand', brandKey);
}
```

## 设计示例

### 按钮组合示例

```jsx
import { Button, ButtonGroup } from '@douyinfe/semi-ui';
import { IconPlus, IconDownload, IconRefresh } from '@douyinfe/semi-icons';

() => (
  <div style={{ display: 'flex', gap: 12, alignItems: 'center' }}>
    <Button theme="solid" type="primary" icon={<IconPlus />}>
      新建项目
    </Button>
    <Button theme="outline" icon={<IconDownload />}>
      导出
    </Button>
    <Button theme="borderless" icon={<IconRefresh />}>
      刷新
    </Button>

    <ButtonGroup>
      <Button>日</Button>
      <Button>周</Button>
      <Button>月</Button>
    </ButtonGroup>

    <Button theme="solid" type="danger" size="small">
      批量删除
    </Button>
  </div>
);
```

### 表单校验示例

```jsx
import { Form, Input, DatePicker, Select, Button, RadioGroup, Radio } from '@douyinfe/semi-ui';

() => (
  <Form
    labelPosition="top"
    style={{ maxWidth: 480, margin: '0 auto', padding: 24 }}
    onSubmit={async (values) => {
      await api.createUser(values);
      Toast.success('创建成功');
    }}
  >
    <Form.Input
      field="name"
      label="姓名"
      rules={[{ required: true, message: '必填' }]}
    />
    <Form.Input
      field="phone"
      label="手机号"
      rules={[
        { required: true, message: '必填' },
        { pattern: /^1[3-9]\d{9}$/, message: '手机号格式错误' },
      ]}
    />
    <Form.RadioGroup field="gender" label="性别" type="button">
      <Radio value="male">男</Radio>
      <Radio value="female">女</Radio>
    </Form.RadioGroup>
    <Form.Select
      field="department"
      label="部门"
      rules={[{ required: true, message: '请选择' }]}
      optionList={departments}
    />
    <Form.DatePicker
      field="joinDate"
      label="入职日期"
      type="date"
    />
    <Button htmlType="submit" theme="solid" block>
      提交
    </Button>
  </Form>
);
```

### 虚拟滚动表格示例

```jsx
import { Table, Button, Tag, Space } from '@douyinfe/semi-ui';

() => {
  const columns = [
    {
      title: 'ID',
      dataIndex: 'id',
      width: 80,
      fixed: true,
    },
    {
      title: '名称',
      dataIndex: 'name',
      sorter: (a, b) => a.name.localeCompare(b.name),
    },
    {
      title: '状态',
      dataIndex: 'status',
      render: (status) => (
        <Tag color={status === 'active' ? 'green' : 'grey'}>
          {status === 'active' ? '活跃' : '禁用'}
        </Tag>
      ),
      filters: [
        { text: '活跃', value: 'active' },
        { text: '禁用', value: 'inactive' },
      ],
      onFilter: (value, record) => record.status === value,
    },
    {
      title: '操作',
      width: 160,
      fixed: 'right',
      render: (_, record) => (
        <Space>
          <Button theme="borderless" size="small">编辑</Button>
          <Button theme="borderless" type="danger" size="small">删除</Button>
        </Space>
      ),
    },
  ];

  return (
    <Table
      columns={columns}
      dataSource={bigData}         {/* 10000+ 条数据 */}
      virtualized                   {/* 开启虚拟滚动 */}
      scroll={{ y: 500 }}
      pagination={false}
      rowKey="id"
      bordered
      header={{
        headerRender: () => (
          <div style={{ display: 'flex', justifyContent: 'space-between', padding: 12 }}>
            <span style={{ fontWeight: 600 }}>用户列表（共 {bigData.length} 条）</span>
            <Button theme="solid" size="small">新建</Button>
          </div>
        ),
      }}
    />
  );
};
```

## 适用场景

| 场景 | 推荐度 | 说明 |
|------|--------|------|
| 需要暗色模式的 SaaS | 5/5 | Token 体系最完善，一键切换 |
| 多品牌/多主题产品 | 5/5 | DSM 主题管理，D2C 全链路 |
| 抖音/头条系项目 | 5/5 | 内部标准组件库 |
| React 中后台 | 4/5 | 组件质量高，交互完善 |
| 大数据量表格 | 4/5 | 虚拟滚动原生支持 |
| Vue 项目 | 1/5 | 仅支持 React |
| 需要极简/轻量 | 3/5 | 功能全面但体积偏大 |
