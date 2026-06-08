---
type: design-system
name: shadcn/ui
status: verified
source: 官方文档整理
last-updated: 2026-05-19
homepage: https://ui.shadcn.com
tech-stack: React + Tailwind CSS
---

# shadcn/ui 设计系统速查

> 非 npm 包，代码复制式组件库，Tailwind 原生，极简可定制

## 设计理念

### Copy-Paste 方式 vs npm 包

```
核心差异：
  shadcn/ui 不是 npm 包，不能 npm install shadcn-ui
  而是 CLI 工具复制组件代码到项目中（npx shadcn-ui add button）
  代码完全属于你，可以随意修改
  基于 Radix UI 原语 + Tailwind CSS 样式

设计哲学原文：
  "This is NOT a component library. It's a collection of re-usable
   components that you can copy and paste into your apps."

什么时候用 shadcn/ui：
  - React + Tailwind 技术栈
  - 需要完全控制组件代码
  - 追求极简、可定制的视觉风格
  - 创业项目 / SaaS / 个人产品
  - 不想被组件库升级绑架

什么时候不用 shadcn/ui：
  - Vue / Angular 等非 React 项目
  - 需要开箱即用的复杂组件（如企业级表格）
  - 团队不熟悉 Tailwind CSS
  - 需要大量高级组件（甘特图、看板等）
  - 项目时间紧迫，无暇定制
```

### 与 Radix UI 的关系

```
架构分层：

  Radix UI（底层）
    - 提供 Headless 组件原语
    - 处理无障碍（a11y）、键盘导航、焦点管理
    - 不带任何样式

  shadcn/ui（上层）
    - 基于 Radix UI 原语
    - 用 Tailwind CSS 添加样式
    - 定义设计规范（颜色/圆角/间距）
    - 复制到项目中后可完全自定义

  你的项目
    - 拥有完整源码
    - 可修改任何细节
    - 不受组件库版本升级影响
```

## 色彩 Token（HSL 变量体系）

### 亮色主题完整定义

```css
:root {
  /* 背景/前景 */
  --background: 0 0% 100%;
  --foreground: 222.2 84% 4.9%;

  /* 卡片 */
  --card: 0 0% 100%;
  --card-foreground: 222.2 84% 4.9%;

  /* 弹出层 */
  --popover: 0 0% 100%;
  --popover-foreground: 222.2 84% 4.9%;

  /* 主色 */
  --primary: 222.2 47.4% 11.2%;
  --primary-foreground: 210 40% 98%;

  /* 次要色 */
  --secondary: 210 40% 96.1%;
  --secondary-foreground: 222.2 47.4% 11.2%;

  /* 静音色 */
  --muted: 210 40% 96.1%;
  --muted-foreground: 215.4 16.3% 46.9%;

  /* 强调色 */
  --accent: 210 40% 96.1%;
  --accent-foreground: 222.2 47.4% 11.2%;

  /* 危险色 */
  --destructive: 0 84.2% 60.2%;
  --destructive-foreground: 210 40% 98%;

  /* 边框/输入框/焦点环 */
  --border: 214.3 31.8% 91.4%;
  --input: 214.3 31.8% 91.4%;
  --ring: 222.2 84% 4.9%;

  /* 圆角 */
  --radius: 0.5rem;

  /* 图表色（扩展） */
  --chart-1: 12 76% 61%;
  --chart-2: 173 58% 39%;
  --chart-3: 197 37% 24%;
  --chart-4: 43 74% 66%;
  --chart-5: 27 87% 67%;
}
```

### 暗色主题完整定义

