---
templateKey: blog-post
id:solid-universal-javascript
title: universal javascript
slug: /2021/01/17/solid-universal-javascript/
date: 2021-01-17T03:48:03.125Z
description: 学习solid universal javascript
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - js, universal
---

Universal JavaScript是指前端后端可以跨环境复用同一个项目的code。


### nodejs和浏览器共享code
前后端code复用最大的工作在于将平台的区别降到最小。这需要一些抽象，模式和工具使得app能够动态的切换或者在编译的时候切换。

### 跨平台环境下的js模块
浏览器和nodejs共享一些code的问题：
1. 模块系统的不匹配
2. 浏览器没有require函数
3. 发布code的方式不同，nodejs直接从文件系统加载，鼓励书写更小的模块；浏览器是从远端下载文件，尽管有一些HTTP2等的优化技术，但是不得不承认的是使用较少的优化后的文件是最好的。

> 浏览器打包的时候的优化技巧一般是移除comment，移除不使用的code，重新命名函数和变量等。

### module 打包器
一般是接收app的源码，然后产生一个或者多个打包文件。打包的过程不改变APP的业务逻辑，只是产生适合在浏览器上运行的优化文件。
浏览器端必须处理两个逻辑阶段：build时和runtime时；
server没有build阶段可以直接执行code。


### module打包器如何工作的 
模块打包器的工作一般是两个部分：依赖解析和打包。
1. Dependency resolution
  遍历codebase，从主入口文件开始，找到所有的依赖。形成一个非循环的有向图。最终产生一个modules map的一个数据结构
  ``` javascript
   // moduels map
   {
 'app.js': (module, require) => {/* ... */},
 'calculator.js': (module, require) => {/* ... */},
 'display.js': (module, require) => {/* ... */},
 'parser.js': (module, require) => {/* ... */},
 'resolver.js': (module, require) => {/* ... */} }
  ```
2. packing
module bundler使用modules map，并将其解析成可执行的bundler：一个包含了所有app逻辑的js文件。

``` javascript
((modulesMap) => {  
 const require = (name) => {  
 const module = { exports: {} }  
 modulesMap[name](module, require)  
 return module.exports  
 }
 require('app.js')  
})(
 {
 'app.js': (module, require) => {/* ... */},
 'calculator.js': (module, require) => {/* ... */},
 'display.js': (module, require) => {/* ... */},
 'parser.js': (module, require) => {/* ... */},
 'resolver.js': (module, require) => {/* ... */},
 }
)
```

> tree shasking
是指模块里没有在依赖图中使用的，不会包含在最终的bundle里。

> modules map里的每个module都是一个工厂函数，该函数接受两个参数module和require。 


### 跨平台开发基础
在可跨平台开发的时候，最常见的问题是尽可能的复用更多的code，同时还要提供特定平台的特殊实现细节。
解决上面问题的原则和模式：
1. code branching
    1. runtime
        
        基于宿主平台动态的分支code。需要在运行时识别宿主平台然后动态的切换实现。
        实现简单直观。
        它的问题：
        
        - 两个平台的code被包含到了同一个模块里。文件size，变大，也添加了不需要的code。还可能泄露信息引入安全问题
        -  使用的太广泛，会有可读性问题

    2. build time
        基于打包工具可以获得更轻量的文件避免意外的泄露包含敏感信息的code。
  

2. module swapping
  一般在buildtime的时候，就知道了哪些code是要包含在client bundle里的。所以可以事先指示打包器在build的时候替换整个模块的实现。


### 跨平台开发的设计模式
1. 策略模式和模板模式
2. 适配器
3. 代理模式
4. 依赖注入和service locator

### React
react在Universal js领域很流行，在于它能够使用几乎一样的code在浏览器器和server端渲染react组件。也就是react可以在server上渲染html code，然后浏览器拿到这个code时候，react执行hydration的操作，这个操作只添加一些前端才有side effects(click handler, animation, data fetching, routing等)。也就是hydration将一个静态的标记转换成了可交互的页面。

Universal的好处
1. 更好的SEO 
2. 更好的性能


