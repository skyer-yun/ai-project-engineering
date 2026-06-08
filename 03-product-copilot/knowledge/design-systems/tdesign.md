---
type: design-system
name: TDesign
status: verified
source: TDesign GitHub官方Less变量
last-updated: 2026-04-30
local-path: C:/Users/Admin/tdesign设计系统/
description: 腾讯开源企业级设计体系，支持Web端与移动端，PBEM命名规范
framework: React / Vue 2 / Vue 3 / React Native / 微信小程序
prefix: "--td-"
naming: PBEM (.t-{block}--{modifier}__{element})
---

# TDesign Design System

> 腾讯系项目首选设计系统。基于 TDesign GitHub 官方仓库 `tdesign-common` 原始 Less 变量提取。
> 设计价值观：克制、连接、开放。品牌色10级色阶 + 语义色状态扩展 + 14级灰度 + PBEM 命名规范。

---

## 1. Design Philosophy

TDesign 秉承三大设计价值观：

| Value | Description |
|-------|-------------|
| Restraint | 理性设计，减少视觉噪音，聚焦核心内容，避免过度装饰 |
| Connection | 统一设计语言，跨产品、跨平台一致性体验，降低认知成本 |
| Openness | 灵活可扩展，支持主题定制（CSS变量覆盖），适配不同业务场景 |

Naming Convention - PBEM:

| Component | Syntax | Example |
|-----------|--------|---------|
| Prefix | `t` | -- |
| Block | `t-{block}` | `.t-button` |
| Modifier | `t-{block}--{modifier}` | `.t-button--primary`, `.t-button--large` |
| Element | `t-{block}__{element}` | `.t-button__icon` |
| Element + Modifier | `t-{block}__{element}--{modifier}` | `.t-button__icon--loading` |

适用场景优先级：
1. 腾讯系项目（首选）
2. 需要 Web + 移动端统一的项目
3. 需要精细色彩控制的项目（10级色阶）
4. 企业级 SaaS / 管理后台

---

## 2. Color Tokens

### 2.1 Brand Color Scale (10 Levels)

```css
:root {
    --td-brand-color-1:  #f2f3ff;    /* 浅色背景、选中态 */
    --td-brand-color-2:  #d9e1ff;    /* 聚焦态背景 */
    --td-brand-color-3:  #b5c7ff;    /* 禁用态背景 */
    --td-brand-color-4:  #8eabff;
    --td-brand-color-5:  #618dff;
    --td-brand-color-6:  #366ef4;    /* 悬停态 */
    --td-brand-color-7:  #0052d9;    /* [BRAND PRIMARY] */
    --td-brand-color-8:  #003cab;    /* 点击态 */
    --td-brand-color-9:  #002a7c;
    --td-brand-color-10: #001a57;
}
```

### 2.2 Brand Color States

```css
:root {
    --td-brand-color:            #0052d9;    /* 品牌主色 */
    --td-brand-color-hover:      #366ef4;    /* 悬停态 */
    --td-brand-color-active:     #003cab;    /* 点击态 */
    --td-brand-color-disabled:   #b5c7ff;    /* 禁用态 */
    --td-brand-color-focus:      #d9e1ff;    /* 聚焦态 */
    --td-brand-color-light:      #f2f3ff;    /* 浅色选中态 */
    --td-brand-color-light-hover:#d9e1ff;    /* 浅色选中态悬停 */
}
```

### 2.3 Semantic Color Scales

**Success (10 levels):**

```css
--td-success-color-1:  #e3f9e9;
--td-success-color-2:  #c6f3d7;
--td-success-color-3:  #92dab2;    /* Disabled */
--td-success-color-4:  #56c08d;    /* Hover */
--td-success-color-5:  #2ba471;
--td-success-color-6:  #008858;    /* [DEFAULT] */
--td-success-color-7:  #006c45;    /* Active */
--td-success-color-8:  #005334;
--td-success-color-9:  #003b23;
--td-success-color-10: #002515;
```

**Warning (10 levels):**

```css
--td-warning-color-1:  #fff1e9;
--td-warning-color-2:  #ffd9c2;
--td-warning-color-3:  #ffb98c;    /* Disabled */
--td-warning-color-4:  #fa9550;    /* Hover */
--td-warning-color-5:  #e37318;    /* [DEFAULT] */
--td-warning-color-6:  #be5a00;    /* Active */
--td-warning-color-7:  #954500;
--td-warning-color-8:  #713300;
--td-warning-color-9:  #532300;
--td-warning-color-10: #3b1700;
```

**Error (10 levels):**

```css
--td-error-color-1:  #fff0ed;
--td-error-color-2:  #ffd8d2;
--td-error-color-3:  #ffb9b0;    /* Disabled */
--td-error-color-4:  #ff9285;    /* Hover */
--td-error-color-5:  #f6685d;
--td-error-color-6:  #d54941;    /* [DEFAULT] */
--td-error-color-7:  #ad352f;    /* Active */
--td-error-color-8:  #881f1c;
--td-error-color-9:  #68070a;
--td-error-color-10: #490002;
```