```css
.dark {
  --background: 222.2 84% 4.9%;
  --foreground: 210 40% 98%;

  --card: 222.2 84% 4.9%;
  --card-foreground: 210 40% 98%;

  --popover: 222.2 84% 4.9%;
  --popover-foreground: 210 40% 98%;

  --primary: 210 40% 98%;
  --primary-foreground: 222.2 47.4% 11.2%;

  --secondary: 217.2 32.6% 17.5%;
  --secondary-foreground: 210 40% 98%;

  --muted: 217.2 32.6% 17.5%;
  --muted-foreground: 215 20.2% 65.1%;

  --accent: 217.2 32.6% 17.5%;
  --accent-foreground: 210 40% 98%;

  --destructive: 0 62.8% 30.6%;
  --destructive-foreground: 210 40% 98%;

  --border: 217.2 32.6% 17.5%;
  --input: 217.2 32.6% 17.5%;
  --ring: 212.7 26.8% 83.9%;

  --chart-1: 220 70% 50%;
  --chart-2: 160 60% 45%;
  --chart-3: 30 80% 55%;
  --chart-4: 280 65% 60%;
  --chart-5: 340 75% 55%;
}
```

### 色彩使用说明

```
HSL 变量格式：H S% L%（无逗号，无 hsl() 包裹）
使用方式：hsl(var(--primary))

语义对照：
  background / foreground  -- 页面/全局背景与文字
  card / card-foreground   -- 卡片容器背景与文字
  popover / popover-foreground -- 弹出层背景与文字
  primary / primary-foreground -- 主色按钮/链接
  secondary / secondary-foreground -- 次要操作
  muted / muted-foreground -- 静音/辅助区域
  accent / accent-foreground -- 强调/选中态
  destructive / destructive-foreground -- 危险操作（删除等）
  border -- 边框颜色
  input -- 输入框边框
  ring -- 焦点环颜色
```

### 自定义品牌色

```css
/* 步骤 1：选择品牌色的 HSL 值 */
/* 示例：蓝色品牌 #1677FF → HSL(215, 100%, 55%) */

/* 步骤 2：替换 :root 中的相关变量 */
:root {
  --primary: 215 100% 55%;        /* 品牌蓝 */
  --primary-foreground: 0 0% 100%; /* 白色文字 */
  --ring: 215 100% 55%;            /* 焦点环跟随品牌色 */
  --accent: 215 100% 95%;          /* 浅蓝强调背景 */
  --accent-foreground: 215 100% 30%;
}

/* 步骤 3：同步暗色主题 */
.dark {
  --primary: 215 100% 60%;
  --primary-foreground: 215 100% 10%;
  --ring: 215 100% 60%;
  --accent: 215 40% 15%;
  --accent-foreground: 215 100% 80%;
}

/* 步骤 4：调整圆角（可选） */
:root {
  --radius: 0.75rem;   /* 更圆润 */
}
```

## 排版规范

### Tailwind 字号类映射

| 类名 | 字号 | 行高 | 使用场景 |
|------|------|------|---------|
| text-xs | 12px | 16px | 标签、徽章、脚注 |
| text-sm | 14px | 20px | 辅助文字、表格内容 |
| text-base | 16px | 24px | 正文（默认） |
| text-lg | 18px | 28px | 小标题 |
| text-xl | 20px | 28px | 区块标题 |
| text-2xl | 24px | 32px | 模块标题 |
| text-3xl | 30px | 36px | 页面标题 |
| text-4xl | 36px | 40px | 大标题 |

### 文字层级

```
页面标题：   text-3xl font-bold tracking-tight
模块标题：   text-2xl font-semibold tracking-tight
区块标题：   text-xl font-semibold
卡片标题：   text-lg font-medium
正文：       text-base
辅助文字：   text-sm text-muted-foreground
标签/脚注：  text-xs text-muted-foreground
```

### 字体族定制

```css
/* tailwind.config.ts 中自定义 */
fontFamily: {
  sans: ['Inter', 'system-ui', '-apple-system', 'sans-serif'],
  mono: ['JetBrains Mono', 'Menlo', 'monospace'],
}

/* globals.css 中定义 */
@layer base {
  * {
    @apply border-border;
  }
  body {
    @apply bg-background text-foreground;
    font-feature-settings: "rlig" 1, "calt" 1;
  }
}
```

## 间距规范

### Tailwind 间距梯度

