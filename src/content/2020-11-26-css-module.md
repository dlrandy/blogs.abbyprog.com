---
templateKey: blog-post
id: css-module
title: 了解css module
slug: /2020/11/26/css-module/
date: 2020-11-26T03:48:03.125Z
description: css module了解
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - css, module, local, global
---

css module规定css文件，它里面所有的类名字和动画名字默认都是local作用域的。

css module是构建步骤的一个处理程序，将类名和选择器局部化。局部化的class是动态生成的，唯一的，且对应着正确的样式。

### 为什么使用css modules
可以保证单个组件的所有样式：
- 在一个地方
- 只对应这个组件

> 主要是为了解决css全局作用域的问题；
> 全局css问题有哪些
>  - 简单的一段css可能会影响很多地方
>  - 不好重新组织样式结构
>  - 不确定某个样式的作用，无法确定是否还在使用
>  - 不确定一些样式是否可以移除，不会产生影响
>  - 不确定样式是独立的还是有依赖的，还是其他地方有重写

### css module的关键字 composes

```scss
// composes的用法
.serif{
  font-family: Georgia, serif;
}
 .display{
   composes: serif-font;// 应用了display的标记，会同时应用serif
   font-size: 30px;
   line-height: 35px;
 }
.element {
  composes dark-red from '../colors.css';
  composes globalClassName from global;
  font-size: 30px;
  line-height: 1.2;
}
```
```jsx
import type from "./type.css";

element.innerHTML = 
  `<h1 class="${type.display}">
    This is a heading
  </h1>`;
```
``` html
<h1 class="_type__display_0980340 _type__serif_404840">
  Heading title
</h1>
```
### 回忆一下BEM的命名规范
``` css
.block-name__element-name_mod-name_mod_val {

}
.block--mod .block__elem { }
```

### css module 的编译过程(对于大的项目cssmodule是有代价的)
css module经过css modules编译器会生成两个文件。一个css文件和一个js映射文件，映射的是原始的类名和编译后的类名。

### :local  VS  :global
``` scss
// 原样输出,尊重当前选择器的名字，但是切换到全局区域
:global{

}
:global(selector){

}

// css module 正常输出,文件名_选择器名_hash
:local{}
:local(secltor){}




https://css-tricks.com/css-modules-part-1-need/