**Semantic Color States Summary:**

| Type | Default | Hover | Active | Disabled | Light |
|------|---------|-------|--------|----------|-------|
| Success | `#008858` | `#56c08d` | `#006c45` | `#92dab2` | `#e3f9e9` |
| Warning | `#e37318` | `#fa9550` | `#be5a00` | `#ffb98c` | `#fff1e9` |
| Error | `#d54941` | `#f6685d` | `#ad352f` | `#ffb9b0` | `#fff0ed` |

### 2.4 Grayscale (14 Levels)

```css
:root {
    --td-gray-color-1:  #f3f3f3;    /* 页面背景、次级容器背景 */
    --td-gray-color-2:  #eeeeee;    /* 页面背景（浅色主题） */
    --td-gray-color-3:  #e8e8e8;    /* 分割线、组件背景 */
    --td-gray-color-4:  #dddddd;    /* 边框、组件悬停背景 */
    --td-gray-color-5:  #c6c6c6;    /* 次级组件悬停 */
    --td-gray-color-6:  #a6a6a6;    /* 组件点击态 */
    --td-gray-color-7:  #8b8b8b;
    --td-gray-color-8:  #777777;
    --td-gray-color-9:  #5e5e5e;
    --td-gray-color-10: #4b4b4b;
    --td-gray-color-11: #393939;
    --td-gray-color-12: #2c2c2c;
    --td-gray-color-13: #242424;
    --td-gray-color-14: #181818;
}
```

### 2.5 Text Colors

```css
:root {
    /* Dark text (on light backgrounds) */
    --td-font-gray-1:              rgba(0, 0, 0, 0.9);     /* Primary text */
    --td-font-gray-2:              rgba(0, 0, 0, 0.6);     /* Secondary text */
    --td-font-gray-3:              rgba(0, 0, 0, 0.4);     /* Placeholder */
    --td-font-gray-4:              rgba(0, 0, 0, 0.26);    /* Disabled text */

    /* Light text (on dark backgrounds) */
    --td-font-white-1:             rgba(255, 255, 255, 1);   /* Primary inverted */
    --td-font-white-2:             rgba(255, 255, 255, 0.55);/* Secondary inverted */
    --td-font-white-3:             rgba(255, 255, 255, 0.35);/* Tertiary inverted */
    --td-font-white-4:             rgba(255, 255, 255, 0.22);/* Disabled inverted */

    /* Semantic text tokens */
    --td-text-color-primary:       rgba(0, 0, 0, 0.9);     /* Main text */
    --td-text-color-secondary:     rgba(0, 0, 0, 0.6);     /* Secondary text */
    --td-text-color-placeholder:   rgba(0, 0, 0, 0.4);     /* Placeholder */
    --td-text-color-disabled:      rgba(0, 0, 0, 0.26);    /* Disabled */
    --td-text-color-anti:          #ffffff;                  /* Inverted text */
    --td-text-color-brand:         #0052d9;                  /* Brand color text */
    --td-text-color-link:          #003cab;                  /* Link text */
}
```

### 2.6 Background Colors

```css
:root {
    --td-bg-color-page:                #eeeeee;    /* Page background */
    --td-bg-color-container:           #ffffff;     /* Container (card, table) */
    --td-bg-color-container-hover:     #f3f3f3;    /* Container hover */
    --td-bg-color-container-active:    #e8e8e8;    /* Container active */
    --td-bg-color-secondarycontainer:  #f3f3f3;    /* Secondary container */
    --td-bg-color-component:           #e8e8e8;    /* Component (button, input) */
    --td-bg-color-component-hover:     #dddddd;    /* Component hover */
    --td-bg-color-component-active:    #a6a6a6;    /* Component active */
    --td-bg-color-component-disabled:  #eeeeee;    /* Component disabled */
    --td-bg-color-specialcomponent:    #ffffff;     /* Special (Button/Input bg) */
}
```

### 2.7 Border Colors

```css
:root {
    --td-border-level-1-color:   #e8e8e8;    /* Divider (level-1) */
    --td-component-stroke:       #e8e8e8;    /* Component stroke */
    --td-border-level-2-color:   #dddddd;    /* Border (level-2) */
    --td-component-border:       #dddddd;    /* Component border */
}
```

### 2.8 Mask Colors

```css
:root {
    --td-mask-active:       rgba(0, 0, 0, 0.6);       /* Dialog/Drawer mask */
    --td-mask-disabled:     rgba(255, 255, 255, 0.6);  /* Disabled mask */
    --td-mask-background:   rgba(255, 255, 255, 0.96); /* QR code mask */
}
```

### 2.9 Scrollbar Colors

