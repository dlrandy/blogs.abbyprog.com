---
templateKey: blog-post
id:nodejs-module-system
title: 了解nodejs的模块系统和相关模式
slug: /2020/12/25/nodejs-modules/
date: 2020-12-25T03:48:03.125Z
description:了解nodejs的模块系统和相关模式
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - nodejs, design,pattern
---

### 谈及模块的时候，模式到底意味着什么？为什么它们很重要？
模块是构建APP的基石。
module将codebase分成可独立开发测试的单元。
模块可以强化信息的隐藏，通过将私有的函数和变量不显示导出。

> module和其他语言的package(Java go dart),assembly(.net),library(ruby),unit（pascal）等概念相似，，但是不是等价的，一般是有特殊，有重叠。
**nodejs有两个模块系统，Commonjs(CJS)和ES modules(ESM)**

### 为什么需要模块
模块系统满足了一些软件工程的需要：
1. 将codebase分为多个文件
  有助于组织code，使得code易于理解，有助于独立的开发和测试各种功能。
2. 允许code在不同的项目里复用
3. 封装(信息隐藏)
  隐藏实现的复杂性，暴露出简单易用的接口。
4. 管理依赖
  好的模块系统应该易于在已有模块上构建功能。

### Modules  VS Module System
module是软件的实际unit；模块系统则是允许在项目里定义和使用模块的语法和工具。


### js 模块 和nodejs 模块
- [ ] 浏览器里通过script标签,Amd,CMD,Umd，Esm划分
- [ ] nodejs里使用commonjs，ESM


### 模块系统和它的模式
因为浏览器里没有命名空间，全局的变量容易产生冲突。
模块的主要机制是隐藏信息，相同作用的模式是揭露模块模式(利用立即执行函数)。**js 是函数作用域的**


### Commonjs是如何工作的？
``` javascript
  function loadModule(filename, module, require) {

const wrappedSrc = `
 (function(module, exports, require){
   ${fs.readFileSync(filename, 'utf-8')}
 })(module, module.exports, require)

`;
 eval(wrappedSrc)
  }

function require(moduleName) {
  console.log(`Require invoked for module:${moduleName}`);
  const id = require.resolve(moduleName);
  if(require.cache[id]){
    return require.cache[id].exports;
  }

  const module = {
    exports: {},
    id
  };

  require.cache[id]  = module;

  loadModule(id, module, require);
  return module.exports;
}

require.cache = {};
require.resolve = (moduleName)=>{

}

```
**eval和vm一般不需要使用的，它们会有code注入的风险**

### module.exports VS exports
exports只是module.exports的初始值的引用。
> require函数是同步的


### 对于依赖地狱(不同的module依赖着同一个module的不同版本)这种问题，nodejs会在不同的module下引入不同的版本。

### commonjs的require.resolve算法
当前文件目录下，
1. 解析文件模块
2. 解析核心模块
3. 解析package模块
文件一般是moduleName.js,moduleName/index.js,moduleName/package.json

### commonjs的模块cache
commonjs的每个模块只在第一次require的时候加载执行，后续的require只会调用缓存。正因为这种缓存可能会导致循环依赖问题

### commonjs 的循环依赖
这个问题在于不同的module拿到的是其他module的不完整部分。
> 常见的解决办法是1.合并在一起2.是dynamic require。

### 修改其他模块或者全局作用域
commonjs可以不导出任何的东西。一个模块可以修改其他模块或者全局作用域，这个模块一般叫做monkey  patch。通常是在运行时修改已有对象，应用临时的补丁改变或者继承行为。



### ESM
esm的模块不能再运行时创建；必须在文件头部引入，不能内嵌在控制流里；但是import()的异步(动态)引入可以在运行时执行。

### 模块的导出
默认导出不利于dead  code elimination(tree shaking), 多使用命名导出。默认导出被认为是没有名字的，所以可以给一个local name。



###  Loading 阶段
1. 构建(解析阶段)
  找到所有import，递归的加载不同文件的每个模块内容
2. Instantiation
  对于每个导出的实体，都在内存里爆出里命名引用，但是不赋值
3. Evaluation
  执行code，对之前实例的实体进行赋值
> 实际上1阶段找点，2阶段创建路径3阶段正确的顺序遍历路径。


### load 阶段的Commonjs VS  ESM
因为commonjs是动态的，commonjs在搜索依赖图的同时执行所有的文件，所以require可以用在条件下；ESM是静态的，每个阶段都是独立的，依赖图构建完成之前没有code会执行。

### Read-only live  bindings
ESM的有助于循环依赖：引入的模块的值都是read-only live bindings 的。
**当然引入的是对象的话，也是可以修改属性的**
read-only live bindings的意思就是引入的值只能在被引入模块的内部处理，而不能在外面模块里修改。
**commonjs导出的对象是浅拷贝的，模块里基本类型值导出后，模块内再次改变，不会影响到之前导出的值。当然对象还是会改变**

