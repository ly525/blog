<script>
import Popover from './Popover.vue'
import { h } from 'vue'

const appRedirectKeyword = 'appRedirect'
let imageIndex = 0

function createSVG(h) {
  return h(
    'svg',
    {
      class: 'app-redirect-icon',
      style: {
        width: '26px',
        height: '26px',
      },
      attrs: {
        t: Date.now(),
        viewBox: '0 0 1024 1024',
        version: '1.1',
        xmlns: 'http://www.w3.org/2000/svg',
      },
    },
    [
      h('path', {
        attrs: {
          d: 'M597.333333 597.333333h85.333334v-85.333333h85.333333v128h-85.333333v42.666667h-85.333334v-42.666667h-85.333333v-128h85.333333v85.333333z m-384-85.333333h256v256H213.333333v-256z m85.333334 85.333333v85.333334h85.333333v-85.333334H298.666667zM213.333333 213.333333h256v256H213.333333V213.333333z m85.333334 85.333334v85.333333h85.333333V298.666667H298.666667z m213.333333-85.333334h256v256h-256V213.333333z m85.333333 85.333334v85.333333h85.333334V298.666667h-85.333334z m85.333334 384h85.333333v85.333333h-85.333333v-85.333333z m-170.666667 0h85.333333v85.333333h-85.333333v-85.333333z',
          fill: '#aaa',
        },
      }),
    ]
  )
}

function getSlots() {
    const slots = this.$slots.default ? this.$slots.default() : []
    debugger
    return slots
}

export default {
  components: { Popover },
  props: {
    src: {
      type: String,
      default: '',
    },
  },
  data() {
    return {
      activeIndex: 0,
      appRedirectSrc: '',
      qrCodeImageClass: `qrcode-img_${++imageIndex}`,
      qrCodeImageParentDisplay: 'none',
      firstRender: true,
    }
  },
  mounted() {
    debugger
    // this.$copyUpdates && this.$copyUpdates()
    this.onWindowResize()
    this.qrCodeImage = document.querySelector(`img.${this.qrCodeImageClass}`)
    if (this.qrCodeImage) {
      this.qrCodeImageContainer = this.qrCodeImage.parentElement
    }
    window.addEventListener('resize', this.onWindowResize)
  },
  beforeDestroy() {
    window.removeEventListener('resize', this.onWindowResize)
  },
  methods: {
    onWindowResize() {
    //   const contentWidth = getComputedStyle(document.querySelector('.theme-default-content')).width
    //   if (window.matchMedia('(max-width: 410px)').matches) {
    //     this.$refs.codeIframe && (this.$refs.codeIframe.style.maxWidth = contentWidth)
    //   }
    },
    onClick(index) {
        console.log(index, 'onclick')
      this.activeIndex = index
    },
    createQRCodeSVG(h) {
      if (this.appRedirectSrc) {
        return h(
          'a',
          {
            style: { 'margin-top': '16px', display: 'inline-block', 'text-decoration': 'none' },
            attrs: { href: this.appRedirectSrc, target: '_blank' },
          },
          [
            h('Popover', {
              on: {
                show: () => {
                  if (this.appRedirectSrc) {
                    if (!this.qrCodeImage.src) {
                      import('qr-code-with-logo').then(({ default: QrCodeWithLogo }) => {
                        QrCodeWithLogo.toImage({
                          image: this.qrCodeImage,
                          content: this.appRedirectSrc,
                          width: 256,
                          nodeQrCodeOptions: {
                            margin: 2,
                          },
                        })
                      })
                    }
                  }
                },
              },
              scopedSlots: {
                reference: props =>
                  h(
                    'div',
                    {
                      class: 'qr-code-button',
                      style: {
                        display: 'flex',
                        'justify-content': 'center',
                        'align-items': 'center',
                        background: '#f7f8f9',
                        color: '#666',
                        padding: '0 6px',
                        'border-radius': '16px',
                        'font-size': '14px',
                      },
                    },
                    [createSVG(h), h('span', null, ' 扫码体验（手机浏览器跳转到App直达页）')]
                  ),
                default: props =>
                  h(
                    'div',
                    {
                      style: {
                        display: 'flex',
                        width: '150px',
                        height: '170px',
                        'flex-direction': 'column',
                        'justify-content': 'center',
                        'align-items': 'center',
                      },
                    },
                    [
                      h('img', {
                        class: this.qrCodeImageClass,
                        style: {
                          width: '150px',
                          height: '150px',
                          'max-width': 'unset !important',
                        },
                      }),
                      h('span', { style: { 'font-weight': 'bold' } }, '扫码体验'),
                    ]
                  ),
              },
            }),
          ]
        )
      }
    },
    wrapHeader(h, node) {
      let headerDom = []
      node.forEach((v, index) => {
        console.log(index, 'wrapHeader')
        headerDom.push(
          h(
            'p',
            {
              class: `pages-tabs-header-text ${this.activeIndex === index ? 'pages-tabs--active' : ''}`,
              onClick: () => {
                console.log(index, 'click')
                this.onClick(index)
              },
            },
            v.title
          )
        )
      })
      return this.renderDom(
        h,
        h('div', { class: 'page-tabs' }, [
          h('div', { class: 'pages-tabs-header' }, headerDom),
          h('div', { class: 'page-snippet-code', key: this.activeIndex }, [node[this.activeIndex].node]),
        ])
      )
    },
    renderDom(h, node) {
      return h('div', { class: 'page-runtime', style: { position: 'relative' } }, [
        h('div', { class: 'page-snippet', style: { height: this.src ? '667px' : 'auto' } }, [node]),
        h('div', { class: 'code-content', style: { display: this.src ? 'block' : 'none' } }, [
          h('iframe', {
            class: 'code-iframe',
            src: this.src,
            frameborder: '0',
            allow: 'geolocation https://hellouniappx.dcloud.net.cn',
            ref: 'codeIframe',
          }),
        ]),
      ])
    },
  },
  render() {
    console.log('----->>', this.src)
    const columns = getSlots.apply(this)
    debugger
    let boxObj = []
    let realDom = []
    columns.forEach((v, i) => {
      if (v.type && v.children) {
        realDom.push(v)
      }
    })
    for (let index = 0; index < realDom.length; index++) {
      const vnode = realDom[index]
    //   let code = vnode.children[0]
      let code = vnode.children.find(item => item.type === 'pre')

    //   if (vnode.type === 'blockquote' && code.type === 'p' && this.firstRender) {
    //     // const pFirstChild = code.children[0]
    //     const pFirstChild = code.children
    //     if (pFirstChild) {
    //     //   const text = pFirstChild.text
    //       const text = pFirstChild
    //       if (text && text.trim().indexOf(appRedirectKeyword) === 0) {
    //         this.appRedirectSrc = text.trim().split(' ')[1] || ''
    //         realDom.splice(index, 1)
    //         getSlots.apply(this).splice(index, 1)
    //         index--
    //         continue
    //       }
    //     }

    //     if (vnode.type === 'blockquote') {
    //         // let text = textDom.children[0]
    //         let p = vnode.children[0]
    //         boxObj.push({
    //           title: p.text ? p.text : 'title',
    //           node: vnode,
    //         })
    //       }
    //   }

      if (vnode.type === 'div' && code.type === 'pre') {
        let i = index - 1
        if (i >= 0) {
          let textDom = realDom[i]
          if (textDom.type === 'blockquote') {
            let text = textDom.children[0]
            // let p = text.children[0]
            boxObj.push({
              title: text.children ? text.children : 'title',
              node: vnode,
            })
          }
        }
      }
    }
    this.firstRender = false
    const appRedirectQrCode = this.createQRCodeSVG(h)
    if (boxObj.length > 0) {
      return h('div', null, [appRedirectQrCode, this.wrapHeader(h, boxObj)])
    } else {
      if (this.src) {
        return h('div', null, [appRedirectQrCode, this.renderDom(h, getSlots.apply(this))])
      } else {
        return h('div', null, [appRedirectQrCode, getSlots.apply(this)])
      }
    }
  },
}
</script>

