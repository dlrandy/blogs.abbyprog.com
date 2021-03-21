---
templateKey: blog-post
id:blender-intro
title: blender intro
slug: /2021/02/22/design-pattern/
date: 2021-02-22T03:48:03.125Z
description: 学习 blender
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - blender,3d
---

所有的 3D 软件都是用笛卡尔直角坐标系，包含 x,y,z 轴。

坐标系中的准确的 unit size 是不一样的，但是一般是 grid 里的一个 unit
等于现实世界的一米。

3D 空间的三种 transforms：

1. location(translation)：对象的位置;
2. rotation: 对象的朝向;
3. scale: 对象的 size；

3D 对象

- Mesh
  Mesh 是 3D 对象，由多个组件组成，这些组件用来构成空间多边形；
  多边形是多边的形状用来形成 model 的可见表面。这种方法叫做
  多边形建模
- Empty
  一个没有任何附加组件的对象。一般叫做 null 对象或者定位器，
  多用来定义和追踪 3D 空间中的准确的点

- Light
  是一种将光投射到场景中的对象，没有光就什么都看不见。
  大多数的 3D 软件默认都会包含光源的，一般是环境光或者环绕光

- Camera
  用来创建来自 3D 场景中最后的画面

Mesh 的组件
多边形建模里使用的三个基本组件

1. vertices
   3d 空间中的一个点，没有大小 方向
2. Edges
   画在点之间的线段
3. Faces
   多边形的可见不等通过填充三个以上的边的形成的面

这些组件是通过 topology 连接的。使用 topology 创建 mesh 的
最佳实践是四边形是最好的多边形类型，三角形应该小心使用，
多边形应避免。

Material 和 Textures
可以使用 material 和 texture 的混合物给 3Dmodel 上色。
material 用来决定物体表面和光的交互时候的光的行为。
texture 是 2D 图片，包在 3Dmodel 上.

为了使 texture 和 model 对齐，首先需要打开 model，
打开可以拿到 model 的描述-UV map。然后给 UVs 绘制上 texture，
然后封装回 model

UVs
是所有的碎片，每一个碎片都有 U 坐标和 V 坐标，用来决定在 2D 空间中的位置。

Perspective View VS Orthographic view
透视图下，对象有个消失点。对象越远越小。正交视图里，无论远近尺寸是不变的。

学习任何的 3D 软件首先是要看如何在 3D 视口里进行导航。

在 Blender 里，X 表示宽度 Z 表示高度，Y 表示深度。XYZ-》RGB.ZY 在其他软件里 Z,Y 的
表示会有不同。

Blender 将项目保存为.blend 格式，可以存储任何的 3D 场景需要的对象，但是通常 texture 文件
是单独存放的。这样 blend 文件就可以占用更少的空间了
