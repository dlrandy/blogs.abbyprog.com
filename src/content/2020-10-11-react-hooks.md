---
templateKey: blog-post
id: react-hooks
title: React Hooks
slug: /2020/10/11/react-react-hooks/
date: 2020-10-11T03:48:03.125Z
description: FP VS RP
headerImage: https://i.imgur.com/Ivxkc3R.jpg
tags:
  - react, useState, useReducer, useCallback, useContext
---
React的useState有助于react的状态管理：
1. 将改变state的组件和state逻辑进行隔离，以至于state改变逻辑复用
2. 当有多个元素的状态一起改变的时候，使用一个state对象包含所有的state，有助于state的管理 e.g. useReducer。

### Lazy init
当有expensive的计算需要在初次渲染的时候执行一次，或者从浏览器缓存里读取的时候。懒初始化函数可以
是async函数，但是有一个问题你猜。

### useState

### 什么时候使用useState而不是useReducer？


### 什么时候使用 useReducer 而不是 useState ？

https://kentcdodds.com/blog/how-to-implement-usestate-with-usereducer
https://kentcdodds.com/blog/should-i-usestate-or-usereducer/
https://levelup.gitconnected.com/usetypescript-a-complete-guide-to-react-hooks-and-typescript-db1858d1fb9c

### window.matchMedia
用来决定use-agent是否满足给定的media query。


### 使用useReducer实现useState？

### useCallback
https://developers.google.com/web/updates/2017/09/abortable-fetch


https://kentcdodds.com/blog/usememo-and-usecallback
``` javascript
function useSafeDispatch(dispatch){
  const mounted = React.createRef(false);

  React.useEffect(() => {
    mounted.current = true;
    return () => mounted.current = false;
  },[dispatch]);

  return React.uesCallback((...args) => (mountedRef.current ? dispatch(...args) : void 0),
  [dispatch]
  )
}

function useAsync(initialState) {
  const [state, unsafeDispatch] = React.useReducer(asyncReducer, {
    status: 'idle',
    data: null,
    error: null,
    ...initialState,
  })

  const dispatch = useSafeDispatch(unsafeDispatch)

  const {data, error, status} = state

  const run = React.useCallback(
    promise => {
      dispatch({type: 'pending'})
      promise.then(
        data => {
          dispatch({type: 'resolved', data})
        },
        error => {
          dispatch({type: 'rejected', error})
        },
      )
    },
    [dispatch],
  )

  return {
    error,
    status,
    data,
    run,
  }
}


```


### useContext
组件之间共享state的比较方案就是state提升，但是要求属性下沉不会有问题。属性下沉有的时候很痛苦。
context是将state插在React tree的某个区域上，在当前React Tree里的任何地方都可以访问这个state。
共享状态的时候，还可以考虑 **React’s composition model**
context错误的用法是经常作为全局的state，这样影响性能。最佳的实践就是在React Tree的某一个部分使用


https://kentcdodds.com/blog/prop-drilling
https://reactjs.org/docs/lifting-state-up.html
https://github.com/kentcdodds/stop-runaway-react-effects

### useEffect VS useLayoutEffect
对于DOM上可以观察到的改变，使用useLayoutEffect，否则使用useEffect。
https://kentcdodds.com/blog/useeffect-vs-uselayouteffect
https://github.com/donavon/hook-flow
https://github.com/donavon/hook-flow/blob/master/hook-flow.pdf


### useImperativeHandle
ref可以指代组件实例也可以指代dom元素。
ref对于类组件和函数组件的使用是有差别的。
函数组件没有实例，因为每次都会重新渲染。它只是返回react element。forwardRef来拯救函数组件。
如果单纯的用fowardRef效仿类组件那么并发模式或者suspense的时候会有bug。此时就要用到useImperativeHandle
它允许父组件使用子组件的方法。
https://ui.dev/imperative-vs-declarative-programming/


### useDebugValue

### 翻译 
can get you a really long way with。。
可以帮助你


### 参考链接




