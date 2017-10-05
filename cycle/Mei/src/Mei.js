function Mei(options) {
    // TODO option 和 data 类型的判断
    let data = options.data;
    let el = document.getElementById(options.el);// 此处的el应该是数组？element？or String？
    let bindings = {};
    let _data = {};
    let bindingMark = 'v-text';
    let content = el.innerHTML.replace(/\{\{(.*)\}\}/g, function(match, variable) {
        // 得到hmtl中有多少需要双向绑定的变量
        bindings[variable] = {}
        return `<span ${bindingMark}="${variable}"></span>`;
    })

    el.innerHTML = content;

    function bind(variable) {
        bindings[variable].els = document.querySelectorAll(`[${bindingMark}="${variable}"]`);
        [].forEach.call(bindings[variable].els, function(el) {
            el.removeAttribute(bindingMark);
        });
        let val = _data[variable]; // TODO 这里可以写在下面的get/set 中使用bindings[variable]实现，为何要这样做呢？
        Object.defineProperty(_data, variable, {
            get() {
                // return data[variable]  不能这样写，否则会陷入死循环
                return val;
            },
            set(newVal) {
                if (newVal === val) return;
                val = newVal;
                [].forEach.call(bindings[variable].els, function(el){
                    el.textContent = newVal;
                });

            }
        });
    }

    // 将data中的变量和template中{{}}绑定
    for(let variable in bindings) {
        bind(variable);

    }

    // 为什么需要这一步骤呢？因为需要数据数据进行初始化的操作！
    // 意思是传入进来的option.data这个对象没有做Reactive的处理，因此需要重新便利赋值，做Reactive的处理
    for (let variable in data) {
        _data[variable] = data[variable];
    }





}