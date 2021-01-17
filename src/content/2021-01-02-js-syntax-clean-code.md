---
templateKey: blog-post
id:js-syntax-control-flows
title: 了解js的语法和控制流
slug: /2021/01/02/nodejs-callbacks-control-flow/
date: 2021-01-02T03:48:03.125Z
description:了解js的语法与控制流
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - js, systax, clean code,control flow
---

**在块里就不要使用函数声明了，多用表达式**

### declarative

declarative patterns 是在问题 domain 上表达逻辑，而不是关注底层的抽象层。
它的好处一般是代码清晰易读，方便对问题领域建模。

### Multivariant conditions

特别适合必须使用多个 ifelse 的情况

### 识别 code 复杂性

- 一个函数有多于一个的 if/else/if 组合
- if 里有很多的子条件
- switch 的声明里有很多的子条件
- switch 有太多的 case 情况
  **当遇到 code 复杂性问题的时候，最主要的就是先考虑问题的域。能否以不同的逻辑描述？能否形成不同的抽象**

### 抽象等

对于同一类型的非基本类型值的抽象等，如果两个对象不是完全的同一个对象，那么通常是要返回 false 的；对于不同类型的，一般是转化为数字比较。

**对象的基本类型值转换，一般是调用[Symbol.toPrimitive]()-->valueOf()-->toString()**

对于严格等，可以显示的转换成同一类型进行相等比较

如何安全判断对象拥有某一个属性？为甚不直接使用 xx.hasOwnProperty()?
一般是 Object.prototype.hasOwnProperty.call（），直接用不安全，该方法有可能被覆盖。

箭头函数是不可构造的，不能使用 new 调用。

位操作符是将操作数转换为 32 位的整数描述

对于类型检查，首先要确定检查的到底是什么比如 Array 还是 iterable？用 instanceof 检查是实例还是只是说具备属性(鸭子类型)就好。

更严格的检查通常创建更严苛的 code 和不必要的灵活限制。但是也不要过分的灵活。有些情况严格检查提供的严苛和确定性可以长远的保持 cleaner code；但是有时候灵活性却是恰恰能达到 cleaner code 的。

**如果检查不是真正的防止实现中的错误，那么就不需要执行特定检查之外的其他检查**

对于 null 和 undefined 的检查，可以严格显示的判断；也可以抽象等于 null；undefined 可以被覆盖，但是 null 不会。

不管是做什么检查，最重要的是要意图明显。

如何检查一个对象是普通对象？
只需要判断对象的原型是不是等于 Object.prototype 就好了

```javascript
function isPlainObject(object) {
  return Object.getPrototypeOf(object) === Object.prototype;
}
```

cast 是有目的的和显示派生；coercion 是隐式的内部转换

对于字符串的转换，建议使用过 string 显示的转换。使用间接的转换，副作用或者依赖 toString 会有问题。

> 对于一个对象，直接 string 会调用 toString 方法；使用+号则会先 valueof，后 tostring。

对于转换数字，parseInt 会捕获第一次出现的数字；number 一旦字符串里有其他非数字字符就会 NaN。

对象转为基本类型值的是先是[Symbol.toPrimitive] valueOf toString.

js 里对于 0.1+0.2 的问题，可以使用两种方法解决

1. 和-0.3 的绝对值小于 Number.EPSILON;
2. 放大成整数倍进行比较
