---
templateKey: blog-post
id:design-pattern
title: design pattern
slug: /2021/02/21/design-pattern/
date: 2021-02-21T03:48:03.125Z
description: 学习 design-pattern
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - js,design,pattern
---

设计模式是有用的结构，样式和模板可以承载我们的code。

一个设计模式可以规定所有的事情，从代码库到用于构建表达式，函数和
模块的独立语义片段。

### 设计者角度
**设计者注重的是使用我们code的人的体验**
从现在开始不用考虑具体实现，只考虑接口，因为正是接口驱动code用户的体验。


**好的设计是通过约定激增，坏的设计也是**
code应该由问题的domain来定义和用户的体验设计。
高效的软件设计会使用设计模式来封装问题领域同时易于开发人员熟悉和理解。
设计和写code都要从面向用户的角度来进行。

### 精选的设计模式
这个对于一般给定的问题领域，通常有两个基本特点：
- 很好的解决了问题
   流利的表达了问题的本质和解决方案
- 易于熟悉和使用
  一般是使用的方式明显或者改变code的方式也很明显

熟悉性会增加方案的可维护性和可用性。

设计模式不仅是大的架构结构，它存在于code库的各个角落：目录结构，
文件的命名和code的各个表达式。每一个级别的模式使用都能够增加问题领域的
表现性和可熟悉性。


设计模式有所有clean code信条的好处
1. 可靠性
  好的设计模式适合问题领域，允许简单表达想要的逻辑和不太复杂的数据结构。
  采用的设计模式的熟悉性使得其他编程人员易于理解和改善code的可靠性。
2. 高效性
  好的设计模式可以使得设计者更少的考虑代码库或者模块的结构。从而花更多的时间关注于问题领域。也有助于不同code的接口更流线化和可理解。
3. 可维护性
  好的模式易于调整。
4. 可用性
  好的设计模式因为熟悉性，易于被理解


### MVC VS MVVM
MVC的三个观念(models, views, controllers)的分离。
- models
 描述数据以及业务逻辑如何改变这个数据。数据的改变会反映到views上的改变
- views
 描述的是models的渲染方式，以及在有事件触发的时候调用controller。
- controller
接受views 的指令，通知model执行动作
MVC提供分离不同关注的方式。model里存放业务逻辑。views存放用户的逻辑和显示；
controller使得两个关注能够通信。

MVC 
1. view 调用controller
2. controller进行业务处理更新model
3. model变化更新view

MVVM的三个观念
- models 
  规定数据以及业务逻辑如何改变数据。数据的改变会反应到views上的改变
- views
  规定model的渲染方式(结构，布局，样貌)；任何时候有action产生的时候，
  调用ViewModel的数据绑定机制
- viewModel
  作为model和view之间的胶水，使得双方通过双向绑定机制通信

MVVM
1. view和viewModel进行数据绑定
2. viewModel 处理更新model
3. model触发事件通知viewModel


``` javascript
// mvc 
class MutableNumberModel {
    constructor(value){
        this.value = value;
    }

    increment() {
        this.value++;
        this.onChangeCallback();
    }

    decrement(){
        this.value--;
        this.onChangeCallback();
    }

    registerChangeCallback(onChangeCallback){
        this.onChangeCallback = onChangeCallback;
    }
}


class MutableNumberController {
    constructor(model, view){
        this.model = model;
        this.view = view;

        this.model.registerChangeCallback(() => this.view.renderUpdate());
        this.view.registerIncrementCallback(() => this.model.increment());
        this.view.registerDecrementCallback(() => this.model.decrement());
    }
}

class MutableNumberView {
    constructor(model, controller){
        this.model = model;
        this.controller =controller;
    }

    registerIncrementCallback(onIncrementCallback){
        this.onIncrementCallback = onIncrementCallback;
    }

    registerDecrementCallback(onDecrementCallback){
        this.onDecrementCallback = onDecrementCallback;
    }

    renderUpdate(){
        this.numberSpan.textContent = this.model.value;
    }

    renderInitial() {
        this.container = document.createElement('div');
        this.numberSpan = document.createElement('span');
        this.incrementButton = document.createElement('button');
        this.decrementButton = document.createElement('button');
        this.incrementButton.textContent = '+';
        this.decrementButton.textContent = '-';
        this.incrementButton.onclick =
        () => this.onIncrementCallback();
        this.decrementButton.onclick =
        () => this.onDecrementCallback();
        this.container.appendChild(this.numberSpan);
        this.container.appendChild(this.incrementButton);
        this.container.appendChild(this.decrementButton);
        this.renderUpdate();
        return this.container;
    }

}


const model = new MutableNumberModel(5);
const view= new MutableNumberView(model);
const controller= new MutableNumberController(model, view);

document.body.appendChild(view.renderInitial());
```

