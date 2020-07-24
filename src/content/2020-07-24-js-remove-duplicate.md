---
templateKey: blog-post
id: koa-review
title: 翻译 js对象去重
slug: /2020/07/24/js-remove-duplicate/
date: 2020-07-24T03:48:03.125Z
description: js 去重
headerImage: https://i.imgur.com/IONCWVd.jpg
tags:
  -  js, set, map, remove duplicate
---

对于基本类型值，使用set轻松搞定；也可以直接遍历到对象里，然后取key值。

复杂类型
### 方法一
> 先有一个新的数组存储目标数据，然后定义一个判重的方法；在遍历原数组的时候，
目标数组使用判重方法检测自己是否含有该项的数据，没有的话就加入到目标数组；
> bonus: 遍历数组，根据内容生成唯一key，存到set里，添加到目标数组，继续遍历...
``` javascript

```
### 方法二
> filter原素组，遍历的过程中根据forEach里再次查找相同数据内容的索引，如果两个索引一旦不同
就是重复的；
> bonus: 过滤不存在set里的数据，每次过滤依据set是否含有这个值
``` javascript

```
### 方法三
> 使用map，因为map的键值唯一，而且map又是一个二维数组。所以根据元素的内容生成唯一的key，元素作为value，
然后取得map.values()
``` javascript

```




[参考链接](https://2ality.com/2020/07/eliminating-duplicate-objects.html)
![FYI](https://i.imgur.com/LalbenT.jpg)




