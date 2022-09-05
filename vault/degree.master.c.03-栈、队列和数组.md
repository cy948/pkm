---
id: erapkzyajwhbfxzhaepk0rc
title: 03 栈、队列和数组
desc: ''
updated: 1662005561806
created: 1661916919059
---

# 栈、队列和数组

## 栈

```c 
#include <stdlib.h>
#include <stdio.h>
#define MaxSize 50
typedef int ElemType;
```

### 定义

- 栈的顺序结构

```c
typedef struct {
    ElemType data[MaxSize];
    int top;
} SqStack;
```

栈顶指针：`S.top`，初始时设置`S.top=-1`；

栈顶元素：`S.data[S.top]`；

进栈操作：栈不满时，栈顶指针+1，再送值到栈顶元素；

出栈操作：栈非空时，先取栈顶值，再将栈顶指针-1；

> 以上的指针定义和栈顶元素可变，具体取决于题目

- 栈的链式结构



### 基本运算

#### 初始化

