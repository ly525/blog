import path from 'path';
import previewContainer from "./previewContainer";

// console.log(__dirname, '__dirname') // .vitepress

export default {
  title: '小小鲁班的随笔集',
  base: '/blog/',
  outDir: './dist',
  lastUpdated: true,
  themeConfig: {
    logo: 'https://gitee.com/monsterwx/blog/raw/master/docs/logo.png',
    search: {
      provider: 'local'
    },
    docsDir: './',
    outline: false, // 大纲
    socialLinks: [
      { icon: 'github', link: 'https://github.com/ly525/blog' },
    ],
    footer: {
      // message: '随笔集集',
      copyright: 'Copyright © 2022-present 小小鲁班'
    },
    nav: [
      { text: '解决方案', link: '/pages/solution/', activeMatch: '/pages/solution/' },
      { text: '源码系列', link: '/pages/source-code/uni-app', activeMatch: '/pages/source-code/' },
      { text: '专题', 
        items: [
          { text: '开发环境', link: '/pages/spec/dev-environment' },
          { text: '日常工具', link: '/pages/spec/daily-tools' },
          { text: '框架', link: '/pages/spec/framework' },
          { text: '组件库', link: '/pages/spec/component-library' },
          { text: '工程化', link: '/pages/spec/engineering' },
          { text: '发布/部署', link: '/pages/spec/deployment' },
          { text: '稳定性', link: '/pages/spec/stability' },
          { text: '监控/埋点', link: '/pages/spec/monitoring' },
          { text: '地图', link: '/pages/spec/map' },
          { text: '请求', link: '/pages/spec/request' },
          { text: 'CSS', link: '/pages/spec/request' }
        ]

       },
    ],
    sidebar: {
      '/pages/guide/': [
        {
          text: '指南',
          items: [
            { text: '安装', link: '/pages/guide/installation' },
            { text: '快速开始', link: '/pages/guide/quickStart' },
            { text: '更新日志', link: '/pages/guide/CHANGELOG' }
          ]
        }
      ],
      '/pages/spec/': [
        {
          text: '专题',
          items: [
            { text: '安装', link: '/pages/spec/index' },
          ]
        }
      ],
      '/pages/source-code/': [
        {
          text: '源码系列',
          items: [
            { text: 'uni-app', link: '/pages/source-code/uni-app' },
            { text: 'np', link: '/pages/source-code/np' }
          ]
        }
      ],
    },
    
  },
  markdown: {
    config: (md) => {
      previewContainer(md);
    }
  },
  vite: {
    resolve: {
      alias: {
        '@store': path.resolve(__dirname, 'theme/components/MobilePreview/store'),
      },
    },
  }
}