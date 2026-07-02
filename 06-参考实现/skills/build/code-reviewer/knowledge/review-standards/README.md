# 代码审查标准库

## 概述

本文档是代码审查技能的核心知识库，包含编码规范检查项、OWASP Top 10 安全检查清单、性能审查要点、最佳实践检查清单和审查报告模板。为代码审查提供标准化的检查依据和评分参考。

---

## 一、编码规范检查项

### 1.1 Java 编码规范

#### 命名规范
| 检查项 | 规范 | 错误示例 | 正确示例 |
|--------|------|----------|----------|
| 类名 | PascalCase | `class userservice` | `class UserService` |
| 方法名 | camelCase | `void Getuser()` | `void getUser()` |
| 常量 | UPPER_SNAKE | `static final int MaxSize` | `static final int MAX_SIZE` |
| 变量名 | camelCase | `String UserName` | `String userName` |
| 包名 | 全小写 | `com.Example.Service` | `com.example.service` |
| 布尔变量 | is/has/can前缀 | `boolean active` | `boolean isActive` |
| 抽象类 | Abstract/Base前缀 | `class Shape` | `abstract class AbstractShape` |
| 接口 | 名词/形容词 | `interface DoSomething` | `interface Runnable` |
| 异常类 | Exception后缀 | `class AppError` | `class AppException` |
| 泛型类型 | 单大写字母/T前缀 | `class Box<Type>` | `class Box<T>` |

#### 代码结构
- 文件长度：不超过 500 行（建议 300 行以内）
- 方法长度：不超过 50 行（建议 30 行以内）
- 方法参数：不超过 5 个（超过用对象封装）
- 嵌套深度：不超过 4 层
- 圈复杂度：不超过 10

#### 注释规范
```java
/**
 * 类级别的 Javadoc 注释。
 * <p>
 * 详细描述类的用途和使用方式。
 * </p>
 *
 * @author 作者名
 * @since 版本号
 */
public class UserService {

    /**
     * 根据用户ID获取用户信息。
     *
     * @param userId 用户唯一标识，不能为空
     * @return 用户信息对象
     * @throws UserNotFoundException 用户不存在时抛出
     */
    public User getUserById(Long userId) {
        // 实现逻辑
    }
}
```

### 1.2 Python 编码规范

#### 命名规范
| 检查项 | 规范 | 错误示例 | 正确示例 |
|--------|------|----------|----------|
| 类名 | PascalCase | `class user_service` | `class UserService` |
| 函数名 | snake_case | `def GetUser()` | `def get_user()` |
| 常量 | UPPER_SNAKE | `max_size = 100` | `MAX_SIZE = 100` |
| 变量名 | snake_case | `UserName = "test"` | `user_name = "test"` |
| 模块名 | snake_case | `UserService.py` | `user_service.py` |
| 私有方法 | _前缀 | `def secret()` | `def _internal_method()` |

#### 代码结构
- 文件长度：不超过 500 行
- 函数长度：不超过 30 行
- 函数参数：不超过 5 个
- 嵌套深度：不超过 4 层
- 类方法数：不超过 20 个

#### 类型注解
```python
from typing import Optional, List

def get_users(
    page: int = 1,
    page_size: int = 20,
    keyword: Optional[str] = None
) -> List[User]:
    """获取用户列表.

    Args:
        page: 页码，从1开始
        page_size: 每页数量
        keyword: 搜索关键词

    Returns:
        用户列表

    Raises:
        ValueError: 参数不合法时
    """
    ...
```

### 1.3 JavaScript/TypeScript 编码规范

#### 命名规范
| 检查项 | 规范 | 错误示例 | 正确示例 |
|--------|------|----------|----------|
| 类名 | PascalCase | `class user_service` | `class UserService` |
| 函数名 | camelCase | `function GetUser()` | `function getUser()` |
| 常量 | UPPER_SNAKE | `const maxSize = 100` | `const MAX_SIZE = 100` |
| 变量名 | camelCase | `let UserName = "test"` | `let userName = "test"` |
| 组件名 | PascalCase | `const userCard = () => {}` | `const UserCard = () => {}` |
| Hook名 | use前缀 | `function userData()` | `function useUserData()` |
| 事件处理 | handle前缀 | `const onClick = () => {}` | `const handleClick = () => {}` |
| 布尔变量 | is/has/should | `const visible = true` | `const isVisible = true` |