```css
:root {
    --td-scrollbar-color:        rgba(0, 0, 0, 0.1);   /* Scrollbar thumb */
    --td-scrollbar-hover-color:  rgba(0, 0, 0, 0.3);   /* Scrollbar thumb hover */
    --td-scroll-track-color:     #ffffff;                /* Scrollbar track */
}
```

### 2.10 Complete CSS Variable Block

```css
:root {
    /* Brand */
    --td-brand-color: #0052d9;
    --td-brand-color-hover: #366ef4;
    --td-brand-color-active: #003cab;
    --td-brand-color-disabled: #b5c7ff;
    --td-brand-color-light: #f2f3ff;

    /* Semantic */
    --td-success-color: #008858;
    --td-warning-color: #e37318;
    --td-error-color: #d54941;

    /* Text */
    --td-text-color-primary: rgba(0, 0, 0, 0.9);
    --td-text-color-secondary: rgba(0, 0, 0, 0.6);
    --td-text-color-placeholder: rgba(0, 0, 0, 0.4);
    --td-text-color-disabled: rgba(0, 0, 0, 0.26);
    --td-text-color-anti: #ffffff;
    --td-text-color-brand: #0052d9;
    --td-text-color-link: #003cab;

    /* Background */
    --td-bg-color-page: #eeeeee;
    --td-bg-color-container: #ffffff;
    --td-bg-color-component: #e8e8e8;

    /* Border */
    --td-border-level-1-color: #e8e8e8;
    --td-border-level-2-color: #dddddd;

    /* Mask */
    --td-mask-active: rgba(0, 0, 0, 0.6);
    --td-mask-disabled: rgba(255, 255, 255, 0.6);
}
```

---

## 3. Typography

### 3.1 Font Family

```css
--td-font-family: PingFang SC, Microsoft YaHei, Arial Regular;
--td-font-family-medium: PingFang SC, Microsoft YaHei, Arial Medium;
```

| Platform | Primary | Fallback |
|----------|---------|----------|
| macOS/iOS | PingFang SC | Helvetica Neue, Arial |
| Windows | Microsoft YaHei | Arial, SimHei |
| Android | Noto Sans SC | Roboto, Arial |
| Linux | Noto Sans SC | WenQuanYi Micro Hei |

### 3.2 Font Size Hierarchy

| Token | Size | Usage |
|-------|------|-------|
| `--td-font-size-body-small` | `12px` | Helper text, Tag, timestamps |
| `--td-font-size-body-medium` | `14px` | **Body text, forms, buttons (default)** |
| `--td-font-size-body-large` | `16px` | Important body text |
| `--td-font-size-title-small` | `14px` | Small title |
| `--td-font-size-title-medium` | `16px` | Medium title |
| `--td-font-size-title-large` | `18px` | Large title |
| `--td-font-size-title-extraLarge` | `20px` | Extra large title |
| `--td-font-size-headline-small` | `24px` | Headline small |
| `--td-font-size-headline-medium` | `28px` | Headline medium |
| `--td-font-size-headline-large` | `36px` | Headline large |
| `--td-font-size-display-medium` | `48px` | Display medium |
| `--td-font-size-display-large` | `64px` | Display large |

### 3.3 Line Height System

Each font size has a paired line height:

| Token | Value | Paired Font Size | Ratio |
|-------|-------|-----------------|-------|
| `--td-line-height-body-small` | `20px` | 12px | 1.67 |
| `--td-line-height-body-medium` | `22px` | 14px | 1.57 |
| `--td-line-height-body-large` | `24px` | 16px | 1.50 |
| `--td-line-height-title-small` | `22px` | 14px | 1.57 |
| `--td-line-height-title-medium` | `24px` | 16px | 1.50 |
| `--td-line-height-title-large` | `26px` | 18px | 1.44 |
| `--td-line-height-title-extraLarge` | `28px` | 20px | 1.40 |
| `--td-line-height-headline-small` | `32px` | 24px | 1.33 |
| `--td-line-height-headline-medium` | `36px` | 28px | 1.29 |
| `--td-line-height-headline-large` | `44px` | 36px | 1.22 |
| `--td-line-height-display-medium` | `56px` | 48px | 1.17 |
| `--td-line-height-display-large` | `72px` | 64px | 1.13 |

### 3.4 Font Weight

| Weight | Usage |
|--------|-------|
| `400` Regular | Body, table, form, description |
| `500` Medium | Button text, form labels, menu items |
| `600` SemiBold | Titles, card titles, important info |
| `700` Bold | Large titles, emphasized text |

### 3.5 Combined Font Tokens (shorthand)

