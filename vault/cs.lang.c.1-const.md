---
id: 6x26300ylru39s68sv1rjzn
title: 1 变量
desc: ''
updated: 1659589885478
created: 1659532808616
---

# Chapter1 变量和表达式

## 变量

### “存储区”和“类型”

`存储区` 里面可以储存二进制的内容，但如果不指定内容的含义，便无法解析。需要指定内容的 `类型` 。指定里面的内容是什么符号的什么进制数字。

![](https://cdn.notcloud.net/static/md/cy948/202208032128653.png)

如：使用 `int` 去指定存储区 `obj` 里内容的类型，完整的声明是： *声明一个符号obj，该符号所指示的存储区用来容纳int类型的数据，要用int类型来访问（读和写）*

```c
int obj;
```

![](https://cdn.notcloud.net/static/md/cy948/202208032132607.png)

obj的作用仅仅是符号，而变量是在程序运行时才会确定下来的存储区。严格地说，我们只是在编写程序的时候用一个符号来指示或者表示一个尚不存在的变量，即“obj所指示的变量” 而不是像汇编语言那样直接指示：“位置0x7c00”所指示的变量；

### “变量”是存储区

在C标准文档的正文中，不使用“变量”一词，而代之以“对象”。这不是（C++/Java）里的对象。我们约定，“变量”的含义和C标准文档里的“对象”等同，都是指一个存储区，可用来保存 `值` 。

### “值”是计算机操作和加工的对象

存储在计算机中的、用特定类型来解析的、精度意义上的内容；


### 有符号类型和无符号类型

> 在计算机内部，整数的存储和运算有两套方法，一种是不考虑它们的符号，数字在存储时没有符号信息，所有的比特都用来表示数字的大小；另一种则是将是苏子区分为正负，数字存储时带有符号信息，用 **1** 个比特来表示符号。

所以在C语言里，标准有符号整数类型包括：

```c
signed char;
signed short int;
signed int;
signed long int;
signed long long int;
```

- `signed char` 类型可以表示的数据范围是： -127 ~ +127；-(2^7 - 1) ~ +(2^7 - 1)；

- `signed short int` 类型可以表示的范围： -32767 ~ +32767；-(2^15 - 1) ~ +(2^15 - 1)；这只是最低限度，具体取决于计算机； 在表示时，`signed short` 的 `signed` 可以省去，写成 `short`；

- `signed int` 类型可以表示的范围： -32767 ~ +32767；-(2^15 - 1) ~ +(2^15 - 1)；这只是最低限度，具体取决于计算机；

- `signed long int` 可简写为 `signed long` `long int` 或者 `long` ，类型可以表示的范围： -2147483647 ~ +2147483647；-(2^15 - 1) ~ +(2^15 - 1)；这只是最低限度，具体取决于计算机；


> int占一个机器字长。在32位系统中int占32位，也就是4个字节，而在老式的16位系统中，int占16位，即2个字节。而C++标准中只限制规定short int不能超过int的长度，具体长度的可以由C++编译器的实现厂商自行决定。目前流行的32位C++编译器中，通常int占4字节，short int占2字节。其中short int可以简写为short。类似地，C++标准只限制了long int不得小于int的长度，具体也没有作出限制。

> 为什么这些整数类型表示的数值范围不能固定下来，而仅仅是保证一个最基本的取值范围？ 这是因为不同计算机系统具有不同的字长， C语言的发明者希望整数类型可以**弹性适应具体计算机系统**。比如 `int` 类型，16位计算机可以表示-32767 ~ +32767，32位计算机可以表示 -2147483647 ~ +2147483647。如果需要写**跨设备适配**的C语言程序，则需要遵守这个“最低取值范围”限制。

无符号整型包括：

```C
unsigned char; // 255 (2^8 -1)
unsigned short int; // unsigned short 65535(2^16 - 1);
unsigned int; // unsigned 65535(2^16 - 1);
unsigned long int; // unsigned long 
unsigned long long int; // unsigned long long (2^64 - 1)；
```

省略的规则： `signed` 和 `int` 可以被省略；

`_Bool` C99 后引入，只表示 0 or 1；

### Checkpoint

![](https://cdn.notcloud.net/static/md/cy948/202208032234861.png)

## 表达式

- 语句用于指定程序运行时应当执行的动作；

- 有多种类型的语句，表达式语句是其中的一类；

- 表达式语句由表达式和末尾的分号“;”组成；

- 表达式是由子表达式通过运算符连接而成，他们被视为运算符的操作数；

- 有各种不同类型的表达式，赋值表达式是其中的一类；

例如：

```C
while (/*表达式 */) /*语句*/;
```

### 左值和左值转换

原则上，指示一个变量的表达式称为左值。**左值是可寻址的，是代表`变量`的表达式**。

当左值是赋值运算符的左操作数，则不发生左值转换。


## Checkpoint 1.2

1.什么是左值？如果声明了一个变量m,则对于表达式m=3,m是左值吗？3 是左值吗？为什么？
> 左值是指示或者说代表变量的表达式。m是左值，因为它代表我们声明的变量。3不是左值，它只是一个数字。

2.选择题：表达式num=26的意思是( ),它在程序运行时执行的动作是()

A.将数值26写入变量num
B.将数值26赋给左值num
c.变量num存储的内容是26

> 解析：b所描述的是表达式的含义，不是程序运行时的动作；c所描述的是程序运行时，数据保存动作执行后的结果，不符合题意。

3.什么是左值转换？为什么要进行左值转换？

> 除了少数情况外（比如作为赋值运算符的左操作数），一个左值会转换为它所代表的那个变量的存储值，这称为左值转换。因为很多运算要求参与的操作数必须是数值，如果是左值，必须先转换为变量的存储值。

### 表达式的值

表达式的作用是算术或者逻辑运算，既然是运算，得算出一个结果。每个表达式都可以计算出一个值。对表达式 `n <= 100` 来说，它由子表达式`n` 和 `100` 组成，子表达式n要计算出一个值。对表达式`n <= 100` 来说，它由子表达式`n` 和 `100`组成，子表达式`n` 需要计算一个值，这个值是左值转换后的值；子表达式`100` 也要计算一个值，即二进制的`0x64`


### 运算符的优先级

#### 结合方向

从左往右结合的运算符 `+` ，虽然先计算 `1+2` 但是先计算 `1` 还是 `2` 没有规定；

```C
int sum;
sum = 1 + 2; // 先计算 +
```

从右往左的运算符 `=`

```C
int sum, n;
sum = n = 0;
```

#### 操作数的值计算必须先于运算符的值计算

表达式的值也被认为是运算符的值或者运算符的结果。计算表达式的值，被称为表达式的值计算。C语言规定，操作数的值计算必须先于运算符的值计算。

比如表达式 `n <= 100` 因为运算符 `<=` 的操作数是 n 和 100，所以是先计算操作数 n 的值，也就是先进行左值转换，然后再开始计算 `<=` 的值；


#### Checkpoint

练习1.3
1,给定表达式a=b+c,请判断下面的说法是否正确：
(a)运算符+的结果也是表达式b+c的值。(√)
(b)运算符=的值也是表达式a=b+c的值。(√)
(c)运算符+的优先级比=高。(√)
(d)这是一个赋值表达式。(√)
(e)要计算运算符+的值，必须先计算操作数b和c的值。（√)
(f)先计算b的值，再计算c的值，然后计算运算符+的值。(x)

[[#结合方向]]

2.若n是一个int类型的变量，且其值为0，则以下(B E)是表达式；（D）是语句；表达式`n=1+n` 的值为( n + 1 )。
A.n+
B.n+1
C.n=
D.n;
E.n +n

3.表达式语句由（表达式）和（ `;` ）组成。

4.while语句由关键字（ B ）位于圆括号中的（ D ）入作为循环体的（ E ）组成。
A.分号
B.while
C.While
D.表达式
E.语句

5.若m是一个int类型的变量，则以下(BCD)是语句。
> 表达式是一种语句

[[##表达式]]

A.m
B.m;
C.m+1;
D.m=m+1+m;