#### TypeScript 特定规范
```typescript
// 使用 interface 定义对象类型
interface User {
  id: string;
  name: string;
  email: string;
}

// 使用 type 定义联合类型和工具类型
type Status = 'active' | 'inactive' | 'suspended';

// 使用 enum 定义枚举
enum UserRole {
  Admin = 'ADMIN',
  Editor = 'EDITOR',
  Viewer = 'VIEWER',
}

// 泛型使用有意义的名称
function getProperty<TObject, TKey extends keyof TObject>(
  obj: TObject,
  key: TKey
): TObject[TKey] {
  return obj[key];
}
```

### 1.4 Go 编码规范

#### 命名规范
| 检查项 | 规范 | 错误示例 | 正确示例 |
|--------|------|----------|----------|
| 导出函数 | PascalCase | `func getUser()` | `func GetUser()` |
| 未导出函数 | camelCase | `func Get_user()` | `func getUser()` |
| 接口 | -er后缀 | `interface Read` | `interface Reader` |
| 常量 | camelCase/PascalCase | `const MAX_SIZE` | `const maxSize` 或 `const MaxSize` |
| 包名 | 简短小写 | `package userService` | `package service` |
| 错误变量 | Err前缀 | `var NotFoundError` | `var ErrNotFound` |

---

## 二、OWASP Top 10 安全检查清单

### A01 - 权限控制失效
- [ ] 每个API端点是否有权限验证
- [ ] 是否存在水平越权风险（用户A访问用户B的数据）
- [ ] 是否存在垂直越权风险（普通用户执行管理员操作）
- [ ] CORS配置是否限制在必要域名
- [ ] 文件上传是否有类型和大小限制
- [ ] 目录遍历攻击防护是否到位

### A02 - 加密机制失效
- [ ] 密码是否使用强哈希算法（bcrypt/argon2/scrypt）
- [ ] 密码是否加盐
- [ ] 是否使用 HTTPS
- [ ] TLS 证书配置是否安全
- [ ] 加密算法是否为公认安全算法（AES-256/RSA-2048+）
- [ ] 密钥管理是否安全（非硬编码、使用密钥管理服务）
- [ ] 随机数是否使用安全随机源

### A03 - 注入攻击
- [ ] SQL 查询是否使用参数化查询/ORM
- [ ] 是否存在字符串拼接的SQL
- [ ] 命令执行是否经过严格过滤
- [ ] 用户输入是否经过HTML转义（防XSS）
- [ ] 是否使用模板引擎的安全模式
- [ ] XML解析是否禁用外部实体
- [ ] 文件路径输入是否经过规范化处理

### A04 - 不安全设计
- [ ] 是否有速率限制（登录、注册、API调用）
- [ ] 敏感操作是否需要二次确认
- [ ] 业务流程是否存在竞态条件
- [ ] 是否有不安全的默认配置
- [ ] 输入验证是否在服务端执行
- [ ] 数据边界检查是否到位

### A05 - 安全配置错误
- [ ] 调试模式在生产环境是否关闭
- [ ] 错误页面是否暴露堆栈信息
- [ ] 不必要的HTTP方法是否禁用
- [ ] 安全Header是否配置（CSP/HSTS/X-Frame-Options）
- [ ] 默认密码是否修改
- [ ] 示例应用是否删除

### A06 - 脆弱过时组件
- [ ] 依赖版本是否为最新稳定版
- [ ] 是否有已知漏洞的依赖（CVE检查）
- [ ] 依赖版本是否锁定（package-lock/yarn.lock/go.sum）
- [ ] 未使用的依赖是否清理

### A07 - 身份认证失败
- [ ] 密码策略是否合理（长度/复杂度/历史）
- [ ] 是否有暴力破解防护（锁定/延迟/验证码）
- [ ] Session管理是否安全（超时/再生/httponly）
- [ ] JWT实现是否安全（算法/密钥/过期）
- [ ] 登出是否彻底（Token失效/Session销毁）
- [ ] 是否有密码重置安全机制

### A08 - 数据完整性失效
- [ ] 反序列化是否使用白名单
- [ ] 是否验证外部数据的完整性签名
- [ ] CI/CD管道是否有安全检查
- [ ] 自动更新是否有签名验证

### A09 - 日志监控不足
- [ ] 登录成功/失败是否有日志
- [ ] 权限变更是否有日志
- [ ] 敏感数据访问是否有日志
- [ ] 日志中是否过滤了敏感信息
- [ ] 异常是否被正确记录
- [ ] 日志是否有防篡改保护

### A10 - 服务端请求伪造（SSRF）
- [ ] URL输入是否经过白名单验证
- [ ] 是否禁止访问内网地址
- [ ] HTTP客户端是否限制重定向
- [ ] DNS解析是否有缓存投毒防护