| 类名 | 值 | 常用场景 |
|------|----|---------|
| p-0.5 / m-0.5 | 2px | 微调 |
| p-1 / m-1 | 4px | 图标与文字间距 |
| p-1.5 / m-1.5 | 6px | 紧凑内边距 |
| p-2 / m-2 | 8px | 组件内间距 |
| p-3 / m-3 | 12px | 组件内间距（默认） |
| p-4 / m-4 | 16px | 组件间间距 |
| p-5 / m-5 | 20px | 区块内间距 |
| p-6 / m-6 | 24px | 卡片内边距 |
| p-8 / m-8 | 32px | 区块间距 |
| p-10 / m-10 | 40px | 大区块间距 |
| p-12 / m-12 | 48px | 页面区块间距 |
| p-16 / m-16 | 64px | 特大间距 |
| p-24 / m-24 | 96px | 页面级间距 |

### 常用布局间距模式

```
页面容器：    px-4 md:px-6 lg:px-8 py-6
卡片内容：    p-6
卡片标题区：  px-6 py-4
表格行：      px-4 py-3
表单组间距：  space-y-4
按钮组间距：  gap-2（8px）
标签页间距：  gap-1（4px）
```

### 响应式间距

```
/* 移动端紧凑，桌面端宽松 */
<div className="p-4 md:p-6 lg:p-8">
<div className="space-y-4 md:space-y-6 lg:space-y-8">
<div className="gap-4 md:gap-6">
```

## 组件规格

### Button 按钮

```tsx
import { Button } from "@/components/ui/button";

// 变体
<Button variant="default">默认按钮</Button>
<Button variant="destructive">危险操作</Button>
<Button variant="outline">线框按钮</Button>
<Button variant="secondary">次要按钮</Button>
<Button variant="ghost">幽灵按钮</Button>
<Button variant="link">链接按钮</Button>

// 尺寸
<Button size="default">默认 36px</Button>
<Button size="sm">小号 32px</Button>
<Button size="lg">大号 44px</Button>
<Button size="icon">图标按钮 40px</Button>

// 组合
<Button variant="outline" size="sm">
  <Plus className="mr-2 h-4 w-4" />
  新建
</Button>

<Button variant="ghost" size="icon">
  <Settings className="h-4 w-4" />
</Button>

// 加载态
<Button disabled>
  <Loader2 className="mr-2 h-4 w-4 animate-spin" />
  提交中
</Button>
```

| 变体 | 样式特征 |
|------|---------|
| default | 实心填充，primary 背景 |
| destructive | 实心填充，destructive 背景 |
| outline | 线框，hover 填充背景 |
| secondary | 实心填充，secondary 背景 |
| ghost | 透明，hover 填充背景 |
| link | 无背景无边框，下划线 hover |

### Input 输入框

```tsx
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";

// 基础
<Input type="text" placeholder="请输入" />

// 带标签
<div className="space-y-2">
  <Label htmlFor="email">邮箱</Label>
  <Input id="email" type="email" placeholder="name@example.com" />
</div>

// 带图标
<div className="relative">
  <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
  <Input className="pl-9" placeholder="搜索..." />
</div>

// 带错误
<div className="space-y-2">
  <Label htmlFor="password">密码</Label>
  <Input id="password" type="password" />
  <p className="text-sm text-destructive">密码不能少于 8 位</p>
</div>

// 禁用
<Input disabled placeholder="禁用状态" />
```

### Card 卡片

```tsx
import {
  Card,
  CardHeader,
  CardTitle,
  CardDescription,
  CardContent,
  CardFooter,
} from "@/components/ui/card";

<Card>
  <CardHeader>
    <CardTitle>卡片标题</CardTitle>
    <CardDescription>卡片描述文字</CardDescription>
  </CardHeader>
  <CardContent>
    <p>卡片正文内容</p>
  </CardContent>
  <CardFooter className="justify-end gap-2">
    <Button variant="outline">取消</Button>
    <Button>确认</Button>
  </CardFooter>
</Card>
```

### Dialog 对话框

