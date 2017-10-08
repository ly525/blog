### Done
1. 解析{{}} (2017-10-04)
2. 解析v-text (2017-10-05)
3. 解析v-show (2017-10-05)
4. 解析v-on(v-on="click:handler") `2017-10-06`

### TODO
1. m-on="click:handler"检查handler未定义的异常。`2017-10-06`
2. 将handler从data中抽取出来-> handlers。`2017-10-06`
3. 支持同一个元素多个v-on事件。`2017-10-06`

### 思考
1. 明白了源码中为何需要一个$data 来存储数据以及需要将data中每一个属性挂载在Vue instance上面的原因: 方便外界修改数据，从而更新界面。在Mei.js需要将_data 绑定到instance身上(this)。
2. 需要将指令(directive) 和 其关联的元素的放在一起，通过一个Object的方式进行调用。也就是该指令对应的handler, 元素。因为使用变量定义，关联性不是很好。
3. 需要看原生js中关于dom操作的部分，比如事件函数

### 理解
1. 在Vue中methods中this为何是每一个vue instance？这时候发现是通过bind(this)实现的。`2017-10-06`