### React 和 MVC
1. Component发起action
2. reducer接受action，做一些业务处理
3. state接受reducer做的处理，做出改变
4. component响应state的改变

### 数据绑定
数据绑定是作为视图和业务逻辑的桥梁。
数据绑定分为单向和双向绑定两种。
如果在元素的事件变化里，数据的外部描述改变，底层数据将自动更新
来反映这种改变。

```  javascript
 <div class="field">
        <label for="name">Enter your name:</label>
        <input id="name" type="text" name="name"  data-model="name" />
      </div>

      <div class="field">
        <label for="title">Enter your title:</label>
        <input id="title" type="text" name="title" data-model="title" />
      </div>

      <div class="results">
        <h1 data-binding="name"></h1>
        <h2 data-binding="title"></h2>
      </div>
    <script src="./index.js"></script>


// model
const initState = {
  name: "dlrandy",
  title: "Front-end Developer",
};

// VM
const createState = (state) => {
  return new Proxy(state, {
    set(target, property, value) {
      target[property] = value;
      render();
      return true;
    },
  });
};

// view
const render = () => {
  const bindings = Array.from(document.querySelectorAll("[data-binding]")).map(
    (e) => e.dataset.binding
  );
  bindings.forEach((binding) => {
    document.querySelector(`[data-binding=${binding}]`).innerHTML =
      state[binding];
    document.querySelector(`[data-model=${binding}]`).value = state[binding];
  });
};

const state = createState(initState);

const listeners = document.querySelectorAll("[data-model]");

listeners.forEach((listener) => {
  const name = listener.dataset.model;
  listener.addEventListener("keyup", (event) => {
    state[name] = listener.value;
    console.log(state);
  });
});

render();
setTimeout(() => {
  state.name = "Richard";
  state.title = "Technical Lead";
}, 5000);

```

### javascript的原型毒害

## Object.defineProperty
###  value 和 Enumeratable

使用Object.defineProperty定义的enumerable为false的时候，Object.keys是获取不
到key的，但是使用Reflect.ownKeys(obj)是可以获取的，同时使用in也是可以获取的到的。

### writable和configurable
value和enumerable是用来读取属性的，writable和configurable是处理写属性的；writable为
false属性不能重新赋值。configurable为false不能被删除和修改属性描述符。

### getter和setter
允许在读和写对象的时候，调用其他函数


#### 所有对象的属性都有属性描述符

### 最佳实践
为什么在使用for...in 的时候，要使用Object.hasOwnProperty？
除去技术原因，还有是因为这不是最佳实践(简单的给对象的原型添加一个属性)，
一般是在添加了属性之后，可以将原因的属性的enumerable设置为false就可以了


### seal, prevent extension, freezing
都是不同程度的封锁对象的。对象不能扩展，即新属性不能添加。但是还是有些区别的。

**这些被封锁的对象内部的对象是不会被封锁的，因此有些时候可能要递归封锁**

seal相当于configurable设置为false，不能删除已有属性。
preventExtensions，相比seal，freeze最弱，可以修改和删除已有属性。
freeze是对象不能被修改删除和增加


### IOC 和  DI 
当control和dependency紧密耦合的时候，可以使用IOC来进行解耦。
IOC是指组件内部不执行某一个操作，这个操作交给外部执行。
IOC的实现方式：
1. 通过在code外面进行属性添加
2. 通过参数传递
3. DI 

DI是IOC的一种方案，注入依赖到需要的组件

### Aspects 和Decorators
DI 不是解决跨组件的依赖解析问题的唯一方式
decorator也可以实现依赖解析。

aspect是一个横切关注点，并不是真正的依赖。
为什么是面？
是因为是系统的一个方面，而不是某些组件的具体依赖。

DI
一般分为两个部分：
1. 注册组件
2. 当组件被使用时，进行解析

### module
一般是集中所有的export到code的一个区域，以提供相关抽象。

