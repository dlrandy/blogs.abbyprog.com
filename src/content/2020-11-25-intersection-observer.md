---
templateKey: blog-post
id: intersection-observer
title: 了解intersectionObserver与iframe
slug: /2020/11/25/intersection-observer/
date: 2020-11-25T03:48:03.125Z
description: intersectionObserver的学习了解
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - js, intersectionObserver
---

追踪DOM里的元素是否进入可见的viewport的时候，可能是为了及时的懒加载或者想要确定用户看到了特定的广告横幅。很多方式可以实现，比如勾入到scroll事件或者使用定时器来周期性的调用目标元素的getBoundingClientRect()。但是这个方法会重排整个页面，导致绘制的性能问题，将会带来不好的效果。
> getBoundingClientRect不适用于嵌入在iframe里的网页的情况，他将会获得相对于iframe的位置。因为单一源模型的限制，不会要iframe访问容器网页的数据。iframe广告经常会遇到该问题。一般解决的办法是获取绝对的位置
``` javascript
function currentFrameAbsolutePosition() {
  let currentWindow = window;
  let currentParentWindow;
  let positions = [];
  let rect;

  while (currentWindow !== window.top) {
    currentParentWindow = currentWindow.parent;
    for (let idx = 0; idx < currentParentWindow.frames.length; idx++)
      if (currentParentWindow.frames[idx] === currentWindow) {
        for (let frameElement of currentParentWindow.document.getElementsByTagName('iframe')) {
          if (frameElement.contentWindow === currentWindow) {
            rect = frameElement.getBoundingClientRect();
            positions.push({x: rect.x, y: rect.y});
          }
        }
        currentWindow = currentParentWindow;
        break;
      }
  }
  return positions.reduce((accumulator, currentValue) => {
    return {
      x: accumulator.x + currentValue.x,
      y: accumulator.y + currentValue.y
    };
  }, { x: 0, y: 0 });
}
```

高效的检测元素的可见性正是IntersectionObserver的设计目的。

``` javascript
const io = new IntersectionObserver(entries => {}, {});

io.observe(element);

io.unobserve(element);

io.disconnect();

```
默认option的情况下，回调是会在元素部分进入viewport以及完全离开viewport的时候调用。

IntersectionObserver是异步传输数据的，回调是运行在主线程上的。规范要求intersectionObserver的实现使用requestIdleCallback。也就意味着回调的优先级较低。


**threshold选项**
定义intersectionRatio的数组。回调会在到达这些阈值。默认是[0].

### iframe magic
IntersectionObservers专门设计于ads服务和社交网络组件，这些经常使用iframe，可以知道他们是否在视图中。如果iframe检测它内部的某一个元素，不管是滚动iframe还是滚动window，都会在适当的时间触发回调。但是对于滚动window的情况，rootBound会被设置为null防止数据跨域。

### intersectionObserver不适用的情况
他不是用于像素精确和低延迟要求的，因为他返回来的数据一般是过时的。




思考题
intersectionobserver也是使用了getClientBoundingRect(), 但是为啥没有性能问题？









https://developers.google.com/web/updates/2016/04/intersectionobserver
https://stackoverflow.com/questions/53056796/getboundingclientrect-from-within-iframe



