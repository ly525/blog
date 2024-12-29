# uni-app

| API | 场景 | 源码解读 | 经验 |
| --- | --- | --- | --- |
| uni.getLocation | 获取定位 | [H5 ✅](https://github.com/ly525/uni-app/blob/next/packages/uni-h5/src/service/api/location/getLocation.ts) |--- |
| uni.redirectTo | 页面跳转 | 未解读 | [#](#uniredirectto) |
| uni.getSystemInfo | 获取系统信息 | 未解读 |--- |
| uni.getSystemInfoSync | 获取系统信息 | 未解读 |--- |
| uni.getSystemInfo | 获取系统信息 | 未解读 |--- |


#### uni.redirectTo
1. A -> B -> C, C返回希望直接到A，B是一个中间页面，可以理解为 closeAndNavigateTo
  - 专线帮小程序使用

<script setup>
import useCompStore from '@store/copname.js'
import { onMounted } from 'vue'
const compStore =useCompStore()

onMounted(()=>{
  compStore.updateName('')
})

</script>