```tsx
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";

<Dialog>
  <DialogTrigger asChild>
    <Button variant="outline">编辑资料</Button>
  </DialogTrigger>
  <DialogContent className="sm:max-w-[425px]">
    <DialogHeader>
      <DialogTitle>编辑资料</DialogTitle>
      <DialogDescription>修改后点击保存。</DialogDescription>
    </DialogHeader>
    <div className="grid gap-4 py-4">
      <div className="grid grid-cols-4 items-center gap-4">
        <Label htmlFor="name" className="text-right">姓名</Label>
        <Input id="name" defaultValue="张三" className="col-span-3" />
      </div>
      <div className="grid grid-cols-4 items-center gap-4">
        <Label htmlFor="role" className="text-right">角色</Label>
        <Select>
          <SelectTrigger className="col-span-3">
            <SelectValue placeholder="选择角色" />
          </SelectTrigger>
        </Select>
      </div>
    </div>
    <DialogFooter>
      <Button type="submit">保存</Button>
    </DialogFooter>
  </DialogContent>
</Dialog>
```

### Table 表格

```tsx
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";

<Table>
  <TableHeader>
    <TableRow>
      <TableHead className="w-[100px]">ID</TableHead>
      <TableHead>名称</TableHead>
      <TableHead>状态</TableHead>
      <TableHead className="text-right">操作</TableHead>
    </TableRow>
  </TableHeader>
  <TableBody>
    {data.map((item) => (
      <TableRow key={item.id}>
        <TableCell className="font-medium">{item.id}</TableCell>
        <TableCell>{item.name}</TableCell>
        <TableCell>
          <Badge variant={item.active ? "default" : "secondary"}>
            {item.active ? "活跃" : "禁用"}
          </Badge>
        </TableCell>
        <TableCell className="text-right">
          <Button variant="ghost" size="sm">编辑</Button>
          <Button variant="ghost" size="sm" className="text-destructive">
            删除
          </Button>
        </TableCell>
      </TableRow>
    ))}
  </TableBody>
</Table>
```

### Command 快捷命令面板

```tsx
import {
  Command,
  CommandDialog,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
  CommandSeparator,
} from "@/components/ui/command";

// Cmd+K 搜索面板
() => {
  const [open, setOpen] = useState(false);

  useEffect(() => {
    const down = (e: KeyboardEvent) => {
      if (e.key === "k" && (e.metaKey || e.ctrlKey)) {
        e.preventDefault();
        setOpen((open) => !open);
      }
    };
    document.addEventListener("keydown", down);
    return () => document.removeEventListener("keydown", down);
  }, []);

  return (
    <CommandDialog open={open} onOpenChange={setOpen}>
      <CommandInput placeholder="搜索功能、页面..." />
      <CommandList>
        <CommandEmpty>未找到结果</CommandEmpty>
        <CommandGroup heading="建议">
          <CommandItem>仪表盘</CommandItem>
          <CommandItem>用户管理</CommandItem>
          <CommandItem>系统设置</CommandItem>
        </CommandGroup>
        <CommandSeparator />
        <CommandGroup heading="操作">
          <CommandItem>新建项目</CommandItem>
          <CommandItem>导出数据</CommandItem>
        </CommandGroup>
      </CommandList>
    </CommandDialogDialog>
  );
};
```

### Sheet 抽屉面板

```tsx
import {
  Sheet,
  SheetContent,
  SheetDescription,
  SheetHeader,
  SheetTitle,
  SheetTrigger,
} from "@/components/ui/sheet";

<Sheet>
  <SheetTrigger asChild>
    <Button variant="outline">打开面板</Button>
  </SheetTrigger>
  <SheetContent>
    <SheetHeader>
      <SheetTitle>设置</SheetTitle>
      <SheetDescription>管理偏好设置。</SheetDescription>
    </SheetHeader>
    <div className="grid gap-4 py-4">
      {/* 设置内容 */}
    </div>
  </SheetContent>
</Sheet>

// 四个方向
<SheetContent side="top" />    {/* 从顶部滑出 */}
<SheetContent side="bottom" /> {/* 从底部滑出 */}
<SheetContent side="left" />   {/* 从左侧滑出 */}
<SheetContent side="right" />  {/* 从右侧滑出（默认） */}
```

