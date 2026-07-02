# 性能测试模式库

## 一、压测场景分类

### 1. 基准测试（Baseline Test）

**目的**：确认系统在最低负载下的基础性能水平，建立性能基线。

**配置参数**：
- 并发用户数：1-5
- 持续时间：5-10 分钟
- 预热时间：2 分钟
- Ramp-up：立即

**预期产出**：
- 单用户响应时间基线
- 无并发情况下的 TPS
- 系统资源空闲水位

### 2. 负载测试（Load Test）

**目的**：验证系统在预期负载下的表现是否满足性能需求。

**配置参数**：
- 并发用户数：目标并发数 x 80% → 100% → 120%
- 持续时间：15-30 分钟/阶梯
- 预热时间：3-5 分钟
- Ramp-up：每阶梯 1-2 分钟

**预期产出**：
- 各阶梯 TPS / RT / 错误率
- 资源利用率变化曲线
- 性能拐点初步判断

### 3. 压力测试（Stress Test）

**目的**：找到系统的性能极限和崩溃点。

**配置参数**：
- 并发用户数：目标并发数 x 150% → 200% → 300%（逐步加压）
- 持续时间：10-15 分钟/阶梯
- 预热时间：3 分钟
- Ramp-up：每阶梯 2-3 分钟

**预期产出**：
- 系统最大 TPS
- 系统崩溃点（错误率飙升/响应时间急剧恶化）
- 崩溃后的恢复能力评估

### 4. 稳定性测试（Endurance Test）

**目的**：验证系统在长时间运行下的稳定性，检测内存泄漏等隐患。

**配置参数**：
- 并发用户数：目标并发数 x 80-100%
- 持续时间：2-24 小时
- 预热时间：5 分钟
- Ramp-up：5-10 分钟

**预期产出**：
- TPS 趋势图（是否衰减）
- 内存使用趋势图（是否持续增长）
- GC 频率/时长趋势
- 数据库连接池状态

### 5. 容量测试（Capacity Test）

**目的**：确定系统在满足性能指标前提下的最大承载能力。

**配置参数**：
- 并发用户数：从目标并发数开始，逐步增加至性能指标不满足
- 持续时间：10 分钟/阶梯
- 判定标准：RT 超标 或 错误率超标

**预期产出**：
- 系统最大安全并发数
- 系统最大安全 TPS
- 资源瓶颈组件
- 扩容建议

---

## 二、JMeter 脚本模板

### HTTP 请求模板

