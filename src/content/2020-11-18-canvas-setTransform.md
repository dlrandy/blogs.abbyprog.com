---
templateKey: blog-post
id: canvas-setTransform
title: 
slug: /2020/11/18/canvas-setTransform/
date: 2020-11-18T03:48:03.125Z
description: 了解一下canvas的setTransform
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - canvas, setTransform,
---

setTransform(a,b,c,d,e,f)
a: 水平缩放
b: 水平倾斜
c: 垂直倾斜
d: 垂直缩放
e: 水平移动
f: 垂直移动


对于translate rotate，scale等组合操作使用setTransform可以优化性能.
context.save() 和canvas.restore()是有一些性能问题的，特别是有一些
转换操作在里面的时候。所以有些时候setTransform替换save和restore，
操作会更快，因为占用更少的CPU。
 


 ``` javascript
//draw a sprite and skip the math
ctx.save();
ctx.translate(x, y); //move to canvas coordinates
ctx.rotate(rotation); //rotate in radians
ctx.scale(sx, sy); //scale in size
ctx.translate(-cx, -cy); //center the image relative to itself
ctx.drawImage(img, 0, 0, img.width, img.height);
ctx.restore();


//don't skip the math!
let cos = Math.cos(rotation), sin = Math.sin(rotation);
//Transform the canvas context
ctx.setTransform(
  sx * cos,
  sy * sin,
  sx * -sin,
  sy * cos,
  x,
  y
);
//draw an image
ctx.drawImage(img, -cx, -cy, img.width, img.height);
//restore the canvas state
ctx.setTransform(1, 0, 0, 1, 0, 0);
 ```


 三维的单位矩阵是canvas操作的起点，因为canvas的拉伸，选择和移动都是发生在二维空间的
 ，所有第三行的矩阵总是[0,0,1]。

 **typed 类型**
 在图形开发中，对于复用很多次的的数字数组缓存，对于后续的操作是有性能改善的，因为创建
 这种类型的时候，会使用更多的内存和CPU周期来预先优化读写操作。

canvas的transform是stackable的，允许创建一组转换的操作，然后根据需要push和pop的

``` javascript
//set currentMatrix to the identity matrix
var currentMatrix = [1, 0, 0, 1, 0, 0];
var cache = new Float64Array(6); //reuse this variable a lot!
cache.set(currentMatrix);
var stack = [currentMatrix.slice()];//slice copies the currentMatrix
//This is a pushing operation
stack.push(currentMatrix.slice());
ctx.setTransform(
 currentMatrix[0],
 currentMatrix[1],
 currentMatrix[2],
 currentMatrix[3],
 currentMatrix[4],
 currentMatrix[5]
);

//remove the top value
stack.pop();
//restore the next value
currentMatrix = stack[stack.length — 1]; //restore previous value
ctx.setTransform(
 currentMatrix[0],
 currentMatrix[1],
 currentMatrix[2],
 currentMatrix[3],
 currentMatrix[4],
 currentMatrix[5]
);
```

### translation
[
  1 0 tx
  0 1 ty
  0 0 1
]
``` javascript 
currentMatrix[4] += currentMatrix[0] * tx + currentMatrix[2] * ty;
currentMatrix[5] += currentMatrix[1] * tx + currentMatrix[3] * ty;
push();
```
translation只移动当前矩阵的e和f值
### scale

[
  sx 0 0
  0 sy 0
  0  0  1
]
``` javascript
currentMatrix[0] *= sx;
currentMatrix[1] *= sx;
currentMatrix[2] *= sy;
currentMatrix[3] *= sy;
push();

```
scale不会影响transform的当前坐标，所以scale应用到前四个项目上


### rotate
``` javascript 
var cosa = Math.cos(a), sinr = Math.sin(a);
cache[0] = currentMatrix[0];
cache[1] = currentMatrix[1];
cache[2] = currentMatrix[2];
cache[3] = currentMatrix[3];
currentMatrix[0] = cache[0] * cosa + cache[2] * sina;
currentMatrix[1] = cache[1] * cosa + cache[3] * sina;
currentMatrix[2] = cache[0] * -sina + cache[2] * cosa;
currentMatrix[3] = cache[1] * -sina + cache[3] * cosa;
push();
```
[
  cos(a)  -sin(a) 0
  sin(a)  cos(a)  0
  0       0       1
]

``` javascript
const rads = degrees => Math.PI * 2 * degrees / 360;
```