## 安装与使用

### CLI 命令

```bash
# 初始化 shadcn/ui（首次使用）
npx shadcn-ui@latest init

# 添加单个组件
npx shadcn-ui@latest add button

# 添加多个组件
npx shadcn-ui@latest add button input card dialog table badge

# 添加所有组件
npx shadcn-ui@latest add all

# 覆盖已安装的组件（重新安装）
npx shadcn-ui@latest add button --overwrite

# 使用 YAML 配置
npx shadcn-ui@latest add --config ./shadcn.config.yaml
```

### 组件文件结构

```
project/
  components/
    ui/
      button.tsx       ← CLI 自动复制到此
      input.tsx
      card.tsx
      dialog.tsx
      table.tsx
      badge.tsx
      ...
  lib/
    utils.ts           ← cn() 工具函数（clsx + tailwind-merge）
```

### 手动定制方式

```
1. CLI 添加组件到 components/ui/
2. 打开组件文件，查看源码
3. 直接修改 Tailwind 类名
4. 修改 CSS 变量调整全局样式
5. 不受组件库升级影响，完全自主

关键工具函数：
  cn(...inputs)    -- 合并 Tailwind 类名（基于 clsx + tailwind-merge）
  用法：className={cn("px-4 py-2", isActive && "bg-primary")}
```

## 布局模式

### Dashboard 仪表盘布局

```tsx
<div className="min-h-screen bg-background">
  {/* 顶部导航 */}
  <header className="sticky top-0 z-50 w-full border-b bg-background/95 backdrop-blur">
    <div className="container flex h-14 items-center px-4 md:px-6">
      <nav className="flex items-center space-x-4 lg:space-x-6">
        <a className="text-sm font-medium">仪表盘</a>
        <a className="text-sm text-muted-foreground hover:text-foreground">分析</a>
        <a className="text-sm text-muted-foreground hover:text-foreground">设置</a>
      </nav>
    </div>
  </header>

  {/* 主内容区 */}
  <main className="container px-4 py-6 md:px-6">
    {/* 统计卡片行 */}
    <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
      <Card>...</Card>
      <Card>...</Card>
      <Card>...</Card>
      <Card>...</Card>
    </div>

    {/* 内容区域 */}
    <div className="grid gap-4 md:grid-cols-7 mt-6">
      {/* 图表区 */}
      <Card className="col-span-4">...</Card>
      {/* 最近活动 */}
      <Card className="col-span-3">...</Card>
    </div>
  </main>
</div>
```

```
ASCII 布局示意：

+---------------------------------------------------+
| Header  h-14 sticky border-b                      |
+---------------------------------------------------+
| px-4 py-6                                         |
|                                                   |
| [Card-1]  [Card-2]  [Card-3]  [Card-4]           |
|  md:grid-cols-2  lg:grid-cols-4                   |
|                                                   |
| [Chart Card     ]  [Recent Activity]              |
|  col-span-4        col-span-3                     |
|  md:grid-cols-7                                   |
+---------------------------------------------------+
```

### Settings 设置页布局

```tsx
<div className="space-y-6">
  <div>
    <h3 className="text-lg font-medium">个人信息</h3>
    <p className="text-sm text-muted-foreground">管理你的个人信息。</p>
  </div>
  <Separator />
  <Form {...form}>
    <form className="space-y-8">
      <FormField
        name="name"
        render={({ field }) => (
          <FormItem>
            <FormLabel>姓名</FormLabel>
            <FormControl><Input {...field} /></FormControl>
            <FormDescription>公开显示的名称。</FormDescription>
            <FormMessage />
          </FormItem>
        )}
      />
      <Button type="submit">保存</Button>
    </form>
  </Form>
</div>
```

### Auth 认证页布局（居中卡片）

