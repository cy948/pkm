---
id: driu64161ong6snwwlwcjjg
title: C
desc: ''
updated: 1665544645092
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


## 前言

最近被很多好朋友批评指针使用不规范，指针错误使用，常引发[SIGSEGV](https://baike.baidu.com/item/SIGSEGV/7360054)；于是重学指针、`malloc` `free`，得出的规范如下：

### 规范

#### 指针创建的三种可能

避免未初始化指针的使用，指针的使用只有三种可能：

```c
int main(){
    // 初始化为空指针
    BiTNode * node = NULL, other;
    // 初始化为其他指针
    BiTNode * nodeOther = & other;
    // 为指针分配堆内存
    BiTNode * nodeHeap = malloc(sizeof(BiTNode));   
}
```

#### 指针使用的几种规范

1. 作为函数参数时：

- 作为形参时，传入方法的实际上是原值的一个副本，修改副本不影响原值；

- 不修改该指针本身，因为不生效；

```c
void asParams(BiTNode * e){
    BiTNode * inHeap = malloc(sizeof(BiTNode));
    e = inHeap;
}
```

2. 作为参数返回值时：

- 只能返回在堆中分配的地址，或者传入的地址；
- 不返回当前方法栈中的地址；

```c
void * asRetValue(){
	BiTNode inFuncStack = {1, NULL, NULL};
	// return & inFuncStack // 不要返回这种指针；
    BiTNode * inHeap = malloc(sizeof(BiTNode));
    // 应该返回inHeap
    return inHeap;
}

```



#### 内存分配和释放规则

- 有`malloc`必有`free`；如果handle消失，该内存板块将无法被GC；
- 有`free`必有`NULL`；如果handle所指区域已被free后无法再次写入，如果不置为`NULL` 标记为失效容易产生`SIGSEGV`;

####  综合实例：“传递一个引用进方法，通过引用返回数据” 

> 注意，在函数调用中修改指针是没有用的

```c
BiTNode * GetNode(BiTNode * e){
    /*some magic*/
    // 实际上，此种方法在！返回值不为BiTNode *时！造成无法回收的问题
    BiTNode * inHeap = malloc(sizeof(BiTNode));
    
    // 如果返回值不为BiTNode，推荐：
    BiTNode inFuncStack = {1, NULL, NULL};
    // 对应地，这种方法下不能返回方法栈中的地址
    // return & inFuncStack;
    
    // 可以通过传入的指针修改所指向的内存区域
    // 这个操作有前提，那就是该区域必须是可用的，已被分配的；
    * e = * inHeap;
    
    // 在方法中单纯地修改指针是无效的
    // 因为传入方法时，是拷贝的形参，单纯地对形参修改无法达到效果；
    // 以下因此，这句话的作用仅限于在方法GetNode内，对外界无影响
    e = inHeap;
    return inHeap;
}
int mian(){
    
    BiTNode e; 
    //在程序参数栈中分配一个变量e的空间；
    GetNode(& e);
    Visit(& e);//可以正常被使用
    
    // 以下则不能，因为指针所指向的地方未被分配空间
//    BiTNode * foo; //也不合法
    BiTNode * foo = NULL;
//    GetNode(foo); //无法访问到
    
    * foo = malloc(sizeof(BiTNode));
    GetNode(foo); //此处可行,因为空间已被分配
    //有malloc必有free
    if(foo != NULL) {
        free(foo);
        //有free必有NULL
        foo = NULL;
    }
}
```

