import DefaultTheme from 'vitepress/theme'
import './styles/vars.css'
import './styles/style.css'
import { createPinia } from 'pinia'
import CodeSimulator from './components/CodeSimulator.vue'
import MobilePreview from './components/MobilePreview/index.vue'

const store = createPinia()

export default {
  ...DefaultTheme,
  Layout: MobilePreview,
  enhanceApp({ app }) {
    app.use(store)
    app.component('CodeSimulator', CodeSimulator)
  },
}