```tsx
<div className="min-h-screen flex items-center justify-center bg-background px-4">
  <Card className="w-full max-w-md">
    <CardHeader className="space-y-1 text-center">
      <CardTitle className="text-2xl">登录</CardTitle>
      <CardDescription>输入邮箱和密码登录</CardDescription>
    </CardHeader>
    <CardContent>
      <div className="grid gap-4">
        <div className="grid gap-2">
          <Label htmlFor="email">邮箱</Label>
          <Input id="email" type="email" placeholder="name@example.com" />
        </div>
        <div className="grid gap-2">
          <Label htmlFor="password">密码</Label>
          <Input id="password" type="password" />
        </div>
        <Button className="w-full">登录</Button>
      </div>
    </CardContent>
    <CardFooter className="justify-center">
      <p className="text-sm text-muted-foreground">
        还没有账号？<a className="text-primary hover:underline">注册</a>
      </p>
    </CardFooter>
  </Card>
</div>
```

## 设计示例

### 登录表单

```tsx
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Button } from "@/components/ui/button";
import { Checkbox } from "@/components/ui/checkbox";

<Card className="mx-auto max-w-sm">
  <CardHeader className="space-y-1">
    <CardTitle className="text-2xl font-bold">登录</CardTitle>
    <CardDescription>输入以下信息登录你的账号</CardDescription>
  </CardHeader>
  <CardContent>
    <div className="grid gap-4">
      <div className="grid gap-2">
        <Label htmlFor="email">邮箱</Label>
        <Input id="email" type="email" placeholder="name@example.com" required />
      </div>
      <div className="grid gap-2">
        <Label htmlFor="password">密码</Label>
        <Input id="password" type="password" required />
      </div>
      <div className="flex items-center space-x-2">
        <Checkbox id="remember" />
        <label htmlFor="remember" className="text-sm text-muted-foreground">
          记住我
        </label>
      </div>
      <Button type="submit" className="w-full">登录</Button>
      <Button variant="outline" className="w-full">
        <!-- GitHub 图标 --> 使用 GitHub 登录
      </Button>
    </div>
    <div className="mt-4 text-center text-sm">
      还没有账号？
      <a className="underline text-primary">注册</a>
    </div>
  </CardContent>
</Card>
```

### Dashboard 统计卡片

```tsx
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { ArrowUpRight, ArrowDownRight } from "lucide-react";

const stats = [
  { title: "总收入", value: "¥45,231.89", change: "+20.1%", up: true },
  { title: "订阅数", value: "+2,350", change: "+180.1%", up: true },
  { title: "活跃用户", value: "12,234", change: "+19%", up: true },
  { title: "转化率", value: "3.24%", change: "-4.5%", up: false },
];

<div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
  {stats.map((stat) => (
    <Card key={stat.title}>
      <CardHeader className="flex flex-row items-center justify-between pb-2">
        <CardTitle className="text-sm font-medium text-muted-foreground">
          {stat.title}
        </CardTitle>
        {stat.up ? (
          <ArrowUpRight className="h-4 w-4 text-emerald-500" />
        ) : (
          <ArrowDownRight className="h-4 w-4 text-red-500" />
        )}
      </CardHeader>
      <CardContent>
        <div className="text-2xl font-bold">{stat.value}</div>
        <p className={`text-xs ${stat.up ? 'text-emerald-500' : 'text-red-500'}`}>
          {stat.change} 较上月
        </p>
      </CardContent>
    </Card>
  ))}
</div>
```

### 带筛选的数据表格

