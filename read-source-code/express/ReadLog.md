lib/express.js / 2017-10-03
====================
	
  * mixin(dist, src)
    - 将src的属性copy到dist上
    - 类似于vuejs中两个options的merge
    - 涉及
        - 1. Object.create()
        - 2. mdn中关于Object的继承的实现(使用Object.create()实现), 以及关于es6中super()的实现原理
        - 3. copy属性的实现思路
        - 4. prototype的利用
        - 5. 判断对象自有属性的具体应用(hasOwnProperty)
        - 6. 之前看的Node.js文档，并参与nodejs.cn的翻译中关于EventEmitter在此刻有了回报.帮助自己理解EventEmitter
        - 7. 