```xml
<?xml version="1.0" encoding="UTF-8"?>
<jmeterTestPlan version="1.2" properties="5.0">
  <hashTree>
    <TestPlan guiclass="TestPlanGui" testclass="TestPlan" testname="性能测试计划">
      <elementProp name="TestPlan.user_defined_variables" elementType="Arguments">
        <collectionProp name="Arguments.arguments">
          <elementProp name="BASE_URL" elementType="Argument">
            <stringProp name="Argument.value">http://target-server:8080</stringProp>
          </elementProp>
        </collectionProp>
      </elementProp>
    </TestPlan>
    <hashTree>
      <ThreadGroup guiclass="ThreadGroupGui" testclass="ThreadGroup" testname="负载测试线程组">
        <intProp name="ThreadGroup.num_threads">${__P(threads,100)}</intProp>
        <intProp name="ThreadGroup.ramp_time">${__P(rampup,60)}</intProp>
        <boolProp name="ThreadGroup.same_user_on_next_iteration">true</boolProp>
        <stringProp name="ThreadGroup.on_sample_error">continue</stringProp>
        <elementProp name="ThreadGroup.main_controller" elementType="LoopController">
          <boolProp name="LoopController.continue_forever">false</boolProp>
          <stringProp name="LoopController.loops">${__P(loops,-1)}</stringProp>
        </elementProp>
        <boolProp name="ThreadGroup.scheduler">true</boolProp>
        <stringProp name="ThreadGroup.duration">${__P(duration,600)}</stringProp>
        <stringProp name="ThreadGroup.delay">${__P(delay,0)}</stringProp>
      </ThreadGroup>
      <hashTree>
        <HTTPSamplerProxy guiclass="HttpTestSampleGui" testclass="HTTPSamplerProxy" testname="API请求">
          <stringProp name="HTTPSampler.domain">${BASE_URL}</stringProp>
          <stringProp name="HTTPSampler.port"></stringProp>
          <stringProp name="HTTPSampler.protocol">http</stringProp>
          <stringProp name="HTTPSampler.contentEncoding">UTF-8</stringProp>
          <stringProp name="HTTPSampler.path">/api/v1/resource</stringProp>
          <stringProp name="HTTPSampler.method">POST</stringProp>
          <boolProp name="HTTPSampler.use_keepalive">true</boolProp>
          <boolProp name="HTTPSampler.follow_redirects">true</boolProp>
        </HTTPSamplerProxy>
        <hashTree>
          <HeaderManager guiclass="HeaderPanel" testclass="HeaderManager" testname="HTTP头">
            <collectionProp name="HeaderManager.headers">
              <elementProp name="Content-Type" elementType="Header">
                <stringProp name="Header.name">Content-Type</stringProp>
                <stringProp name="Header.value">application/json</stringProp>
              </elementProp>
              <elementProp name="Authorization" elementType="Header">
                <stringProp name="Header.name">Authorization</stringProp>
                <stringProp name="Header.value">Bearer ${__P(token,)}</stringProp>
              </elementProp>
            </collectionProp>
          </HeaderManager>
          <ResponseAssertion guiclass="AssertionGui" testclass="ResponseAssertion" testname="响应断言">
            <collectionProp name="Asserion.test_strings">
              <stringProp name="49586">200</stringProp>
            </collectionProp>
            <intProp name="Assertion.test_type">8</intProp>
            <stringProp name="Assertion.test_field">Assertion.response_code</stringProp>
          </ResponseAssertion>
          <JSONPostProcessor guiclass="JSONPostProcessorGui" testclass="JSONPostProcessor" testname="JSON提取">
            <stringProp name="JSONPostProcessor.referenceNames">tokenId</stringProp>
            <stringProp name="JSONPostProcessor.jsonPathExprs">$.data.token</stringProp>
            <stringProp name="JSONPostProcessor.match_numbers">1</stringProp>
          </JSONPostProcessor>
        </hashTree>
        <CSVDataSet guiclass="TestBeanGUI" testclass="CSVDataSet" testname="参数化数据">
          <stringProp name="filename">data/test-data.csv</stringProp>
          <stringProp name="variableNames">userId,userName,amount</stringProp>
          <stringProp name="delimiter">,</stringProp>
          <boolProp name="quotedData">true</boolProp>
          <boolProp name="recycle">true</boolProp>
          <boolProp name="stopThread">false</boolProp>
          <stringProp name="shareMode">shareMode.all</stringProp>
        </CSVDataSet>
        <ResultCollector guiclass="StatVisualizer" testclass="ResultCollector" testname="聚合报告">
          <boolProp name="ResultCollector.error_logging">false</boolProp>
          <objProp>
            <value class="SampleSaveConfiguration">
              <time>true</time>
              <latency>true</latency>
              <timestamp>true</timestamp>
              <success>true</success>
              <responseCode>true</responseCode>
            </value>
          </objProp>
          <stringProp name="filename">results/aggregate-report.csv</stringProp>
        </ResultCollector>
      </hashTree>
    </hashTree>
  </hashTree>
</jmeterTestPlan>
```

### API 链路模板（多步骤事务）

关键要素：
- 使用「事务控制器」包裹多步骤请求
- 正则/JSON 提取器做参数关联
- 每步骤单独断言

### 数据库压测模板（JDBC）