```tsx
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";

<div className="space-y-4">
  {/* 筛选栏 */}
  <div className="flex items-center gap-4">
    <Input placeholder="搜索..." className="max-w-sm" />
    <Select>
      <SelectTrigger className="w-[180px]">
        <SelectValue placeholder="状态筛选" />
      </SelectTrigger>
      <SelectContent>
        <SelectItem value="all">全部</SelectItem>
        <SelectItem value="active">活跃</SelectItem>
        <SelectItem value="inactive">禁用</SelectItem>
      </SelectContent>
    </Select>
    <Button variant="outline">重置</Button>
    <div className="flex-1" />
    <Button>
      <Plus className="mr-2 h-4 w-4" /> 新建
    </Button>
  </div>

  {/* 数据表格 */}
  <div className="rounded-md border">
    <Table>
      <TableHeader>
        <TableRow>
          <TableHead className="w-[80px]">ID</TableHead>
          <TableHead>名称</TableHead>
          <TableHead>邮箱</TableHead>
          <TableHead>状态</TableHead>
          <TableHead className="text-right">操作</TableHead>
        </TableRow>
      </TableHeader>
      <TableBody>
        {users.map((user) => (
          <TableRow key={user.id}>
            <TableCell className="font-medium">{user.id}</TableCell>
            <TableCell>{user.name}</TableCell>
            <TableCell className="text-muted-foreground">{user.email}</TableCell>
            <TableCell>
              <Badge variant={user.active ? "default" : "secondary"}>
                {user.active ? "活跃" : "禁用"}
              </Badge>
            </TableCell>
            <TableCell className="text-right">
              <Button variant="ghost" size="sm">编辑</Button>
              <Button variant="ghost" size="sm" className="text-destructive">删除</Button>
            </TableCell>
          </TableRow>
        ))}
      </TableBody>
    </Table>
  </div>
</div>
```

### 设置表单布局

```tsx
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Button } from "@/components/ui/button";
import { Switch } from "@/components/ui/switch";
import { Separator } from "@/components/ui/separator";

<div className="max-w-2xl space-y-6">
  <Card>
    <CardHeader>
      <CardTitle>个人资料</CardTitle>
      <CardDescription>管理你的个人信息和偏好。</CardDescription>
    </CardHeader>
    <CardContent className="space-y-6">
      <div className="grid gap-4 md:grid-cols-2">
        <div className="space-y-2">
          <Label htmlFor="firstName">姓</Label>
          <Input id="firstName" defaultValue="张" />
        </div>
        <div className="space-y-2">
          <Label htmlFor="lastName">名</Label>
          <Input id="lastName" defaultValue="三" />
        </div>
      </div>
      <div className="space-y-2">
        <Label htmlFor="email">邮箱</Label>
        <Input id="email" type="email" defaultValue="zhang@example.com" />
      </div>
      <div className="space-y-2">
        <Label htmlFor="bio">简介</Label>
        <textarea
          id="bio"
          className="flex min-h-[100px] w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
          defaultValue="资深产品经理"
        />
      </div>
      <Separator />
      <div className="flex items-center justify-between">
        <div className="space-y-0.5">
          <Label>邮件通知</Label>
          <p className="text-sm text-muted-foreground">接收项目更新通知。</p>
        </div>
        <Switch defaultChecked />
      </div>
      <div className="flex justify-end gap-2">
        <Button variant="outline">取消</Button>
        <Button>保存</Button>
      </div>
    </CardContent>
  </Card>
</div>
```

## Tailwind 配置

### tailwind.config.ts 关键设置

```typescript
import type { Config } from "tailwindcss";

const config: Config = {
  darkMode: ["class"],       // 暗色模式通过 class 切换
  content: [
    "./pages/**/*.{ts,tsx}",
    "./components/**/*.{ts,tsx}",
    "./app/**/*.{ts,tsx}",
  ],
  theme: {
    container: {
      center: true,
      padding: "2rem",
      screens: {
        "2xl": "1400px",
      },
    },
    extend: {
      colors: {
        border: "hsl(var(--border))",
        input: "hsl(var(--input))",
        ring: "hsl(var(--ring))",
        background: "hsl(var(--background))",
        foreground: "hsl(var(--foreground))",
        primary: {
          DEFAULT: "hsl(var(--primary))",
          foreground: "hsl(var(--primary-foreground))",
        },
        secondary: {
          DEFAULT: "hsl(var(--secondary))",
          foreground: "hsl(var(--secondary-foreground))",
        },
        destructive: {
          DEFAULT: "hsl(var(--destructive))",
          foreground: "hsl(var(--destructive-foreground))",
        },
        muted: {
          DEFAULT: "hsl(var(--muted))",
          foreground: "hsl(var(--muted-foreground))",
        },
        accent: {
          DEFAULT: "hsl(var(--accent))",
          foreground: "hsl(var(--accent-foreground))",
        },
        popover: {
          DEFAULT: "hsl(var(--popover))",
          foreground: "hsl(var(--popover-foreground))",
        },
        card: {
          DEFAULT: "hsl(var(--card))",
          foreground: "hsl(var(--card-foreground))",
        },
      },
      borderRadius: {
        lg: "var(--radius)",
        md: "calc(var(--radius) - 2px)",
        sm: "calc(var(--radius) - 4px)",
      },
      keyframes: {
        "accordion-down": {
          from: { height: "0" },
          to: { height: "var(--radix-accordion-content-height)" },
        },
        "accordion-up": {
          from: { height: "var(--radix-accordion-content-height)" },
          to: { height: "0" },
        },
      },
      animation: {
        "accordion-down": "accordion-down 0.2s ease-out",
        "accordion-up": "accordion-up 0.2s ease-out",
      },
    },
  },
  plugins: [require("tailwindcss-animate")],
};
```