---

## 三、性能审查要点

### 3.1 算法复杂度

| 场景 | 问题 | 建议 |
|------|------|------|
| 多层嵌套循环 | O(n^2) 及以上 | 考虑使用哈希表、排序后双指针等优化 |
| 频繁的字符串拼接 | 每次创建新对象 | 使用 StringBuilder/StringBuffer/Buffer |
| 全量数据加载 | 内存溢出风险 | 分页/流式处理/懒加载 |
| 递归无终止条件 | 栈溢出 | 改为迭代或增加终止条件 |
| 不必要的排序 | O(n log n) 开销 | 仅在需要时排序 |

### 3.2 数据库性能

| 场景 | 问题 | 建议 |
|------|------|------|
| 循环内查询 | N+1 问题 | 批量查询/JOIN/IN 查询 |
| SELECT * | 不必要的数据传输 | 明确指定需要的字段 |
| 缺少索引 | 全表扫描 | 为查询条件添加索引 |
| 大事务 | 锁竞争 | 缩小事务范围 |
| 无分页 | 内存溢出 | 添加 LIMIT/OFFSET |
| 频繁的连接创建 | 连接开销 | 使用连接池 |

### 3.3 内存管理

| 场景 | 问题 | 建议 |
|------|------|------|
| 资源未关闭 | 内存泄漏 | 使用 try-with-resources/using/context manager |
| 无限增长的缓存 | OOM | 设置容量上限和过期策略 |
| 大对象频繁创建 | GC 压力 | 对象池/复用/延迟初始化 |
| 不必要的深拷贝 | 性能浪费 | 浅拷贝或不可变对象 |

### 3.4 并发性能

| 场景 | 问题 | 建议 |
|------|------|------|
| 过粗的锁粒度 | 串行化 | 缩小锁范围/读写锁/无锁设计 |
| 死锁风险 | 系统挂起 | 统一锁顺序/超时机制 |
| 线程池过小 | 吞吐量低 | 根据任务类型调整线程数 |
| 阻塞操作 | 资源浪费 | 使用异步/非阻塞 I/O |

---

## 四、最佳实践检查清单

### 4.1 错误处理

```java
// 反模式：空catch
try {
    // 操作
} catch (Exception e) {
    // 什么都不做
}

// 正确做法：记录日志并适当处理
try {
    // 操作
} catch (SpecificException e) {
    logger.error("操作失败: {}", e.getMessage(), e);
    throw new BusinessException("操作失败", e);
}
```

### 4.2 SOLID 原则速查

| 原则 | 检查要点 | 违反迹象 |
|------|----------|----------|
| SRP | 类是否只有一个变更原因 | 一个类超过300行/10个以上方法 |
| OCP | 是否通过扩展添加功能 | 修改现有代码才能添加功能 |
| LSP | 子类是否能替换父类 | 子类抛出父类没有的异常 |
| ISP | 接口是否精简 | 实现类有空方法 |
| DIP | 是否依赖抽象 | 直接 new 具体实现 |

### 4.3 可维护性检查

| 检查项 | 阈值 | 超出建议 |
|--------|------|----------|
| 方法行数 | 30 行 | 拆分为多个私有方法 |
| 类行数 | 300 行 | 考虑拆分职责 |
| 参数个数 | 5 个 | 封装为参数对象 |
| 嵌套层数 | 4 层 | 提取方法/卫语句 |
| 圈复杂度 | 10 | 简化条件/策略模式 |
| 魔法数字 | 0 个 | 提取为命名常量 |

### 4.4 代码重复检查
- 复制粘贴超过 6 行的代码块
- 相同逻辑在多处出现
- 可提取为公共方法/工具类的重复代码

---

## 五、审查报告模板

见 `workflows/code-review.md` Step 5 的报告模板。

### 问题等级快速参考

| 等级 | 标识 | 示例 |
|------|------|------|
| S1-致命 | 红色标记 | SQL注入、硬编码密钥、越权漏洞 |
| S2-严重 | 橙色标记 | N+1查询、资源未关闭、弱密码哈希 |
| S3-一般 | 黄色标记 | 命名不规范、缺少注释、过长方法 |
| S4-建议 | 蓝色标记 | 可用设计模式优化、魔法数字提取 |

### 审查通过标准

| 指标 | 标准 |
|------|------|
| S1 问题数 | 0（必须为0才能通过） |
| S2 问题数 | 0（建议为0，最多允许2个有明确修复计划） |
| S3 问题数 | 不超过10个 |
| 代码覆盖率 | 核心逻辑 >= 80% |