```css
/* Body */
--td-font-body-small:   12px / 20px var(--td-font-family);
--td-font-body-medium:  14px / 22px var(--td-font-family);
--td-font-body-large:   16px / 24px var(--td-font-family);

/* Title (600 weight) */
--td-font-title-small:       600 14px / 22px var(--td-font-family);
--td-font-title-medium:      600 16px / 24px var(--td-font-family);
--td-font-title-large:       600 18px / 26px var(--td-font-family);
--td-font-title-extraLarge:  600 20px / 28px var(--td-font-family);

/* Headline (600 weight) */
--td-font-headline-small:   600 24px / 32px var(--td-font-family);
--td-font-headline-medium:  600 28px / 36px var(--td-font-family);
--td-font-headline-large:   600 36px / 44px var(--td-font-family);

/* Display (600 weight) */
--td-font-display-medium: 600 48px / 56px var(--td-font-family);
--td-font-display-large:  600 64px / 72px var(--td-font-family);

/* Link */
--td-font-link-small:  12px / 20px var(--td-font-family);
--td-font-link-medium: 14px / 22px var(--td-font-family);
--td-font-link-large:  16px / 24px var(--td-font-family);

/* Mark (600 weight) */
--td-font-mark-small:  600 12px / 20px var(--td-font-family);
--td-font-mark-medium: 600 14px / 22px var(--td-font-family);
```

### 3.6 Mobile Typography Differences

Mobile font sizes are 2px larger than Web for touchscreen readability:

| Token | Mobile | Web |
|-------|--------|-----|
| Small title | `16px` | `14px` |
| Medium title | `18px` | `16px` |
| Large title | `20px` | `18px` |
| Headline | `28px+` | `24px+` |

---

## 4. Spacing System

### 4.1 Base Sizes (16 levels, 2px increments)

```css
:root {
    --td-size-1:  2px;
    --td-size-2:  4px;
    --td-size-3:  6px;
    --td-size-4:  8px;
    --td-size-5:  12px;
    --td-size-6:  16px;
    --td-size-7:  20px;
    --td-size-8:  24px;
    --td-size-9:  28px;
    --td-size-10: 32px;
    --td-size-11: 36px;
    --td-size-12: 40px;
    --td-size-13: 48px;
    --td-size-14: 56px;
    --td-size-15: 64px;
    --td-size-16: 72px;
}
```

### 4.2 Component Heights (11 levels)

```css
:root {
    --td-comp-size-xxxs:  16px;
    --td-comp-size-xxs:   20px;
    --td-comp-size-xs:    24px;     /* Button S */
    --td-comp-size-s:     28px;     /* Partial components */
    --td-comp-size-m:     32px;     /* [DEFAULT] standard */
    --td-comp-size-l:     36px;
    --td-comp-size-xl:    40px;     /* Button L */
    --td-comp-size-xxl:   48px;
    --td-comp-size-xxxl:  56px;
    --td-comp-size-xxxxl: 64px;
    --td-comp-size-xxxxxl:72px;
}
```

| Component | Height |
|-----------|--------|
| Small button | `24px` |
| Default button | `32px` |
| Large button | `40px` |
| Small input | `24px` |
| Default input | `32px` |
| Large input | `40px` |
| Tag | `22px` |
| Menu item | `40px` |
| Pagination item | `32px` |

### 4.3 Padding Tokens

```css
:root {
    /* Left/Right padding */
    --td-comp-paddingLR-xxs: 2px;
    --td-comp-paddingLR-xs: 4px;
    --td-comp-paddingLR-s:  8px;
    --td-comp-paddingLR-m:  12px;
    --td-comp-paddingLR-l:  16px;    /* [DEFAULT] */
    --td-comp-paddingLR-xl: 24px;
    --td-comp-paddingLR-xxl:32px;

    /* Top/Bottom padding */
    --td-comp-paddingTB-xxs: 2px;
    --td-comp-paddingTB-xs: 4px;
    --td-comp-paddingTB-s:  8px;
    --td-comp-paddingTB-m:  12px;
    --td-comp-paddingTB-l:  16px;    /* [DEFAULT] */
    --td-comp-paddingTB-xl: 24px;
    --td-comp-paddingTB-xxl:32px;
}
```

### 4.4 Margin Tokens

```css
:root {
    --td-comp-margin-xxs:  2px;
    --td-comp-margin-xs:   4px;
    --td-comp-margin-s:    8px;
    --td-comp-margin-m:    12px;
    --td-comp-margin-l:    16px;     /* [DEFAULT] */
    --td-comp-margin-xl:   20px;
    --td-comp-margin-xxl:  24px;
    --td-comp-margin-xxxl: 32px;
    --td-comp-margin-xxxxl:40px;
}
```

### 4.5 Popup Padding Tokens

```css
:root {
    --td-pop-padding-s:   4px;
    --td-pop-padding-m:   6px;
    --td-pop-padding-l:   8px;
    --td-pop-padding-xl:  12px;
    --td-pop-padding-xxl: 16px;
}
```

### 4.6 Mobile Spacer Tokens

Mobile uses independent spacing:

```css
:root {
    --td-spacer:   8px;     /* Base */
    --td-spacer-1: 12px;
    --td-spacer-2: 16px;
    --td-spacer-3: 24px;
    --td-spacer-4: 32px;
    --td-spacer-5: 48px;
    --td-spacer-6: 80px;
}
```

### 4.7 Border Radius System

```css
:root {
    --td-radius-small:      2px;      /* Tag inner elements */
    --td-radius-default:    3px;      /* [DEFAULT] Button, Input */
    --td-radius-medium:     6px;      /* Button (medium variant) */
    --td-radius-large:      9px;      /* Card */
    --td-radius-extraLarge: 12px;     /* Modal */
    --td-radius-round:      999px;    /* Capsule button */
    --td-radius-circle:     50%;      /* Avatar, icon button */
}
```

| Component | Radius |
|-----------|--------|
| Button (default) | `3px` |
| Button (medium) | `6px` |
| Input | `3px` |
| Card | `9px` |
| Modal | `12px` |
| Tag | `3px` |
| Avatar | `50%` |
| Icon button | `50%` |
| Capsule button | `999px` |

### 4.8 Common Spacing Scenarios

| Context | Padding |
|---------|---------|
| Page content | `24px` |
| Card content | `16px` |
| Card header | `16px 24px` |
| Modal header | `16px 24px` |
| Modal body | `24px` |
| Modal footer | `16px 24px` |
| Table cell | `12px 16px` |
| Table toolbar | `16px 24px` |
| Menu item | `0 16px` |
| Tag | `0 8px` |
| Button (default) | `0 16px` |
| Button (large) | `0 24px` |

---

## 5. Shadow System

### 5.1 Three-Layer Shadow Architecture

```css
:root {
    /* Layer 1: Basic - Card hover, table row hover */
    --td-shadow-1: 0 1px 10px rgba(0, 0, 0, 0.05),
                   0 4px 5px rgba(0, 0, 0, 0.08),
                   0 2px 4px -1px rgba(0, 0, 0, 0.12);

    /* Layer 2: Medium - Dropdown, Select, Popconfirm */
    --td-shadow-2: 0 3px 14px 2px rgba(0, 0, 0, 0.05),
                   0 8px 10px 1px rgba(0, 0, 0, 0.06),
                   0 5px 5px -3px rgba(0, 0, 0, 0.1);

    /* Layer 3: Upper - Dialog, Drawer, Message, Notification */
    --td-shadow-3: 0 6px 30px 5px rgba(0, 0, 0, 0.05),
                   0 16px 24px 2px rgba(0, 0, 0, 0.04),
                   0 8px 10px -5px rgba(0, 0, 0, 0.08);
}
```

### 5.2 Inset Shadows

```css
:root {
    --td-shadow-inset-top:    inset 0 0.5px 0 #dcdcdc;
    --td-shadow-inset-right:  inset 0.5px 0 0 #dcdcdc;
    --td-shadow-inset-bottom: inset 0 -0.5px 0 #dcdcdc;
    --td-shadow-inset-left:   inset -0.5px 0 0 #dcdcdc;

    /* Combined inset */
    --td-shadow-inset: var(--td-shadow-inset-top),
                       var(--td-shadow-inset-right),
                       var(--td-shadow-inset-bottom),
                       var(--td-shadow-inset-left);
}
```

### 5.3 Composite Shadows

```css
--td-shadow-2-inset: var(--td-shadow-2), var(--td-shadow-inset);   /* Medium + inset */
--td-shadow-3-inset: var(--td-shadow-3), var(--td-shadow-inset);   /* Upper + inset */
```

### 5.4 Shadow Usage Guide

| Component | Shadow |
|-----------|--------|
| Card hover | `--td-shadow-1` |
| Table row hover | `--td-shadow-1` |
| Dropdown menu | `--td-shadow-2` |
| Select dropdown | `--td-shadow-2` |
| Popconfirm | `--td-shadow-2` |
| Dialog | `--td-shadow-3` or `--td-shadow-3-inset` |
| Drawer | `--td-shadow-3` |
| Message | `--td-shadow-3` |
| Notification | `--td-shadow-3-inset` |

### 5.5 Mobile Shadow

```css
--td-shadow-4: 0 2px 8px 0 rgba(0, 0, 0, 0.06);
```

---

## 6. Motion / Animation

### 6.1 Easing Curves

```css
:root {
    --td-anim-time-fn-easing:   cubic-bezier(0.38, 0, 0.24, 1);    /* Standard (default) */
    --td-anim-time-fn-ease-out: cubic-bezier(0, 0, 0.15, 1);       /* Ease out (appear) */
    --td-anim-time-fn-ease-in:  cubic-bezier(0.82, 0, 1, 0.9);     /* Ease in (disappear) */
}
```

### 6.2 Animation Durations

```css
:root {
    --td-anim-duration-base:     0.2s;     /* Default */
    --td-anim-duration-moderate: 0.24s;    /* Medium */
    --td-anim-duration-slow:     0.28s;    /* Slow */
}
```