### 自定义主题扩展

```typescript
// 在 extend 中添加自定义配置
extend: {
  fontFamily: {
    sans: ['Inter', 'system-ui', 'sans-serif'],
    mono: ['JetBrains Mono', 'monospace'],
  },
  fontSize: {
    '2xs': ['0.625rem', { lineHeight: '0.875rem' }],  // 10px
  },
  spacing: {
    '4.5': '1.125rem',  // 18px
    '18': '4.5rem',     // 72px
  },
  colors: {
    // 添加自定义颜色（非语义色）
    brand: {
      50: '#eff6ff',
      100: '#dbeafe',
      // ...
      600: '#2563eb',
      700: '#1d4ed8',
    },
  },
}
```

### 暗色模式设置

```typescript
// 方式 1：class 切换（推荐）
darkMode: ["class"],
// 在 html 标签添加 class="dark" 即可
// <html class="dark">

// 方式 2：代码切换
function toggleDark() {
  document.documentElement.classList.toggle("dark");
}

// 方式 3：跟随系统
function initTheme() {
  if (window.matchMedia("(prefers-color-scheme: dark)").matches) {
    document.documentElement.classList.add("dark");
  }
}

// 方式 4：使用 next-themes（Next.js 推荐）
import { ThemeProvider } from "next-themes";
<ThemeProvider attribute="class" defaultTheme="system">
  {children}
</ThemeProvider>
```

## 可用组件清单

### 基础
Button / Input / Label / Textarea / Select / Checkbox / Radio / Switch / Slider

### 数据展示
Table / Card / Badge / Avatar / Separator / Skeleton / Progress / Carousel / Tabs / Chart

### 反馈
Dialog / Alert / Toast(Sonner) / Tooltip / Popover / HoverCard / AlertDialog / Drawer

### 导航
NavigationMenu / Menubar / Breadcrumb / Pagination / Command(Cmd+K) / Sidebar

### 表单高级
Combobox / DatePicker / Form(react-hook-form) / InputOTP / ToggleGroup / Calendar

### 布局
Sheet(抽屉) / Accordion / Collapsible / ScrollArea / AspectRatio / Resizable / Stepper

## 适用场景

| 场景 | 推荐度 | 说明 |
|------|--------|------|
| React + Tailwind 项目 | 5/5 | 天然适配，无缝集成 |
| 追求极简定制 | 5/5 | 代码完全可控 |
| SaaS / 创业项目 | 5/5 | 灵活快速，社区活跃 |
| 设计感强的产品 | 4/5 | 默认简洁，容易提升 |
| Next.js 项目 | 5/5 | 官方推荐框架 |
| Vue 项目 | 1/5 | 仅支持 React |
| 需要开箱即用 | 3/5 | 需要手动组合 |
| 企业级复杂后台 | 3/5 | 复杂组件需自建 |
| 快速原型 | 3/5 | 需要配置 Tailwind 环境 |
