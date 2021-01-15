---
templateKey: blog-post
id: c192eaba9fefc632acf87ed636593475
title: npm 包发布记录
slug: /2020/10/20/npm-publish
date: 2020-10-20T03:48:03.125Z
description: npm package publish
headerImage: https://i.imgur.com/IONCWVd.jpg
tags:
  - npm, publish,jest, code coverage
---

### 为什么使用 typescript？

首先对于小规模的项目，强类型可能会阻碍生产力。但是对于大规模，或者软件包的开发的时候，它有以下好处：

1. 更健壮的 code，code 更易于维护
2. typescript 的包可以用于 typescript 和 JavaScript，这相比只用 JavaScript，后续添加类型定义省时省力，
3. 包里自带类型定义，免去了去另一个包下载类型定义
4. 强类型是自文档化的，而且 code 更易于理解
5. 即便使用 typescript 包的人不使用 TS，一些编辑器还是能使用包的类型定义给出更好的提示

### npm scripts

1. prepublishOnly
   在 prepare 之前运行，写只在 npm publish 的时候运行
2. prepare
   在 pack 和 publish 之前执行，以及在 npm install 的时候执行
3. preversion
   在发布新版本之前
4. version
   发布新版本之后，但是在新生成 commit 之前
5. postversion
   生成新的 commit 之后

### 为什么会有 code coverage？

测试可以让开发者随意的有信心的改变和重构 code。只要测试都通过。
但是单元测试不能够覆盖到所有的细节，所以 code 的改变仍可能会造成 bug
。所以需要 code coverage 来测量自动化测试覆盖的程度。
**code coverage 的一些好处**

1. 增加 code，依然可以维护测试的质量
2. 可以深入的理解已有测试
3. 给开发人员信心去重构 code，而不用担心破坏已有 code
4. 可以捕获未测试的 flow，避免引起问题

### npm scripts

npm list
