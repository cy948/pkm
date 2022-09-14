---
id: driu64161ong6snwwlwcjjg
title: C
desc: ''
updated: 1663118967300
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


## （可选）封装一个静态库

> 此处的目的是为了重用一些已经写过的数据结构。
>
> 在开始前，建议阅读 [C 编译过程](https://zhuanlan.zhihu.com/p/558783902)，一下我们的目标是完成对自己的静态库：libstring.a 的编译

libstring.a:
```C
#include <stdlib.h>
#include <stdio.h>

#define MAXLEN 255

typedef struct {
    char * ch;
    int length;
} HString;

void StrInit(HString * s, int size){
    if(s->ch) free(s->ch);
    s->ch = malloc(sizeof(char) * size);
    s->length = size;
}
```

编译成为汇编代码

```bash
//创建out文件夹存放产物
mkdir out
// 编译库文件
gcc -c string.c -o out/string.o
```

使用随GCC发行的AR程序生成库

```bash
//创建lib文件夹存放静态库文件
mkdir lib

ar r lib/libstring.a out/string.o
```

将`string.c`中的函数内容提取到`string.h`

```C
#include <stdlib.h>
#include <stdio.h>

#define MAXLEN 255

typedef struct {
    char * ch;
    int length;
} HString;

void StrInit(HString * s, int size);
void StrAssign(HString *s, char * c);
/*此处还有很多*/
```



尝试使用库

![image-20220914012410916](https://cdn.notcloud.net/static/md/cy948/202209140934456.png)



编译期链接

```bash
//编译
gcc source.c lib/libstring.a -o out/source.out

//运行
out/source.out
```



