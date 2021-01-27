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

Universal JavaScript 是指前端后端可以跨环境复用同一个项目的 code。

### nodejs 和浏览器共享 code

前后端 code 复用最大的工作在于将平台的区别降到最小。这需要一些抽象，模式和工具使得 app 能够动态的切换或者在编译的时候切换。

### 跨平台环境下的 js 模块

浏览器和 nodejs 共享一些 code 的问题：

1. 模块系统的不匹配
2. 浏览器没有 require 函数
3. 发布 code 的方式不同，nodejs 直接从文件系统加载，鼓励书写更小的模块；浏览器是从远端下载文件，尽管有一些 HTTP2 等的优化技术，但是不得不承认的是使用较少的优化后的文件是最好的。

> 浏览器打包的时候的优化技巧一般是移除 comment，移除不使用的 code，重新命名函数和变量等。

### module 打包器

一般是接收 app 的源码，然后产生一个或者多个打包文件。打包的过程不改变 APP 的业务逻辑，只是产生适合在浏览器上运行的优化文件。
浏览器端必须处理两个逻辑阶段：build 时和 runtime 时；
server 没有 build 阶段可以直接执行 code。

### module 打包器如何工作的

模块打包器的工作一般是两个部分：依赖解析和打包。

1. Dependency resolution
   遍历 codebase，从主入口文件开始，找到所有的依赖。形成一个非循环的有向图。最终产生一个 modules map 的一个数据结构

```javascript
 // moduels map
 {
'app.js': (module, require) => {/* ... */},
'calculator.js': (module, require) => {/* ... */},
'display.js': (module, require) => {/* ... */},
'parser.js': (module, require) => {/* ... */},
'resolver.js': (module, require) => {/* ... */} }
```

2. packing
   module bundler 使用 modules map，并将其解析成可执行的 bundler：一个包含了所有 app 逻辑的 js 文件。

```javascript
((modulesMap) => {
  const require = (name) => {
    const module = { exports: {} };
    modulesMap[name](module, require);
    return module.exports;
  };
  require("app.js");
})({
  "app.js": (module, require) => {
    /* ... */
  },
  "calculator.js": (module, require) => {
    /* ... */
  },
  "display.js": (module, require) => {
    /* ... */
  },
  "parser.js": (module, require) => {
    /* ... */
  },
  "resolver.js": (module, require) => {
    /* ... */
  },
});
```

> tree shasking
> 是指模块里没有在依赖图中使用的，不会包含在最终的 bundle 里。

> modules map 里的每个 module 都是一个工厂函数，该函数接受两个参数 module 和 require。

### 跨平台开发基础

在可跨平台开发的时候，最常见的问题是尽可能的复用更多的 code，同时还要提供特定平台的特殊实现细节。
解决上面问题的原则和模式：

1. code branching

   1. runtime

      基于宿主平台动态的分支 code。需要在运行时识别宿主平台然后动态的切换实现。
      实现简单直观。
      它的问题：

      - 两个平台的 code 被包含到了同一个模块里。文件 size，变大，也添加了不需要的 code。还可能泄露信息引入安全问题
      - 使用的太广泛，会有可读性问题

   2. build time
      基于打包工具可以获得更轻量的文件避免意外的泄露包含敏感信息的 code。

2) module swapping
   一般在 buildtime 的时候，就知道了哪些 code 是要包含在 client bundle 里的。所以可以事先指示打包器在 build 的时候替换整个模块的实现。

### 跨平台开发的设计模式

1. 策略模式和模板模式
2. 适配器
3. 代理模式
4. 依赖注入和 service locator

### React

react 在 Universal js 领域很流行，在于它能够使用几乎一样的 code 在浏览器器和 server 端渲染 react 组件。也就是 react 可以在 server 上渲染 html code，然后浏览器拿到这个 code 时候，react 执行 hydration 的操作，这个操作只添加一些前端才有 side effects(click handler, animation, data fetching, routing 等)。也就是 hydration 将一个静态的标记转换成了可交互的页面。

Universal 的好处

1. 更好的 SEO
2. 更好的性能

服务端渲染的时候，componentDidMount 不会执行。
服务端渲染是同步的操作。

### universal data fetch

一般是要数据完全的在 server 端加载完，生成的 html 里
通过内置 script 将数据注入到 global 作用域里。浏览器运行的时候，
已经加载的数据就不

1. two pass rendering
  使用react router的static context作为向量在React和server之间进行信息交换。
  > 调用renderToString，将url和空的static context传递给React App;Ract 执行路由过程，选择要渲染的组件，将预加载的数据作为promise传递给static context， 此时得到一个不完整的html标记；server等待数据加载完成，形成新的static context，由renderToString再次将新的static context进行渲染得到完整的html标记；上述过程可以多次进行。

  #### 方法的好处与坏处
  好处：
  更灵活的组织组件树；异步数据可以在组件树的级别上进行获取。
  坏处：
  renderToString成本不低，可能破事server执行多次渲染过程，而整体的过程非常慢。

2. asyns pages
以特殊的方式构造组件树的顶层
> 1. app的root总是一个Router组件(server上StaticRouter，浏览器上则是BrowserRouter)
> 2. app是router的唯一孩子
> 3. APP的唯一孩子是react-router-dom的Switch组件
> 4. Switch有多个Route组件
