<template>
  <Layout>
    <template #aside-outline-before>
      <div class="blog-iframe" :style="iframeStyle" v-if="compStore.currentName">
        <iframe
          width="100%"
          height="100%"
          frameborder="0"
          :src="iframeSrc"
        />
      </div>
    </template>
  </Layout>
</template>

<script setup>
import useCompStore from '@store/copname.js'
import DefaultTheme from 'vitepress/theme'
import { computed, onMounted, ref } from 'vue'

const { Layout } = DefaultTheme
const compStore = useCompStore()

const iframeSrc = computed(() => {
  let src = 'http://localhost:7777/#/pages/tab-items-0/demo/'
  if (compStore.currentName) {
    // src += '#' + compStore.currentName
    src += compStore.currentName
  }
  return src
})

const firstScreenWidth = ref(null)
const screenWidth = ref(null)
const differenceWidth = ref(0)

onMounted(() => {
  screenWidth.value = document.body.clientWidth
  firstScreenWidth.value = document.body.clientWidth
  window.onresize = () => {
    // 屏幕尺寸变化
    return (() => {
      screenWidth.value = document.body.clientWidth
      differenceWidth.value = firstScreenWidth.value - screenWidth.value
    })()
  }
})

const iframeStyle = computed(() => {
  console.log(differenceWidth.value)
  const rightValue = `cale(20% - ${differenceWidth.value}px)`
  return {
    right: rightValue
  }
})

</script>

<style lang="scss" scoped>
.blog-iframe {
  position: fixed;
  z-index: 9999;
  top: 15%;
  // width: 375px;
  width: 320px;
  height: 667px;
  border: 1px solid #eee;
  border-radius: 8px;
  overflow: hidden;
  right: 20px;
}
</style>
