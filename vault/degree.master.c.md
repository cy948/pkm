---
id: driu64161ong6snwwlwcjjg
title: C
desc: ''
updated: 1663251764287
created: 1663086564671
---

# 食用指南

## 前置知识

- 了解指针的基本使用

- 了解字面串的基本使用

- 标准输入输出、模板串的使用

- 了解数组的使用

## 运行、编译程序

你可以选择自己所喜欢的运行环境，这里有一些文章可以帮助你配置：

- IDE高手型：拒绝复杂操作，使用开箱即用的环境：

    - 蓝桥试验环境 [官网](https://www.lanqiao.cn/) 请自行探索

    - 在线playground 此处推荐两个 [programiz](https://www.programiz.com/c-programming/online-compiler/) [onlinegdb](https://www.onlinegdb.com/online_c_compiler)

    - 在线vscode

- 自行配置：

    - 参考 [配置方法](https://zhuanlan.zhihu.com/p/197279671)

关于如何编译、运行程序：

```bash
# 编译
gcc source.c -o out.c -g

# 运行
./out.c
```

> 一般情况下，我们会将一些常用的方法以头文件的方式进行存放

```bash
//创建out文件夹存放产物
mkdir out
// 编译
gcc -c string.c -o out/string.o
```

