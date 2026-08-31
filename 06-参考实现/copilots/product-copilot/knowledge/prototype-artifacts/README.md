# 原型四件套速查（知识库）

> **权威源**：[02-产物层/设计/产品原型设计规范.md](../../../../02-产物层/设计/产品原型设计规范.md)。本文件是速查版，数字指标以 [01-标准层/06-产物质量硬指标库.md](../../../../01-标准层/06-产物质量硬指标库.md) 为准。
> **对应 QG**：QG-设计.12 原型完整性（🔴 硬阻塞）

---

## 四件套一览

| # | 产物 | 格式 | 核心机制 |
|---|------|------|---------|
| 1 | 页面树 | `页面树.yaml` | 页面 ID 全局唯一；同页多状态同画布铺开（states）；links.to 必须命中 |
| 2 | 高保真原型包 | `原型包/index.html + pages/**` | 纯净无增强代码；单一设计系统 |
| 3 | 标注数据 | `标注数据.json` | ANN-NNN → REQ-NNN 挂接到 selector |
| 4 | 原型说明 | `原型说明-v1.0.md` | 走查路径 + 需求↔页面覆盖矩阵 |

## 页面树最小示例

```yaml
design_system: ant-design-pro
pages:
  - id: login
    title: 登录页
    path: pages/01-登录.html
    responsibility: 用户身份认证入口
    states:
      - name: 默认
      - name: 错误提示
        area: "右侧第二屏"
    children:
      - id: login-sms
        title: 短信登录
        path: pages/01-登录/01-短信登录.html
        responsibility: 手机号+验证码登录
    links:
      - to: home
        trigger: 登录成功
```

**5 项校验**：id 唯一 / path 存在 / links 命中 / children 递归同构 / 父页文件+子页目录同名并存。

## 标注数据最小示例

```json
{
  "version": 1,
  "items": [
    {"id": "ANN-001", "page": "login", "selector": "#login-form .submit-btn",
     "req": "REQ-001", "note": "连续点击防抖，提交后按钮置灰",
     "author": "zhangsan", "status": "open"}
  ]
}
```

**校验**：ANN id 唯一 / page 命中页面树 / req 命中需求清单 / **P0 需求标注覆盖率 100%**。

## 追溯主链（写作时必须贯通）

```
SRC-NNN（素材）→ REQ-NNN（需求）→ F 编号（方案项）→ 页面ID + ANN-NNN（原型）→ PRD → AC-NNN（验收）
```

## PRD 反向引用（prototype_ref）

PRD 文档信息区登记页面树快照与标注版本；功能总览表带「需求 ID」「原型页面 ID」两列；交互章节引用 `页面ID + ANN 编号`，不复制标注内容。

## 与 ai-product-dev-kit-modular 的对应

| 规范产物 | kit 产物 |
|---------|---------|
| 页面树.yaml | YAML 页面清单（含「目录」「路径」字段，v3.4） |
| 原型包/ | 系统文件/index.html + pages/{模块目录}/*.html |
| 标注数据.json | 项目文档/标注数据.json（按页面 ID 分组） |
| 原型说明.md | 需在 Stage 4 交付时补齐覆盖矩阵（kit 未内置，按模板补） |
