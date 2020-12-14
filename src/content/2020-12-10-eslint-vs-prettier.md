---
templateKey: blog-post
id: eslint-prettier
title: eslint vs prettier
slug: /2020/12/10/eslint-prettier/
date: 2020-12-10T03:48:03.125Z
description: 了解eslint和prettier的异同
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - eslint, js, prettier
---

### 什么是lint？为什么它能节省时间？提高生产效率？
lint是一个自动扫描文件分析源码，标记编程错误和bug以及样式问题和可疑组件的工具。


### lint的主要功能

1. 标记code语法错误的bug 
2. 对于不直观的code提出警告
3. 提供最佳实践的建议
4. 追踪TODO和FIXME
5. 保持code的一致样式

> 以上的这些会减少code review时候，会花费的一些时间。

### parser
对于使用了实验性的js特性，eslint可能不认识，所以可能要引入@babel/eslint-parser或者升级eslint到最新版本

### plugin
对于eslint不知道如何验证的东西，需要用到插件。加入插件来验证。
**对于一些不理解的规则，需要在extends里进行配置。插件一般会带有一些规则**

### prettier
lint可以告诉code里面的错误。虽然对于一些错误，lint可以修复。但是如何去避免修复更多的错误的实际工作？那么就要说prettier了。

Prettier是扫描文件寻找样式问题并自动格式化code，来确保code符合样式的一致性；




### eslint和prettier是如何工作的？

prettier接收code，转换成语法树，使用样式和规则重写code。规则可能是eslint和prettier提供的。
### eslint parser和plugin是如何工作的？


### prettier VS eslint
1. eslint不仅能code格式化，还能找出code错误(未声明先使用变量，声明但没有使用的变量等等)
2. eslint指出code格式问题和给出修复建议；prettier则是直接格式化掉。
3. prettier的重写过程也会减少一些错误
4. prettier有好多的格式规则；eslint除了格式规则，还会考虑code质量的规则。



https://medium.com/better-programming/eslint-vs-prettier-57882d0fec1d
https://medium.com/javascript-scene/streamline-code-reviews-with-eslint-prettier-6fb817a6b51d#:~:text=ESLint%20performs%20automated%20scans%20of,quotes%20vs%20double%20quotes%2C%20etc.
https://indepth.dev/posts/1282/setting-up-efficient-workflows-with-eslint-prettier-and-typescript