| Scenario | Duration |
|----------|----------|
| Button hover | `0.2s` |
| Input focus | `0.2s` |
| Dropdown expand | `0.24s` |
| Dialog open | `0.28s` |
| Drawer open | `0.28s` |
| Message appear | `0.24s` |
| Toast dismiss | `0.2s` |

### 6.3 Keyframes

```css
@keyframes fadeIn    { from { opacity: 0; } to { opacity: 1; } }
@keyframes fadeOut   { from { opacity: 1; } to { opacity: 0; } }
@keyframes slideDownIn { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }
@keyframes slideUpIn   { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
@keyframes slideLeftIn { from { opacity: 0; transform: translateX(100%); } to { opacity: 1; transform: translateX(0); } }
@keyframes zoomIn    { from { opacity: 0; transform: scale(0.8); } to { opacity: 1; transform: scale(1); } }
@keyframes zoomOut   { from { opacity: 1; transform: scale(1); } to { opacity: 0; transform: scale(0.8); } }
@keyframes spin      { from { transform: rotate(0deg); } to { transform: rotate(360deg); } }
```

### 6.4 Transition Examples (PBEM)

```css
.t-button { transition: all var(--td-anim-duration-base) var(--td-anim-time-fn-easing); }
.t-input  { transition: border-color var(--td-anim-duration-base) var(--td-anim-time-fn-easing),
                         box-shadow var(--td-anim-duration-base) var(--td-anim-time-fn-easing); }
.t-dropdown-menu { animation: slideDownIn var(--td-anim-duration-moderate) var(--td-anim-time-fn-ease-out); }
.t-dialog { animation: zoomIn var(--td-anim-duration-slow) var(--td-anim-time-fn-ease-out); }
.t-drawer { animation: slideLeftIn var(--td-anim-duration-slow) var(--td-anim-time-fn-ease-out); }
```

---

## 7. Component Specs (PBEM Naming)

### 7.1 Button

```css
/* Base block */
.t-button {
    display: inline-flex; align-items: center; justify-content: center;
    gap: 8px; font: var(--td-font-body-medium);
    border-radius: var(--td-radius-default);
    cursor: pointer; transition: all var(--td-anim-duration-base) var(--td-anim-time-fn-easing);
}

/* Variants (5+) */
.t-button--primary   { background: var(--td-brand-color); color: var(--td-text-color-anti); border: none; }
.t-button--default   { background: var(--td-bg-color-specialcomponent); color: var(--td-text-color-primary); border: 1px solid var(--td-component-border); }
.t-button--danger    { background: var(--td-error-color); color: var(--td-text-color-anti); border: none; }
.t-button--warning   { background: var(--td-warning-color); color: var(--td-text-color-anti); border: none; }
.t-button--success   { background: var(--td-success-color); color: var(--td-text-color-anti); border: none; }
.t-button--text      { background: transparent; border: none; color: var(--td-brand-color); }
.t-button--link      { background: transparent; border: none; color: var(--td-text-color-link); }

/* Sizes (3) */
.t-button--small     { height: var(--td-comp-size-xs); padding: 0 var(--td-comp-paddingLR-m); font: var(--td-font-body-small); }
.t-button--medium    { height: var(--td-comp-size-m);  padding: 0 var(--td-comp-paddingLR-l); font: var(--td-font-body-medium); }
.t-button--large     { height: var(--td-comp-size-xl); padding: 0 var(--td-comp-paddingLR-xl); font: var(--td-font-body-large); }

/* Shapes (4) */
.t-button--rectangle { border-radius: var(--td-radius-default); }
.t-button--round     { border-radius: var(--td-radius-medium); }
.t-button--circle    { border-radius: var(--td-radius-circle); width: var(--td-comp-size-m); padding: 0; }
.t-button--capsule   { border-radius: var(--td-radius-round); }

/* States */
.t-button:hover { /* hover styles */ }
.t-button--primary:hover   { background: var(--td-brand-color-hover); }
.t-button--primary:active  { background: var(--td-brand-color-active); }
.t-button--primary:disabled { background: var(--td-brand-color-disabled); cursor: not-allowed; }

/* Elements */
.t-button__icon { display: inline-flex; }
.t-button__icon--loading { animation: spin 0.8s linear infinite; }
```

### 7.2 Table

| Feature | Support |
|---------|---------|
| Virtual scroll | Yes (for large datasets) |
| Tree data | Yes (expandable rows) |
| Fixed columns | Yes (left/right freeze) |
| Sortable columns | Yes |
| Filterable columns | Yes |
| Custom cell render | Yes |

```css
.t-table { width: 100%; border-collapse: collapse; }
.t-table__header th { background: var(--td-bg-color-secondarycontainer); padding: 12px 16px; font-weight: 600; }
.t-table__body td { padding: 12px 16px; border-bottom: 1px solid var(--td-border-level-1-color); }
.t-table__row:hover { background: var(--td-bg-color-container-hover); }
```