关键要素：
- JDBC Connection Configuration 配置连接池
- JDBC Request 执行 SQL
- 参数化 SQL 语句
- 连接池大小与并发线程数匹配

---

## 三、监控指标清单

### 系统层指标

| 指标 | 采集方式 | 告警阈值 | 说明 |
|------|----------|----------|------|
| CPU 使用率 | top / vmstat / Prometheus | > 80% | 区分用户态/内核态 |
| 内存使用率 | free / Prometheus | > 80% | 关注 Available 而非 Free |
| 磁盘 IO 使用率 | iostat -x | > 80% | 关注 await（IO 等待时间） |
| 磁盘 IO 吞吐 | iostat | 视磁盘规格 | 读写 MB/s |
| 网络 IO 带宽 | iftop / nload | > 70% | 入站/出站分别监控 |
| 网络连接数 | netstat / ss | 接近 ulimit | TIME_WAIT 数量 |
| 系统负载 | uptime | > CPU 核数 x 0.7 | 1min/5min/15min 负载 |

### 应用层指标（Java/JVM 为例）

| 指标 | 采集方式 | 告警阈值 | 说明 |
|------|----------|----------|------|
| GC 频率 | jstat / APM | Young GC > 1次/s | 影响 STW 停顿时间 |
| GC 耗时 | GC 日志 / APM | Full GC > 1s | 长停顿影响响应时间 |
| 堆内存使用 | JMX / APM | > 80% | 老年代使用率 |
| 线程数 | JMX / APM | 接近线程池上限 | BLOCKED/WAITING 比例 |
| 连接池使用率 | HikariCP Metrics | > 80% | 活跃连接/最大连接 |
| 请求队列长度 | Tomcat/Metrics | 持续增长 | 排队请求积压 |
| HTTP 状态码分布 | Access Log / APM | 5xx > 1% | 错误率监控 |

### 中间件层指标

**Redis**：
| 指标 | 告警阈值 |
|------|----------|
| 内存使用率 | > 80% |
| 缓存命中率 | < 90% |
| 连接数 | 接近 maxclients |
| 慢查询（>10ms） | 数量增长 |
| 键过期淘汰 | evicted keys > 0 |

**消息队列（RabbitMQ/Kafka）**：
| 指标 | 告警阈值 |
|------|----------|
| 消息堆积量 | 持续增长 |
| 消费延迟 | > 预期延迟 |
| 生产 TPS | 低于预期 |
| 消费 TPS | 低于生产 TPS |

**Nginx**：
| 指标 | 告警阈值 |
|------|----------|
| 活跃连接数 | 接近 worker_connections |
| 请求处理速率 | 下降趋势 |
| 4xx/5xx 比率 | > 1% |

### 数据库层指标

| 指标 | 采集方式 | 告警阈值 | 说明 |
|------|----------|----------|------|
| 慢查询数量 | slow_query_log | 增长趋势 | > 100ms 为慢查询 |
| 活跃连接数 | SHOW PROCESSLIST | > max_connections x 80% | |
| QPS/TPS | SHOW STATUS | 基线对比 | 每秒查询/事务数 |
| 缓冲池命中率 | SHOW STATUS | < 95% | InnoDB Buffer Pool |
| 锁等待次数 | SHOW STATUS | 持续增长 | InnoDB row lock waits |
| 死锁次数 | SHOW ENGINE INNODB | > 0 | 需要立即处理 |
| 临时表创建数 | SHOW STATUS | 过多 | 可能需要优化 SQL |

---

## 四、性能报告模板

### 报告结构

