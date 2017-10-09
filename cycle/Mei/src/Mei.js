import marks from './marks'

function Mei(options) {
    // TODO option 和 data 类型的判断
    let self = this;
    let data = options.data;
    let el = document.getElementById(options.el);// 此处的el应该是数组？element？or String？
    let bindings = {};
    let _data = this._data = {};
    let bindingMark = 'v-text';
    let bindingVShowMark = 'v-show'; // 这边可以将标记抽取成Object，以及其extract方法
    let bindingVOnMark = 'v-on';

    function bindHandler(mei, el, event, handler) {
        el.addEventListener(event, handler.bind(mei));
    }
    function extractVOn() {
        let vOnElements = document.querySelectorAll(`[${bindingVOnMark}]`);
        vOnElements.forEach.call(vOnElements, function(el) {
            let exp = el.getAttribute(`${bindingVOnMark}`);
            let [event, handler] = exp.split(':');
            let variable = handler;
            bindings[variable] = {};
            bindings[variable].event =  event;
            bindings[variable].vOnElements = [];

            // if (!bindings[variable]) {
            // }
            bindings[variable].vOnElements.push(el);
            // update(self, el, event, handler);

        });
    }

    function extractBrackets() {
        let content = el.innerHTML.replace(/\{\{(.*)\}\}/g, function(match, variable) {
            // 得到hmtl中有多少需要双向绑定的变量
            bindings[variable] = {}
            return `<span ${bindingMark}="${variable}"></span>`;
        });
        el.innerHTML = content;
    }

    function extractVText() {
        let vTextElments = document.querySelectorAll(`[${bindingMark}]`);
        [].forEach.call(vTextElments, function(el) {
            let variable = el.getAttribute(bindingMark);
            bindings[variable] = {};
        });
    }

    function extractVShow() {
        let vShowElements = document.querySelectorAll(`[${bindingVShowMark}]`);
        [].forEach.call(vShowElements, function(el) {
            let variable = el.getAttribute(bindingVShowMark);
            bindings[variable] = {};
        });
    }

    // 注意这里： 先解析 v-text 就不会存在 v-text=variable 与 {{varaible}}相同的情况
    extractVText();//
    extractBrackets();
    extractVShow();
    extractVOn();


    function bind(variable) {
        let binding = bindings[variable];
        binding.els = document.querySelectorAll(`[${bindingMark}="${variable}"]`);
        [].forEach.call(bindings[variable].els, function(el) {
            el.removeAttribute(bindingMark);
        });

        binding.vShowElements = document.querySelectorAll(`[${bindingVShowMark}="${variable}"]`);
        [].forEach.call(binding.vShowElements, function(el) {
            el.removeAttribute(bindingVShowMark);
        });

        let vOnElements = binding.vOnElements || [];
        [].forEach.call(vOnElements, function(el) {
            el.removeAttribute(bindingVOnMark);
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
                // 更新v-text 和 {{}} 绑定元素
                [].forEach.call(bindings[variable].els, function(el){
                    el.textContent = newVal;
                });
                // 更新v-show绑定元素
                [].forEach.call(bindings[variable].vShowElements, function(el){
                    el.style.display = !!newVal ? '' : 'none';
                });

                // 给v-on元素绑定事件
                [].forEach.call(vOnElements, function(el) {
                    bindHandler(self, el, binding.event, newVal);
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

export default Mei