### 7.3 Form

```css
.t-form { display: flex; flex-direction: column; gap: var(--td-comp-margin-l); }
.t-form__item { display: flex; flex-direction: column; gap: var(--td-comp-margin-s); }
.t-form__label { font: var(--td-font-body-medium); font-weight: 500; }
.t-form__status--error .t-input { border-color: var(--td-error-color); }
.t-form__status--success .t-input { border-color: var(--td-success-color); }
.t-form__help { font: var(--td-font-body-small); color: var(--td-text-color-placeholder); }
.t-form__error { font: var(--td-font-body-small); color: var(--td-error-color); }
```

Built-in validation types: required, email, url, number, date, min/max length, pattern, custom validator.

### 7.4 Dialog

```css
.t-dialog__mask { position: fixed; inset: 0; background: var(--td-mask-active); z-index: var(--td-z-index-dialog); }
.t-dialog { background: var(--td-bg-color-container); border-radius: var(--td-radius-extraLarge);
            animation: zoomIn var(--td-anim-duration-slow) var(--td-anim-time-fn-ease-out); }
.t-dialog__header { padding: 16px 24px; }
.t-dialog__body { padding: 24px; }
.t-dialog__footer { padding: 16px 24px; display: flex; justify-content: flex-end; gap: 8px; }
```

Command-style invoke: `Dialog.confirm({ title, content, confirmBtn, cancelBtn })` and `Dialog.alert({ title, content })`.

---

## 8. Platform Coverage

### 8.1 Web Components (60+)

| Category | Components |
|----------|-----------|
| General | Button, Icon, Link |
| Layout | Grid, Layout, Space |
| Navigation | Menu, Breadcrumb, Pagination, Tabs, Steps, Dropdown, Anchor, Affix |
| Data Entry | Form, Input, Select, Checkbox, Radio, Switch, DatePicker, TimePicker, Upload, Transfer, Cascader, ColorPicker |
| Data Display | Table, Card, Tag, Badge, Avatar, List, Tree, Descriptions, Statistic, Timeline, Image, QRCode |
| Feedback | Dialog, Drawer, Message, Notification, Popconfirm, Popover, Tooltip, Progress, Loading, Alert |
| Other | BackTop, Divider, Collapse, Comment, Calendar, Result |

### 8.2 Mobile Components (50+)

| Category | Components |
|----------|-----------|
| General | Button, Icon, Link |
| Layout | Grid, Cell, Footer, Navbar |
| Navigation | TabBar, Indexes, Stepper, DropdownMenu |
| Data Entry | Form, Input, Picker, DateTimePicker, Checkbox, Radio, Switch, Rate, Search, Upload |
| Data Display | Avatar, Badge, Card, Image, Progress, CountDown, NoticeBar, Result |
| Feedback | Dialog, Drawer, Message, Toast, ActionSheet, Popup, PullDownRefresh, Loading |
| Other | Divider, Collapse, SwipeCell, Fab, Guide |

### 8.3 Framework Support

| Platform | Framework | Repository |
|----------|-----------|------------|
| Web | React | tdesign-react |
| Web | Vue 3 | tdesign-vue-next |
| Web | Vue 2 | tdesign-vue |
| Mobile | React Native | tdesign-mobile-react |
| Mobile | Vue 3 | tdesign-mobile-vue |
| Mini Program | WeChat | tdesign-miniprogram |

---

## 9. Layout Patterns

### 9.1 Side-Nav Layout

```
+--.t-layout (flex, min-height: 100vh)--------------------------------+
| +--.t-aside (width: 232px, fixed)--+ +--.t-layout (flex:1)----------+|
| |                                   | | +--.t-header (48-56px)----+ ||
| | +--.t-aside__logo (48px)--------+| | | [breadcrumb]   [actions] | ||
| | | [Logo]  App Name              || | +--------------------------+ ||
| | +-------------------------------+| | +--.t-content (flex:1)-----+ ||
| | +--.t-menu----------------------+| | |                          | ||
| | | .t-menu__group-title          || | |   .t-card                | ||
| | | .t-menu__item                 || | |   +--.t-card__header---+ | ||
| | | .t-menu__item--active         || | |   | Card Title         | | ||
| | | .t-menu__item                 || | |   +-------------------+ | ||
| | |                               || | |   +--.t-card__body---+ | ||
| | +-------------------------------+| | |   | Content           | | ||
| +----------------------------------+ | |   +-------------------+ | ||
|                                      | +--------------------------+ ||
|                                      +-------------------------------+
+----------------------------------------------------------------------+
```

### 9.2 Top-Nav Layout

