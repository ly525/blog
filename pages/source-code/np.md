# NP

> JavaScript 精确执行加、减、乘、除等运算。
- [number-precision，简称：NP](https://github.com/nefe/number-precision)，precision: 精度
- [查看 源码解读 ✅](https://github.com/ly525/number-precision)

```js
### 1. 为什么要统一技术选型？
1. 把一个吃透,汇聚经验，形成最佳实践
2. 目标：统一各业务线 `JS浮点数运算` 的技术选型 + 最佳实践

### 2. 为什么是 NP？
1. 小：1KB（GZIP 之后）
2. 代码量少：170行左右
3. **团队大部分人都看过源码，有不支持的API，可以快速fork进行二开**
4. **单元测试充分，覆盖了大部分场景**
```

###  业务使用场景

| 端 | 场景  | 经验 | 
| --- | --- | --- | 
| 蓝桥App | 多品名金额、重点计算 | `NP.plus.apply(NP, [1,2,3]) => 6` |


###  技巧/最佳实践
| 更多技巧 |  代码 |  经验 |
| --- | --- | ---- |
| 多数字 | `NP.plus.apply(NP, [1,2,3]) => 6` | ---- |
| 多数字 | `NP.plus.apply(NP, array.filter(i => !!i)) => 6` | 只支持 Number/String |
| 多数字 | `NP.plus.apply(NP, [1,2,3, null, undefined].filter(i => !!i)) => 6` | ---- |