<style lang="stylus" scoped>
.page-runtime {
	display: flex;
	max-height: 667px;
	border: 1px #eee solid;
	margin-top: 16px;
}
.page-snippet {
	width: 100%;
	overflow: hidden;
}
.page-snippet-code {
	height: calc(100%  - 44px)
}

.page-tabs {
	height: 100%;
	box-sizing: border-box;
}
.pages-tabs-header {
	display: flex;
	height: 44px;
	background-color: #222;
	align-items: center;
}
.pages-tabs-header-text {
	margin: 0 0 0 8px;
	padding: 4px 8px;
	border-radius: 5px;
	font-size: 16px;
	color: #eee;
	background:transparent;
	cursor: pointer;
	-moz-user-select:none; /*火狐*/
	-webkit-user-select:none; /*webkit浏览器*/
	-ms-user-select:none; /*IE10*/
	-khtml-user-select:none; /*早期浏览器*/
	user-select:none;
}
.pages-tabs-header-text:hover {
	background: #454545;
}
.pages-tabs--active {
	// background:#282c34;
	background-color: #3b3b3b;
	color: #fff;
	// font-weight: bold;
}

.page-snippet div[class*="language-"]{
	width: 100%;
	height: 100%;
	border-radius: 0;
	overflow: auto;

}
.page-snippet pre[class*="language-"]{
	margin: 0;
	padding: 20px 20px;
	width: 100%;
	height: 100%;
	// overflow: auto;
	box-sizing: border-box;
}
.code-iframe {
	flex-shrink: 0;
	width: 375px;
	height: 667px;
}

@media (max-width: $MQMobileNarrow)
	{$contentClass}
    div[class*="language-"]
			margin 0 !important


::-webkit-scrollbar {
	width: 8px !important;
	height: 8px !important;
	background: transparent;
	filter: invert();
}
::-webkit-scrollbar:hover {
	background: rgba(128, 128, 128, 0.2);
}
::-webkit-scrollbar-thumb {
	border: 1px solid rgba(255, 255, 255, 0.4) !important;
	background-color: rgba(0, 0, 0, 0.4) !important;
	z-index: 2147483647;
	-webkit-border-radius: 12px;
	background-clip: content-box;
}
::-webkit-scrollbar-corner {
	background: rgba(255, 255, 255, 0.3);
	border: 1px solid transparent;
}
::-webkit-scrollbar-thumb:hover {
	background-color: rgba(0, 0, 0, 0.8) !important;
}
::-webkit-scrollbar-thumb:active {
	background-color: rgba(0, 0, 0, 0.6) !important;
}
</style>