```
+--.t-layout-----------------------------------------------------------+
| +--.t-header (width: 100%, height: 56px)----------------------------+|
| | [Logo]  App Name   |  Menu 1  Menu 2  Menu 3  |  [User Actions]  ||
| +--------------------------------------------------------------------+|
| +--.t-content (padding: 24px)----------------------------------------+|
| |                                                                    ||
| |  [Page Content]                                                    ||
| |                                                                    ||
| +--------------------------------------------------------------------+|
+----------------------------------------------------------------------+
```

### 9.3 Hybrid Layout

```
+--.t-layout-----------------------------------------------------------+
| +--.t-header (width: 100%, height: 48px, top nav)-------------------+|
| | [Logo]  |  Global Menu  |  [User]                                 ||
| +--------------------------------------------------------------------+|
| +--.t-aside (width: 200px, sub-nav)--+ +--.t-content (flex:1)--------+|
| |                                    | |                              ||
| |  Sub-menu items                    | |  Page content area           ||
| |                                    | |                              ||
| +------------------------------------+ +------------------------------+|
+----------------------------------------------------------------------+
```

### 9.4 Grid System (24-column)

```css
.t-row { display: flex; flex-wrap: wrap; }
.t-col-1  { width: 4.1667%; }   /* 1/24 */
.t-col-6  { width: 25%; }       /* 6/24 */
.t-col-8  { width: 33.3333%; }  /* 8/24 */
.t-col-12 { width: 50%; }       /* 12/24 */
.t-col-16 { width: 66.6667%; }  /* 16/24 */
.t-col-18 { width: 75%; }       /* 18/24 */
.t-col-24 { width: 100%; }      /* 24/24 */

/* Gutter */
.t-row--gutter { gap: 16px; }
```

---

## 10. z-index Management

| Token | Value | Component |
|-------|-------|-----------|
| `--td-z-index-back-top` | `300` | Back to top button |
| `--td-z-index-affix` | `500` | Affix / sticky |
| `--td-z-index-drawer` | `1500` | Drawer |
| `--td-z-index-dialog` | `2500` | Dialog / Modal |
| `--td-z-index-image-viewer` | `3000` | Image preview |
| `--td-z-index-loading` | `3500` | Loading overlay |
| `--td-z-index-message` | `5000` | Global message |
| `--td-z-index-popup` | `5500` | Popup / Dropdown |
| `--td-z-index-tooltip` | `5600` | Tooltip |
| `--td-z-index-notification` | `6000` | Notification |
| `--td-z-index-dragging` | `6500` | Dragging element |
| `--td-z-index-guide` | `999999` | Onboarding guide |

---

## 11. Theme Customization

### 11.1 Light Theme Override

```css
:root {
    --td-brand-color: #1890ff;
    --td-brand-color-hover: #40a9ff;
    --td-brand-color-active: #096dd9;
    --td-radius-default: 4px;
    --td-radius-medium: 8px;
}
```

### 11.2 Dark Theme

```css
:root[theme-mode='dark'] {
    --td-bg-color-page: #141414;
    --td-bg-color-container: #1f1f1f;
    --td-text-color-primary: rgba(255, 255, 255, 0.9);
    --td-text-color-secondary: rgba(255, 255, 255, 0.55);
    --td-text-color-placeholder: rgba(255, 255, 255, 0.35);
    --td-border-level-1-color: #383838;
    --td-border-level-2-color: #4b4b4b;
}
```

---

## 12. Local File Reference

| Category | File | Path |
|----------|------|------|
| Overview | README | `C:/Users/Admin/tdesign设计系统/README.md` |
| Colors | Token | `C:/Users/Admin/tdesign设计系统/tokens/colors.md` |
| Typography | Token | `C:/Users/Admin/tdesign设计系统/tokens/typography.md` |
| Spacing | Token | `C:/Users/Admin/tdesign设计系统/tokens/spacing.md` |
| Shadow | Token | `C:/Users/Admin/tdesign设计系统/tokens/shadow.md` |
| Motion | Token | `C:/Users/Admin/tdesign设计系统/tokens/motion.md` |
| Button | Component | `C:/Users/Admin/tdesign设计系统/components/button.md` |
| Form | Component | `C:/Users/Admin/tdesign设计系统/components/form.md` |
| Feedback | Component | `C:/Users/Admin/tdesign设计系统/components/feedback.md` |
| Navigation | Component | `C:/Users/Admin/tdesign设计系统/components/navigation.md` |
| Data Display | Component | `C:/Users/Admin/tdesign设计系统/components/data-display.md` |
| Layout | Pattern | `C:/Users/Admin/tdesign设计系统/patterns/layout.md` |
| Responsive | Pattern | `C:/Users/Admin/tdesign设计系统/patterns/responsive.md` |
| Web Platform | Platform | `C:/Users/Admin/tdesign设计系统/platform/web.md` |
| Mobile Platform | Platform | `C:/Users/Admin/tdesign设计系统/platform/mobile.md` |

---

*Last updated: 2026-04-30 | Source: TDesign GitHub (tdesign-common)*