### 模块化 设计模式
是指在单独的一个模块里使用的结构和语法规定。
给定代码库的目录和文件结构应该反映出抽象的蓝图。
一个文件里不该有多个抽象。
#### 构造器模式
使用单一的构造器，手动填充原型上的属性和方法
``` javascript
function Book(title) {
 // Initialization Logic
 this.title = title;
}
Book.prototype.getNumberOfPages = function() { /* ... */ };
Book.prototype.renderFrontCover= function() { /* ... */ };
Book.prototype.renderBackCover=function () {}

// 下面的写法会使得原型丢失constructor
// Book.prototype = {
//  getNumberOfPages() { /* ... */ },
//  renderFrontCover() { /* ... */ },
//  renderBackCover () { /* ... */ }
// };

const myBook = new Book();

console.log(myBook instanceof Book, myBook)
// 上面原型的两种方式都不会影响instanceof的判断
```
##### Constructor模式继承
需要手动的将原型继承父构造器的原型

``` javascript
function Animal() {}
Animal.prototype = {
 isAnimal: true,
 grow() {}
};

function Monkey() {}
Monkey.prototype = Object.create(Animal.prototype)

Monkey.prototype.isMonkey = true;
Monkey.prototype.screech = function() {};

const monkey = new Monkey();

console.log(monkey instanceof Animal,monkey instanceof Monkey);

```

#### class 模式
类模式依赖新的定义语法，主要是替换构造器模式

```javascript

class Name {
  static count = 0;
  date ='';
  #sex = '';

 constructor(forename, surname) {
 this.forename = forename;
 this.surname = surname;
 }
 sayHello() {
 return `My name is ${this.forename} ${this.surname}`;
 }
}


class Animal {}
class Tiger extends Animal {}


```

#### mixing-in class
扩展不仅可以创建语义化子类，还可以提供mixins方法。js没有提供原生
的mixin机制，要么是在定义之后增强prototype要么是继承mixins。



```javascript
// 强化原型
const fooMixin = { foo() {} };
const bazMixin = { baz() {} };

class MyClass{}

Object.assign(MyClass.prototype, fooMixin, bazMixin);

// 上面的方式不允许MyClass覆盖自己mixin的方法

// 继承

const greetingsMixin  = Super => class extends Super {
  hello() { return 'hello'; }
  hi() { return 'hi'; }
  heya() { return 'heya'; }
}

class Human{}
class Programmer extends greetingsMixin(Human) {

}

// subclass factory helper

function mixin(...mixins){
  return mixins.reduce((base, mixin) => mixin(base), Object)
}



```

#### Prototype模式
需要使用对象作为其他对象的模板。即直接继承模板对象，不需要实例化。
和Constructor模式和class模式相似，只不过是没有构造器。
#### 揭示模块模式
封装一些私有逻辑，然后暴露出一些公共的API。
``` javascript
const myModule = (() => {
  const privateFoo = 1;
  const privateBaz = 2;

  return {
    publicFoo(){},
    publicBaz(){},
  }
})()
```

#### 传统模块模式
一般是指一个对象带有很多的方法。
#### 单类模式
多用于一些工具功能，日志，缓存，全局Event Bus。
```javascript
const utils = new class {
  constructor(){
    this.#privateThing = 123;
  }
  utilityA() {}
 utilityB() {}
 utilityC() {}
}
utils.utilityA();

```


### 计划与和谐
决定哪个架构和模块设计模式是一个棘手的过程，因为在做决定的时候，项目的
所有需求并不是清晰明显的。
开发者不是无所不知的，也会有错误，自负和自我热情，如果没达成约定，会影响
生产力可靠性和可维护性。
所以要做到：
1. 期望改变和调整
  每个软件项目都会在某一个时刻，做一些变化。如果我们能持续的思考我们的
  架构和模块化设计，那么我们就能杜绝未来的一些痛点，永远不要认为你创建了
  一个真正的方案。相反，应该质疑你的判断，然后再次迭代。
2. 和其他开发者咨询
  和那些使用code人谈谈，分析意见和数据，然后做出明智决定。
3. 避免货物崇拜和自负
   注意货物崇拜和自负，特别是不认真考虑适用性继承做事的方式或者困于自负：
   认为某个设计或者理论是完美的，只不过是因为我们个人知道或者热爱
4. 对于和谐和一致性的偏见
   在设计架构的时候，寻求和谐，因为在代码库里总是会有某些部分是不同的，
   但是太多的内部不同又会迷惑维护者，从而破碎code的质量和可靠性。


  




