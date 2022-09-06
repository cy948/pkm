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

```c
Stack * initStack(Stack * s){
    s->top = -1;
    return s;
}
```

#### 判空、判满

```c
_Bool isEmpty(Stack * s){
    return s->top == -1;
}

_Bool isFull(Stack * s){
    return s->top == MaxSize - 1;
}
```

#### 进出栈

```c
_Bool pop(Stack * s, ElemType * e){
    if(isEmpty(s)) return 0;
    * e = s->data[s->top--];
    return 1;
}

_Bool push(Stack * s, ElemType e){
    if(isFull(s)) return 0;
    s->data[++s->top] = e;
    return 1;
}
```

#### 获取头

```c
_Bool head(Stack * s, ElemType * e){
    if(isEmpty(s)) return 0;
    * e = s->data[s->top];
    return 1;
}
```

#### 打印

```c
void printS(Stack * s){
    int dummyTop = s->top;
    printf("top:%d\n",dummyTop);
    while(dummyTop + 1){
        // 此处会存在序列点问题，
        // 造成dummyTop--的副作用
        // 发生在printf函数调用参数dummyTop前
        printf("\n%d : %d", dummyTop + 1, s->data[dummyTop--]);
    }
}
```

结果：

```c
int main(){
    Stack * s = malloc(sizeof (Stack));
    initStack(s);
    push(s, 1);
    push(s, 2);
    push(s, 3);
    int dump;
    pop(s, & dump);
    printS(s);
}
/*
top:1

1 : 2
0 : 1
*/
```



## 队列

### 定义

队列是一种操作受限的**线性表**，只允许表的一端进行插入，在另一端进行删除；删除元素叫做出队或离队；其特性是 **先进先出**；以下是队列的三个概念：

- 队头（Front）。允许删除的一侧，又称队首
- 队尾（Rear）。允许插入的一侧。
- 空队列。队列中不存在任何元素。

### 基本运算

> 队列指针的定义具体视题目而定，此处preset：

- 为循环队列；
- 牺牲一个元素区分队列是否已满；
- front 指向队列中待删除的元素(第一个元素 )；
- rear 指向队列中待插入的位置；

#### 初始化

initQueue(Q * q); 初始化队列，构造一个空队列；

```c
void initQueue(SqQueue * q){
    q->front = 0;
    q->rear = 0;
}
```

#### 判空、判满、长度

- 判空条件：`q->front == q->rear`
- 判满条件：`q->front == (q->rear + 1) % MaxSize`
- 长度：`length = (q->rear - q->front + MaxSize)`

##### 判空

```c
_Bool isEmpty(SqQueue * q){
    return q->front == q->rear;
}
```

##### 判满

```c
_Bool isFull(SqQueue * q){
    return q->front == 
        (q->rear+1) % MaxSize;
}
```

##### 长度

```c
int length(SqQueue * q){
    return (
        q->rear - q->front + MaxSize
    ) % MaxSize;
}
```

#### 进、出队

##### 进队

```c
_Bool enQueue(SqQueue * q, ElemType e){
    if(isFull(q)) return 0;
    q->data[q->rear] = e;
    q->rear = (q->rear + 1 + MaxSize) 
        % MaxSize;
    return 1;
}
```

##### 出队

```c
_Bool deQueue(SqQueue * q, ElemType * x){
    if(isEmpty(q)) return 0;
    * x = q->data[q->front];
    q->front = (q->front + 1 + MaxSize) % MaxSize;
    return 1;
}
```

#### 打印

```c
int printQ(SqQueue * q){
    int i, front = q->front, \
        len = length(q);
    printf("\nlength:%d\n", len);
    for(i = 0; i < len; i++){
        printf("->%d", q->data[front]);
        front = (front + 1 + MaxSize) % MaxSize;
    }
}
```

#### 带tag的操作

> tag标志位主要用于区分队列是满还是空，此处规定：

- tag == 1 为满


初始化：
```c
typedef struct {
    ElemType data[MaxSize];
    int front, rear, tag;
} SqQueue;
void initQueue(SqQueue * q){
    q->front = 0;
    q->rear = 0;
    q->tag = 0; 
    // 0 is empty while 1 is full
}
```

##### 判空、判满、长度

- 判空条件：`q->front == q->rear && q->tag == 0`


```c
_Bool isEmpty(SqQueue * q){
    return q->front == q->rear && q->tag == 0;
}
```

- 队满条件：`q->front == q->rear && q->tag == 1;`

```c
_Bool isFull(SqQueue * q){
    return q->front == q->rear && q->tag == 1;
}
```

- 长度

```c
int length(SqQueue * q){
    if(isFull(q)) return MaxSize;
    return (q->rear - q->front + MaxSize) % MaxSize;
}
```



##### 入队 出队

```c
_Bool enQueue(SqQueue * q, ElemType e){
    if(isFull(q)) return 0;
    q->data[q->rear] = e;
    q->rear = (q->rear + 1 ) % MaxSize;
    q->tag = 1;
    return 1;
}

_Bool deQueue(SqQueue * q, ElemType * x){
    if(isEmpty(q)) return 0;
    * x = q->data[q->front];
    q->front = (q->front + 1) % MaxSize;
    q->tag = 0;
    return 1;
}
```



## 应用

### 栈

#### 表达式求值