```
1. 测试概述
   1.1 测试目的
   1.2 测试范围
   1.3 测试环境
   1.4 测试工具与版本
   1.5 测试时间

2. 测试场景与配置
   2.1 场景清单
   2.2 各场景配置参数
   2.3 测试数据说明

3. 测试结果
   3.1 结果汇总表
   | 场景 | 目标TPS | 实际TPS | 目标RT(P99) | 实际RT(P99) | 错误率 | 结果 |
   |------|---------|---------|-------------|-------------|--------|------|
   | 基准 | -       | XXX     | -           | XX ms       | 0%     | PASS |
   | 负载 | 1000    | XXX     | 500ms       | XX ms       | 0.01%  | PASS |
   | 压力 | -       | XXX     | -           | XX ms       | 2.3%   | FAIL |
   | 稳定性 | 800   | XXX     | 500ms       | XX ms       | 0.02%  | PASS |

   3.2 性能曲线图
       - TPS 随并发数变化趋势
       - 响应时间随并发数变化趋势
       - 错误率随并发数变化趋势
   3.3 资源利用率统计

4. 瓶颈分析
   4.1 瓶颈组件定位
   4.2 根因分析
   4.3 性能拐点分析

5. 优化建议
   5.1 短期优化（配置调整）
   5.2 中期优化（代码/SQL优化）
   5.3 长期优化（架构调整）

6. 结论与建议
   6.1 通过/不通过判定
   6.2 风险提示
   6.3 下一步计划
```

### 通过/不通过判定标准

| 判定维度 | 通过标准 | 不通过标准 |
|----------|----------|------------|
| TPS | 实际 >= 目标 x 100% | 实际 < 目标 x 100% |
| 响应时间 | P99 <= 目标值 | P99 > 目标值 |
| 错误率 | <= 0.1% | > 0.1% |
| CPU 利用率 | <= 80% | > 80% |
| 内存利用率 | <= 80% | > 80% |
| 稳定性 | 24h 无衰减 | TPS 衰减 > 10% |
| 内存泄漏 | 无 | 内存持续增长 |

**综合判定**：
- 所有维度通过 → 总体通过
- 任一维度不通过 → 总体不通过，需附优化计划

---

## 五、常见瓶颈定位方法

### CPU 瓶颈

**现象**：CPU 使用率 > 80%，响应时间随并发增加而线性增长

**定位方法**：
1. `top -H -p <pid>` 找到高 CPU 线程
2. `jstack <pid>` 查看线程堆栈，定位热点方法
3. 火焰图（Flame Graph）分析 CPU 采样
4. APM 工具查看方法级耗时

**常见原因**：复杂计算、正则表达式、序列化/反序列化、频繁 GC

### 内存瓶颈

**现象**：内存持续增长，GC 频率/时长增加，Full GC 频发

**定位方法**：
1. `jstat -gcutil <pid> 1000` 观察 GC 统计
2. `jmap -histo:live <pid>` 查看对象分布
3. Heap Dump 分析（MAT/JProfiler）
4. 监控 Old Gen 使用趋势

**常见原因**：内存泄漏、缓存无限增长、大对象未释放、ThreadLocal 泄漏

### IO 瓶颈

**现象**：磁盘 await > 10ms，网络带宽打满

**定位方法**：
1. `iostat -x 1` 查看磁盘 IO 详情
2. `iotop` 找到高 IO 进程
3. 网络抓包分析延迟
4. 日志异步化检查

**常见原因**：日志写入过频、数据库 IO 过高、文件读写未缓冲、网络带宽不足

### 数据库瓶颈

**现象**：慢查询增多，连接池耗尽，TPS 上不去

**定位方法**：
1. 慢查询日志分析（EXPLAIN 执行计划）
2. `SHOW PROCESSLIST` 查看活跃连接
3. `SHOW ENGINE INNODB STATUS` 查看 InnoDB 状态
4. 索引命中率分析

**常见原因**：缺失索引、SQL 未优化、锁竞争、连接池配置过小、全表扫描

### 中间件瓶颈

**现象**：缓存命中率下降、消息堆积、连接数不足

**定位方法**：
1. Redis: `INFO` 命令查看统计信息
2. MQ: 管理后台查看消费滞后
3. 连接池: 监控活跃连接/空闲连接比率

**常见原因**：缓存 key 设计不合理、热 key、大 key、消费者处理慢、连接池配置过小
