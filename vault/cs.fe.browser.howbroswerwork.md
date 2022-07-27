---
id: v0eulwebulvj310yaekoodv
title: Howbroswerwork
desc: ''
updated: 1657942637043
created: 1657933482732
---

# 浏览器的工作原理

> [howbrowserswork](https://web.dev/howbrowserswork/)

## 主要功能

通过所提供的URI获取并渲染资源

## 浏览器的结构

1. 用户界面。地址栏、 前进后退、 书签等；
2. 浏览引擎。沟通UI引擎和渲染引擎；
3. 渲染引擎。渲染获取的资源；
4. 网络。调用操作系统API进行网络请求；
5. UI。
6. JS引擎。
7. 数据源。

![](https://web-dev.imgix.net/image/T4FyVKpzu4WKF1kBNvXepbi08t52/PgPX6ZMyKSwF6kB8zIhB.png?auto=format&w=571)

Chrome 会在每个独立的标签页中运行一个渲染引擎进程

## 渲染引擎

不同的浏览器使用不同的渲染引擎，如IE使用Trident，Firefox使用Gecko，Safari使用WebKit，Chrome和Opera（^15）使用Blink，WebKit的一个分支

WebKit是基于Linux的开源渲染引擎，后由苹果提供了对Mac和Windows的支持。[webkit](https://webkit.org/)

### 主要流程

![](https://web-dev.imgix.net/image/T4FyVKpzu4WKF1kBNvXepbi08t52/bPlYx9xODQH4X1KuUNpc.png?auto=format&w=439)

### 解析

![](https://web-dev.imgix.net/image/T4FyVKpzu4WKF1kBNvXepbi08t52/xNQUG9emGd8FzuOpumP7.png?auto=format&w=439)

#### HTML

![](https://web-dev.imgix.net/image/T4FyVKpzu4WKF1kBNvXepbi08t52/YYYp1GgcD0riUliWJdiX.png?auto=format&w=338)

```
<html></html>
```

Parser是一个状态机。当Parser读到`<`时， 会转到`标签开始` + `标签名称阅读模式`。意味着开始读取标签的名称， 当阅读到`>` 时， 标签名称阅读完毕。当读到`</`时，则为结束。

![](https://web-dev.imgix.net/image/T4FyVKpzu4WKF1kBNvXepbi08t52/52SA8fqorIKP6h22JHUR.png?auto=format&w=439)
