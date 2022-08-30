---
id: yj92tn2wp6l2poj7xu2922d
title: 6 输入输出
desc: ''
updated: 1660295040849
created: 1660121562364
---

# 输入输出

## 系统调用

在C语言中嵌入汇编代码，直接进行系统调用；

```c
int main (void){
    int r;
    __asm__ (
        "mov eax, 0x4 \n\t"
        "mov ebx, 0x1 \n\t"
        "mov edx, 0xd \n\t"
        "int 0x80 \n\t"
        : "=a" (r)
        : "c" ("hello.\n")
    );
    return r;
}
```

- 通过`0x80` 中断提供系统调用服务，根据`linux` 系统要求使用`eax`寄存器指定子功能，`0x4` 是写文件和设备；GCC允许的格式之一是将每一行汇编以`\n\t` 结束，并用`""`围住。

- 然后通过`ebx`寄存器指定文件设备，`0x1` 是控制台屏幕；
- `edx` 用于指定写入字符的数量；

**指定写入的内容**：将一个字符数组的地址传递到`ecx`寄存器即可；嵌入式汇编的价值在于它允许寄存器和C语言里面的变量交换数据，但要使用`:` 开头以表示区别；

第一个`:`用于指定输出功能。当系统调用返回后，实际写到屏幕的字符由`eax` 寄存器返回。然而我们已经声明了一个`int`类型的变量`r`，并希望这个字符数保存到变量中：

```c
__asm__(
	: "=a" (r)
)
```

相当于C语言中的表达式：

```c
r = a
```

意思是把`eax`寄存器的内容传送到变量r。等号`=`表示具有破坏原内容的写操作，对`Intel x86` 来说，“a”代表`eax`寄存器；

第二个`:`用于指定输入功能，比如将变量的值传送到寄存器。因此：

```c
__asm__ {
	: "c" ("hello\n")
}
```

的作用是把字符串的首地址传送到`ecx`寄存器，对32位`intel x86`来说，`"c"`是`ecx` 寄存器。字面串`"hello \n"` 首先被用于创建一个不可见数组，然后执行数组——指针转换，并把这个指针的类型的值（地址）传送到`ecx` 寄存器；



最后，汇编指令`int 0x80` 用于发起一个软中断，处理器执行这条指令后，将进入中断处理过程，进入操作系统内部执行。

![image-20220810173358954](https://cdn.notcloud.net/static/md/cy948/202208101733004.png)

### `-masm` 翻译选项

```bash
gcc c0601.c -o c0601.out -masm=intel
./c0601.out
```

`-masm=intel` 意思是使用intel公司的汇编格式；

### 封装打印`char` 数组的函数

```c
int write_string(char * s){
    int l = 0, r;
    
    for (char * p = s; * p ++ != '\0'; l ++);
    
    __asm__ (
        "mov eax, 0x4 \n\t"
        "mov ebx, 0x1 \n\t"
        "int 0x80 \n\t"        
        : "=a" (r)
        : "c" (s), "d" (l)
    );
    
    return r;
}
```

## 编译和链接

### 封装

当前的打印功能可以封装成一个工具：

```c
/******************iotool.c*****************/
int write_string (char * s)
{
    int l = 0, r;

    for (char * p = s; * p ++ != '\0'; l ++) ;

    __asm__ (
                "mov eax, 0x4 \n\t"
                "mov ebx, 0x1 \n\t"
                "int 0x80 \n\t"
                : "=a" (r)
                : "c" (s), "d" (l)
              );

    return r;
}

char * ull_to_string (unsigned long long int n, char * s)
{
    int x = 0;
    char buf [20], * p = s;

    do
        buf [x ++] = n % 10 + '0';
    while (n /= 10);

    do
        * p ++ = buf [-- x];
    while (x);

    * p = '\0';

    return s;
}

unsigned long long int cusum (unsigned long long r)
{
    unsigned long long int sum = 0;

    while (r) sum += r --;

    return sum;
}

```

### 调用

虽然不需要再次写这三个函数的函数体，但仍然需要进行声明，否则会引起编译器错误；

```c
/******************c0603.c*******************/
int write_string (char *);
char * ull_to_string (unsigned long long int, char *);
unsigned long long int cusum (unsigned long long);

int main (void)
{
    write_string ("1+2+3+...+1000=");

    char a [20];

    write_string (ull_to_string (cusum (1000), a));
    write_string ("\n");
}

```

### 编译期链接

一个C程序可以由多个源文件组成。翻译时，C实现将分别翻译源文件，并把它们链接到一起生成可执行的程序。但是，这里的“分别翻译”是有讲究的。

1. 第一个阶段是：编译，对文件的内容进行语法分析，进而生成对应的机器指令。但是对有些实体（如：函数）的解析是无法完成的，因为它们可能并不是在当前源文件内定义的。在这种情况下，C实现将记下这些名字，以及它们的属性（形参及返回参数），等到以后再说。该阶段的成果并不是最终的可执行文件，而是目标文件；
2. 第二阶段是链接，是将前面生成的目标文件链接起来，得到最终的可执行文件，这个阶段将要处理未决的符号（如函数），找到它们的定义。除此之外，还要链接一些与操作系统有关的代码，这些代码对于能否让在生成的可执行程序在操作系统上允许至关重要；

```bash
# 编译
gcc -c c0603.c
gcc -c iotool.c -std=c11 -masm=intel

# 链接
gcc c0603.o iotool.o -o c0603.out

# 运行
./c0603.out
```

`-c` 选项：将文件编译成目标文件（“-o”），一旦位C实现指定了目标文件，则会将这些目标文件链接在一起；

一步到位的操作：

```bash
gcc c0603.c iotool.c \ 
	-o c0603.out \
	-std=c11 \
	-masm=intel
```

## 库

如果一些函数特别有价值，别人都用得上，或者它包含了特殊的算法和秘密，则可以将它们打包成可复用的库。库是包含了机器代码的文件，但它不能单独执行，因为它只是一个功能包，并不具备成为可执行文件所必须的其他组成部分和相关信息。

### 从目标文件生成库

#### 静态库

使用随GCC发行的AR程序，如：

```bash
ar r libiotool.a iotool.o
```

这将从目标文件iotool.o中提取函数，并将它们加入库文件libiotool.a。参数`r`的意思是在库中加入新的函数，如果已经有同名函数则覆盖它。库的名字可以随意指定，建议用“lib”开头，".a"为拓展名；

#### 动态库

和静态库不同，linux 里的另一种库是共享库。共享库在链接时，仅在可执行文件中放一个存根，并不将库中的代码链接到可执行文件中。在这种情况下，生成的可执行文件和动态库有依赖关系，程序执行时，根据需要，可能会加载和执行共享库中的代码。使用共享库不但可以减小可执行文件的体积，也有利于代码的升级。当共享库发行更新的版本时，可以直接替换旧的共享库，而不影响可执行文件：当可执行文件调用共享库的代码时，
执行的是升级后的代码。

以下，我们演示了如何生成共享库，并将它链接到用源文件c0703.c所生成的可执行文件中：

```bash
gcc -shared -o libiotool.so iotool.o
```

`-shared` 用于生成共享库，`-o` 用于指定共享库的名字，可以以"lib"开头，"so"结尾；

```bash
gcc c0603.c libiotool.so -o c0603.out
```

用于使用共享库和源文件c0603.c一起生成可执行文件

```bash
export LD_LIBRARY_PATH=./

./c0603.out # 执行
```

由于可执行程序需要共享库的支持，所以必须要将共享库的位置加入库的搜索路径，否则无法找到。用`export` 命令将当前目录加入搜索库路径的 **环境变量** `LD_LIBRARY_PATH` ；

## 头文件、预处理和翻译单元

>  上述演示了库文件的创建，以及如何在我们的程序中链接库文件。上述有个缺点是：想要用库中的函数，必须现在程序中做不带函数体的声明。在链接阶段，C实现自然会从库中找到这些函数的实现；但库的内容不是人工可以读的，拿到别人的库时，往往不知道怎么使用，更不要谈“声明它”；

库在对外发行的时候，应该同时发行一个头文件。类似于C源文件，头文件是一个文本文件，其最核心的内容是一些声明，比如对库文件里的函数进行声明，按照约定，头文件的后缀是".h"，想要发布"libiotool.a"或者"libiotool.so"，头文件是"iotool.h"，内容如下：

```c
/*iotool.h*/
int write_string(char *);
char * ull_to_string 
    (unsigned long long int, char *);
unsigned long long int cusum
    (unsigned long long);
```

一旦拿到上述头文件，则可以开始进行引入：

```c
/*********************c0604.c*******************/
# include "iotool.h"

# define CHAR_BUF_LEN 20
# define MAX_SUM_NUM 1000
# define FIXED_SUFFIX(x) "1+2+3+...+" #x "="
# define PRN_FIXED_SUFFIX(x) FIXED_SUFFIX(x)

int main (void)
{
    write_string (PRN_FIXED_SUFFIX(MAX_SUM_NUM));

    char a [CHAR_BUF_LEN];
    write_string (ull_to_string (cusum (MAX_SUM_NUM), a));
    write_string ("\n");
}

```

### `#` 预处理命令

预处理指令以`#` 开头，这样就可以将它们与不需要或者不参与预处理的其他文本区分开来。以“`# include` ”打头的预处理指令是源文件包含指令，后面跟一个尖括号“`<>`”或者双引号“`""`”围起来的文件名。在预处理期间，C实现将用该文件的内容来取代这条预处理指令。每个预处理指令都需要独立成行；

#### 宏定义

对于规模较大的程序来说，需要定义一些“关键变量（const）”，`# define` 开头的是宏定义，宏定义分为两种，第一种是变量式的宏定义，`define` 后面的标识符被称为宏名，宏名后面的内容（不好括前后的空格和末尾的换行符）称为替换列表。

```c
# define CHAR_BUF_LEN 20
```

这里的标识符 `CHAR_BUF_LEN` 是宏名，他是替换列表“`20`”的另一个“别名” “标识”，在程序翻译期间，会进行替换

```diff
- char a [CHAR_BUF_LEN];
+ char a [20];
```

但字面串并不能像上面那样。

定义函数：

```c
# define ADD(a, b) (a) + (b)
```

`ADD` 的宏名，`a` 和 `b` 是宏的参数，参数之间用逗号`,` 隔开，此宏一旦定义，则宏调用`ADD(10, 20)` 被拓展为`(10) + (20)`。和函数定义和调用一样，为明确所指，宏定义的参数称为形参，宏调用里的参数为实参；

注意，宏定义里的宏名和组成参数列表的括号之间不能有空白，否则会被视为一个变量定义，宏名之后的部分被视为替换列表；

在函数宏定义中，如果替换列表中有“`#`”，且它后面紧跟着当前宏的形参，则他们在预处理期间被转化为一个字面串，且该字面串是由与该形参对应的实参转化未来，这成为记号串化；

```c
#define STR(x) #x;
```

宏调用`STR(hello) ` 会被拓展为字面串“`hello`”，这个字面串在后续的编译和链接期间会被作为普通串处理。

在函数式定义中，如果替换列表中有"`##`"，且它位于两个记号的中间，则两个记号会被合称为一个记号；如果这两个记号是宏的形参，则将会把它们对应（传入）的实参合并为一个记号，这成为记号黏接。

```c
# define MAKEIDEN(x, y, z) x##y##z
```

则宏调用会被替换为：

```diff
- char MAKEIDEN(a, b, c);
+ char abc;
```

在后续的编译和链接期间，这个拓展的结果会被当成普通的声明一样处理，即，声明一个`char` 类型的变量`abc`；

回到程序中，由于出现在函数式宏定义中的参数才能转化为字面串，所以我们使用了如下宏指令：

```c
# define FIXED_SUFFIX(x) "1+2+3+...+" #x "="
# define PRN_FIXED_SUFFIX(x) FIXED_SUFFIX(x)
```

在预处理阶段，对宏调用的处理是对实参进行宏扩展，然后再对宏调用本身进行拓展。因此，在我们的预期中，一下宏调用：

```c
write_string(FIXED_SUFFIX(MAX_SUM_NUM));
```

将先把`MAX_SUM_NUM` 拓展为1000，接着再扩展宏调用`FIXED_SUFFID(1000)` 最终得到一个黏接的字面串

```
"1+2+3+...+" "1000" "="
```

然而，在函数式宏定义的替换列表（宏体）中，如果形参前面是"#"或者"##"，又或者后面是"##"，则调用此宏时，传入的实参并不拓展。因此，上述宏调用实际上会被拓展为L

```
"1+2+3+...+" "MAX_SUM_SUM" "="
```

对此，比较标准的解决方法是：先顶一个替换列表中没有的"#"或者"##"的宏，这样就可以将拓展后的实参传进来，然后再将拓展后的实参传递给前面所定义的宏`FIXED_SUFFIX` ：

```c
# define PRN_FIXED_SUFFIX(x) FIXED_SUFFIX(x)
```

在正式编译一个C程序之前，要先进行预处理。预处理之后，所有的预处理指令都被删除，源文件经过预处理之后就得到了翻译单元。换句话说，对源文件进行预处理的成果是生成了翻译单元；

在实现将一个源文件翻译成可执行文件的整个过程里，如果没有特别的指示，翻译单元指示翻译过程早期的一个临时文件，用于后续的编译过程，用完就删。需要`-E` 参数停止翻译过程并显示预处理过程的结果：

```bash
gcc -E c0604.c
```

![image-20220811224642175](https://cdn.notcloud.net/static/md/cy948/202208112246228.png)

`-E` 选项的意思是在预处理之后立即停止翻译过程，不进行后续的编译过程。在输出的内容里有一些行标记信息，我们用斜体显示，如果要想将预处理的结果保存为文件，可以用“-o”选项指定一个文件名；

无论如何，经过预处理之后，在生成的翻译单元格将不再包含预处理指令，头文件的内容也已经包含进来，而所有的宏也已经被展开，整个翻译单元仅剩下声明和函数定义。

### Checkpoint6.1

给定宏定义

```c
# define pst(x, y, z) x##y##z
```

则宏调用`pst (_, int, _)` 拓展之后的结果是什么？如果想要得到`_int_` ，则应当如何修改宏定义？

```c
# define pst
```

## UNIX和类UNIX函数库

C和Unix是近亲，最初发明C是为了重写Unix，Unix系统调用使用C库封装进行使用。因兼容需要，IEEE牵头建立一个标准，POSIX，对Unix的各个分支加以规范和认证，其中包括C语言的函数库。

统一后的Unix编程接口按功能进行分类，并以头文件的形式发布。库函数的具体实现，有些库函数是Unix系统调用的封装，而有些库函数不依赖于系统调用而独立存在，如：计算字符串长度，可以用C或者汇编实现。

### 限定的类型

```c
int open(const char * pathname, int oflag,...);
```

函数`open` 的第一个参数用于指定要创建或者打开的文件名，故其类型是指向char的指针，用于指向一个字符串。但事实上，该参数的类型并不是指向char的指针，二是指向`const char` 的指针?

C语言里的类型，从所描述的实体来分，可分为变量类型和函数类型，而变量类型又拥有它们的限定版本。也就是说，它们可以用一些关键字如：“const”等加以限定，从而形成各自的限定版本，而这些关键字称为类型限定符。例如，`const int` 是int类型的限定版本；

`const` 的意思是：只读，只用于读出而禁止写入；

```c
const unsigned int cx = 0;
```

这就声明一个`const unsigned int` 类型的变量`cx` 并初始化为0。如果一个变量的类型是`const` 限定的，这种限定不影响它的初始化，但不允许写入操作。因此，下面的语句是非法的，将导致它的程序里无法通过编译；

```c
cx = 65533;
```

> 缓存的意义：如果仅仅是为了限制写入一个变量，则发明关键字“cosnt”是没有任何实际用处的，因为我们可以直接使用常量，比如整型常量和字符常量；即使担心同一个常量被多处使用而难以维护，也可以通过宏定义来解决。实际上，它真正的用处和目的是对程序的翻译进行优化。

我们知道，处理器内部的寄存器速度最快，外部存储器的速度则慢得多。如果一个变量仅用于读出（而不是写入），则它的值只读一次即可，不必在每次用到变量的值时，都真的执行一次存储器读出操作。换句话说，它只需要在开始的时候读一次，然后在寄存器里缓存这个值即可。

但是，C实现需要程序员给出一个字面上的保证，以表明自己不会写入某个变量，这就是关键字“const”。如果一个变量具有const限定的类型，则意味着程序员不准备写入这个变量，而只是读它的值，因此，C实现可以尽可能地多做一些优化。比如，它可以在第一次访问变量的同时将它的值缓存起来，以后只需要使用这个缓存值而不需要在读取操作上浪费时间。

指针所指向的类型和数组类型也可以是限定的类型。因为数组的类型其实是其元素的类型，所以，声明一个限定类型的数组也就意味着它的元素也具有相同的限定的。在实例中，数组 `ca` 是具有2个`const int`类型的元素的数组，而指针`pc` 则是指向`const int`类型的变量的指针；

```c
const int ca [2];
const int * pc = ca;
```

对`pc` 的声明应该从标识符开始，一次往左读为“变量PC的类型是指针，该指针指向const int” 或者说：“变量pc的类型是指向const int的指针”；

![image-20220812111853341](https://cdn.notcloud.net/static/md/cy948/202208121118384.png)

变量`pc` 的声明中，作为初始化器，数组`ca` 转换为指向其首元素的指针。类型为`const char *`，以下语句是非法的：

```c
* pc = 77;
ca[1] = 103;
```

这里，左值`pc`的类型是`const char *` 经左值转换的得到同类型的指针（指），故表达式`* pc` 也是一个左值，类型为`const char` 指示一个`const char` 类型的变量，实际上是数组`ca` 的元素，该变量不可写；

虽然使用`const` 限定的类型来声明变量能够增强程序的可读性并在一定程度上保护变量值不被破坏，然而并非完全保护，如：

```c
const int c = 0;
```

因为变量`c` 的类型是`const int` 故下面的语句是非法的

```c
c = 1;
```

但是，可以用一元`& `运算符得到一个指向`c` 的指针，然后通过转型表达式得到一个指向`int` 的指针，并通过这个指针来简介修改`c`的值；

```c
* (int *) & c = 123;
```

这里，表达式`& c`的结果是指向`const int`的指针`const int *`； 转型表达式`(int *) & c` 强制将其类型转为`int *`，然后`*` 作用于指针，得到一个左值，实际上代表变量`c`；

>  这样做在语法层面没有问题，但`const` 变量可能加载到一个被程序限制的“不可写”区域或写入不立即生效的区域，引发未定义行为；

#### Checkpoint6.2

对于上述变量`c`，既然通过类型转换就可以突破`const ` 的限制写入变量，那为什么以下操作不可以呢？

```c
(int) c = 1003;
```

> 这个直接对变量的左值类型进行转换，是不合法的；

如果一个扁你狼类型是指针，那么，不但它指向的类型可以是限定的，而且这个指针本身也可以是限定的。

```c
int c = 0, d = 0;
const int * const cpc = & c;
```

![image-20220812163502509](https://cdn.notcloud.net/static/md/cy948/202208121635544.png)

从标识符`cpc`开始，一次向左读为“`cpc`的类型是const指针，（该指针）指向const int”，或者说“变量`cpc`的类型是一个指向`const int`类型的const指针”。所以，`cpc` 的类型是`const int * const` ，即指向`const int`的`const`指针变量；

像`cpc`这样的变量，不但不允许通过它写入的值所指向的那个变量，而且也不允许修改它本身的值。换句话说，变量`cpc`只能在声明的时候初始化为指向某个变量，此后不允许再指向别的变量，也不允许修改它的值所指向的变量。因此，以下语句非法：

```c
cpc = & d;
* cpc = 123;
```

函数的形参也可以被声明为限定的类型。再下面程序中，函数`preld` 有两个参数`cpc` 和 `ci` 。形参`cpc` 是`const` 限定的指针变量，形参`ci`是`const` 限定的整型变量。

```c
int preld(int * const cpc, const int ci){
    return * cpc + ci;
}
```

虽然形参是限定变量，但在调用函数传入形参的时候，并不受限制，可以正常赋值，但在函数内部不允许修改；

#### Checkpoint6.3

1. 若变量ac是具有5个元素的数组，且元素类型为指向const char的指针，请写出它的声明。

```c
const char ac [5];
```

2. 若变量ca是具有5个元素的数组，且元素类型为指向const char的const指针，请写出它的声明。

```c
const char * const ca [5];
```

3. 若变量p是一个const指针，指向一个5元素的数组，数组的元素类型为指向const char的指针，请写出p的声明。进一步地，如果元素类型为指向const char的const指针呢？

```c
const char * const p [5];
```

### 变参函数

```c
int open(const char * pathname, int oflag,...);
```

回到`open`函数，它的第二个参数用于指定文件打开的方式，比如是创建文件呢，还是纯粹打开文件；如果是创建文件，则文件已经存在怎么办；打开文件的目的是只读还是读写，这个参数类型是int；

仔细观察，函数`open`的声明和我们学习过的函数不同，它的末尾是“...”，意味着后面还可以有其他更多的参数。这样的函数，它们在参数类型和数量上不确定，称为“**变参函数**”或“可变参函数”。**变参函数**至少有一个类型确定的参数，而且必须是最开是参数，后面的参数无法确定。因为这个原因，参数类型列表必须以`, ...` 结尾；

下面是一个使用变参函数的例子，但它有一定的特殊性，那就是只能在某些特定的计算机上正确执行，比如基于32位Intelx86处理器的计算机系统。至于原因，我们后面将会讲到，而且还将提供一个安全、通用的解决方案。

```c
/*****************c0606.c*****************/
long long int sum_ints (unsigned int count, ...)
{
    int * var_start = (int *) & count + 1;
    long long int sum = 0;

    while (count --) sum += * var_start ++;

    return sum;
}

int main (void)
{
    long long int x, y, z;

    x = sum_ints (2, 100, 200);
    y = sum_ints (0);
    z = sum_ints (5, 10, -10, 30, 600, -300);
}
```

在程序中，`sum_ints` 是变参函数，用于累加传入的整数，**C语言规定每个函数的参数数量上限不小于127个**。

在基于32位Intelx86平台处理器的系统中，C实现会确保变参函数的参数是按顺序传递并集中保存至一个特定的存储区里，函数嗲用着把需要传递的参数存放在这里，而函数也从这里取得参数的值（访问参数变量）。因此，只需要获得第一个参数的地址，就能访问剩余的参数；

![image-20220813111131301](https://cdn.notcloud.net/static/md/cy948/202208131111345.png)

#### 手工获取可变参数

- 生成一个指向第一个变量count的指针，并将这个指针移动到变量count之后，使其指向第一个可变参数，用来初始化变量var_start:

```c
int * var_start = (int *) & count + 1;
```

先来看初始化器`(int *) & count + 1`， 一元`&` 运算符的优先级最高，转型运算符次之，加性运算符`+` 的优先级最低。表达式`& count` 是生成一个指针，指向值为2的参数变量。这个指针+1就得到一个新指针，指向第一个参数变量；

指针的类型决定了能从所指向变量里读取什么样的值，表达式`& count` 的类型是指向`unsigned int` 的指针，但我们需要一个指向`int` 的指针，因为后面的变参都是`int`类型。为此，需要用转型表达式将表达式`& count` 的值从指向`unsigned int`类型的指针转换为指向`int`的指针；

```c
while (count --) sum += * var_start ++;
```

`while` 语句用于利用使用者指定的参数个数依次读取参数并进行计算；

#### 通过stdarg库获取可变参数

但上述方法存在问题，没有考虑到跨平台的兼容性，先不说每个可变参数是否是挨在一起，变量的对齐也是一个问题。stdarg库符合POSIX标准，提供了获取可变参数的实现；下面将使用该库改善可移植性：

```c
/*****************c0607.c****************/
# include <stdarg.h>

typedef long long int VARF (unsigned int, ...);

int main (void)
{
    long long int x, y, z, m, n;

    VARF sum_ints;
    x = sum_ints (2, 100, 200);
    y = sum_ints (0);
    z = sum_ints (5, 10, -10, 30, 600, -300);
}

long long int sum_ints (unsigned int count, ...)
{
    long long int sum = 0;

    va_list ap;
    va_start(ap, count);
    while (count --) sum += va_arg(ap, int);
    va_end(ap);

    return sum;
}

```

在该程序中，源文件包含指令`# include`的用法和前面的不一样：

```c
# include "iotool.h"
```

这里用的是双引号，而当前程序中用的是尖括号。预处理指令`# include` 指明了要包含的文件，预处理器需要知道文件的位置。C实现都会提供一些流行的函数库，有针对Unix和类Unix 的POSIX函数库等等，这些库文件的头文件会出现在特定位置，由C实现定义的位置；

- 如果由`<>`围住的，C实现将找到这个实现定义的位置去寻找它；
- 如果是由`""` 围住的，则C实现会用别的方法寻找它，如：在当前目录下寻找，如果找不到再当成`<>`围起来的文件名处理；

可移植性：我们知道C语言具有非凡的可移植性，用它编写的程序，能够在不同的计算机系统上翻译和执行。但是，说白了，所谓的可移植性，就是在那种计算机系统上有可用的C实现，能够将程序翻译成符合那个计算机系统的可执行程序。

>  所谓C语言具有很强的可移植性，无非就是有很多好事者为各种不同的计算机系统编写了大量的C实现。

定制性：C实现也是程序，为一种计算机系统提供的C实现不能在另一种不同的计算机系统上工作。就像你不能把windows上的Word文字处理软件拿到Linux上运行一样，为Windows提供的C实现不能在Linux上运行；GCC的Linux版本也不能直接拿到Windows操作系统上运行；Gcc的64位Linux版本也不能拿到32位的Linux操作系统上开工。

> 所以，C实现具有“定制性”的特征，你要安装C实现，第一步就是选择适合你当前计算机系统的那个版本。由于这个原因，不同的C实现就可以针对它所运行的计算机系统来定制一些内容。

##### 类型定义

```c
long long int sum_ints (unsigned int count, ...)
{
    long long int sum = 0;

    va_list ap;
    va_start(ap, count);
    while (count --) sum += va_arg(ap, int);
    va_end(ap);

    return sum;
}
```

在`sum_ints`函数中，先声明了一个`va_list`类型的变量`ap`，用来保存指向参数的指针，相当于我们前面的`var_start`。不同的计算机系统上有不同的C实现，而`va_list`的定义则随C实现的不同而有所变化。在基于32位intelx86处理器的计算机系统上，C实现有可能将它定义为：

```c
typedef char * va_list;
```

`typedef`是C语言的关键字，它唯一的作用是类型定义，也就是将一个标识符定义位它被声明的那种类型。完成类型定义后，可以使用这个类型变量：

```c
va_list vla; // 等价于 char * vla;
va_list func(va_list); // 等价于 char * func(char *);
```

可以定义任何类型的别名。如：

```c
typedef int DWORD;
typedef DWORD dWord;
typedef char * PCHAR;
typedef int ARRAY [255];
typedef int FUNC (int, int);
```

以上：

- 第一行是将标识符DWORD定义为int类型的别名；
- 第二行是将标识符`dWord`定义为`DWORD`类型的别名，实际上也是`int`的别名；
- 第三行是将标识符`PCHAR`定义为`char *` 类型的别名；
- 第四行是将标识符`ARRAY` 定义为数组类型`int [255]`的别名；
- 第五行是将标识符`FUNC`定义为函数类型`int (int,int)`的别名；

下面将用这些类型声明变量和函数：

```c
DWORD x; // int x;
ARRAY a,b [20]; // a[255], b [20] [255]
FUNC f;
```

#### 声明临时数组、激活使用、结束使用

类型`va_list`是在头文件`<stdarg.h>`中定义。在不同的C实现上定义不同，但我们包含并使用它即可。

`va_start` 是一个宏，也是在头文件`<stdarg.h>`中定义的，用来指使`ap`指向变参函数中最后一个已知参数（从右往左数的第一个已知参数），从而为访问后面的变参做准备。该宏具有两个参数，第一个参数是那个被声明为`va_list`类型的变量；第二个参数则是标识符，它必须是变参函数中最后那个已知参数的名字；

```c
long long int sum_ints 
    (unsigned int count, ...){
    /*...*/
    va_list ap;
    va_start(ap, count);
    while (count --) sum += va_arg(ap, int);
    va_end(ap);
    /*...*/
}
```

为了获得变参的值，这里使用了另一个宏`va_arg`，它同样是在头文件`<stdarg.h>`中定义的。该宏具有两个参数，第一个参数被声明为`va_list`类型的变量；第二个参数则是类型名；在程序翻译时，这个宏会被拓展为一个表达式，所以它可以直接作为运算符`+=`的右操作数；

```c
sum += va_arg(ap, int);
```

一开始，我们令`va_list`类型的变量`ap`指向最后一个已知参数。此后，每调用一次`va_arg`，都会使`ap`指向下一个参数（变参）并取得（计算出）它的值。

```c
va_end(ap);
```

最后，宏`va_end`将修改变量`ap`使它不再可用，它同样是在头文件`<stdarg.h>`中定义的。如果一个函数里曾使用`va_start`引用过变参，则它必须调用`va_end`才能保证返回时一切正常。如果没有，则行为是未定义的；

回到开头，定义了一个类型`VARF`

```c
typedef long long int VARF (unsigned int, ...);
```

如果没有关键字`typedef` 这是声明了一个函数`VARF`因为有关键字`typedef` 这是将标识符`VARF`定义为它被声明的类型，即，将函数`VARF` 定义为函数类型`long long int`。也就是说，`VARF` 现在是一种函数类型的名字，别名；

```c
VARF sum_ints;
// 等价于
// long long int sum_ints(unsigned int,)
```

#### Checkpoint6.4

1. 如果F是“指向‘有两个int类型的参数且返回类型是int的函数’的指针”的别名，请问F是如何定义的？编写一个程序，用类型F声明一个指向函数的指针，并用这个指针调用它所指向的函数。

```c
typedef int F (int, int);
```

```c
typedef int F(int, int);
int main(void){
    F func;
    int res = func(1,2);
}
int func(int a, int b){
    return a + b;
}
```



2. 在下面的程序里，函数`var sum`是个变参函数。参数`fmt`用于接受一个字符串，字符串的内容用于指示对应的变参的类型。比如，“1”表示对应的变参是longint类型；“i”表示对应的变参是int类型；“I”表示对应的变参是指向int的指针；“L”表示对应的变参是指向1 ong int的指针。
   - 函数var sum的任务是依据参数fmt来取得各个变参的值，或者，变参是指针的，取得它所指向的变量的值，然后返回累加的结果。
   - 在main函数里，我们调用了var sum函数，传入的字符串是“1IiiL”,后面的5个参数对应于这个字符串的指示。
     现在，请将函数var sum补充完整，并在你的机器上翻译和调试，以检验自己写的是否正确。

```c
# include <stdarg.h>
int var_sum(char * fmt, ...){
    // fill in
}

int main(void){
    int x = 50, r;
    long int y = 3;
    r = vs_sum("lIiiL", 5L, & x, 6, 7, & y);
}
```

### 认识逐位或、逐位与和逐位异或运算符

开头引入的一些都是POSIX标准的头文件，可以在头文件包含指令中使用路径。

```c
/**********************c0608.c*********************/
# include <unistd.h>
# include <fcntl.h>
# include <sys/stat.h>

int main (void)
{
    int fd;
    fd = open ("myfile1.dat", O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);

    if (fd == -1) return -1;
    /*...*/
}
```

open函数在`<fcntl.h>`中的声明：

```c
int open(const char * pathname, int oflag, ...);
```

在打开文件的语句中：

```c
    fd = open ("myfile1.dat", O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
```

- 因为`pathname`被声明为`const`，所以可以直接使用字面串；
- `O_CREAT` 、 `O_RDWR` 这些是操作的关键字：
  - 首先这些关键字在特定的位上是1，如：`0001` `0010`；
  - 通过`|` 或操作符可以把两个描述符综合起来，最后形成了一个复合的描述符；`0011`

- 函数`open`返回了一个整数唯一地代表这个文件，叫作文件描述符或者文件句柄。如-1则打开失败；

### 指向void的指针

开始向文件中写入内容

```c
    char name [] = "LiuChangjiang", gender = 'M', age = 36;
    unsigned int score = 2200;

    write (fd, name, strlen (name));
    write (fd, & gender, sizeof gender);
    write (fd, & age, sizeof age);
    write (fd, & score, sizeof score);

    close (fd);
```

函数`write`的定义如下：

```c
ssize_t write (int filedes, const void * buff, size_t nbytes);
```

- 第一个参数`filedes`的类型是`int`，用于指定一个文件描述符；第二个参数`buff` 用于指向一个缓冲区；

> 缓冲区是一个连续的内存空间，比如：数组。可以起到缓存的作用；

- 第二个参数`buff` 被声明为一个指向`const void` 类型的指针以适应传入的各种指针类型；

> void 表示没有参数，或者说参数为空；如果函数的返回类型是void，表示不返回任何值；所以不能`void v`这样定义变量。由于指向`void`类型的指针不能用于访问它所指向的变量，因为无法知道变量的大小。也不能加减操作，因为不知道长度；
>
> 因此，只能将用户指定的变量区转化为(char *)类型，因为char只有一个字节，故可对齐所有类型；

- 第三个参数`nbytes` 是要写入的字节数，它会返回实际写入的字节数；如果错误则为-1；

> 在一个语句写入完成后，函数会自动移动在文件中的指针，如果想要手动移动也可以；

- `strlen` 函数用于计算除了`'\0'` 之外的数组真实长度；
- `close` 用于关闭文件流；

>上述文件编译时不需要指定库文件，gcc会链接大部分标准库文件

```c
ssize_t read (int filedes, void * buff, size_t nbytes);
```



### 结构类型

C语言中，从基本类型构建其他类型称为 **类型的派生** ，指针、数组和函数都是派生类型。

> 按理说，类型应该先派生再使用，但指针、数组和函数类型的派生过程是与变量或者函数声明合二为一的，换句话说，在C语言中不存在指针、数组和函数指定符，在声明后才会产生具体的数组、指针和函数类型，无法事先定义；

使用 **结构类型** 声明类型指定符，语法为：

```c
struct 标识符 (可选) {成员声明列表}
struct 标识符
```

如：

```c
struct {
    int x;
    int y;
}
```

结构类型可以用来声明变量和函数，如：声明类型为`struct (int x, int y;)` 类型的`crd`

```c
struct {int x, int y;} crd;
```

#### 结构类型指示符的唯一性

在下面例子中，我们认为`m` 与 `n` 相同：

```c
int m;
int n;
```

但一下两个变量类型不同：

```c
struct {char name[20]; int chy} person1;
struct {char name[20]; int chy} person2;
```

结构类型指定符虽然也是类型指定符，但它毕竟不是内置类型，而是派生类型，所以每个出现在程序中的类型指定符具有自我声明的性质。换句话说，它虽然是一个类型指定符，但他同时一种新的结构类型声明。 **带有成员变量声明列表的结构指定符每出现一次，都将声明一个新的结构类型**。

所以，结构类型指定符中的标识符通常不该省略，这个标识符称为类型的唯一标记，以下这两个类型才是相同的：

```c
struct person {char name[20]; int chy} person1;
struct person person2;
// 事实上，我们可以先声明标记，再用标记声明变量：
struct person person3, * person4;
```

当然，也可以用`typedef` 一次性声明多个类型变量；

```c
typedef struct {
    char name [20];
    int char;
    int chk;
} sPersn, persn;
```

#### 使用初始化器

```c
struct persn person1 = {{"haha"},'M',33}
```

- 初始化器中的`{}`是可选的，用于初始化第一个变量；
- 如果初始化器的数量少于结构成员的数量，则初始化器的顺序依然按照结构成员声明的顺序进行，多余的成员会被初始化为默认值，如果是整型，则会被初始化为0，如果是指针，则是空指针；

```c
struct persn person2 = {.chk = 33,}
```

- 数组的初始化器中可以使用`[]`来指示一个要初始化的数组元素，在结构类型中，**可用`.` + 成员变量名不考虑顺序地指示初始值**

![image-20220825004104032](https://cdn.notcloud.net/static/md/cy948/202208250041083.png)

- 因为对齐的缘故，中间会存在空余的字节。是否会有填充的字节取决于结构成员的类型和数量。填充的字节内容是不确定的，通常是一些随机值；



下面程序用于向显示器输出一个字符的内容

```c
/*********************c0610.c********************/
# include <unistd.h>

int main (void)
{
    char * pbook = "The Laws of Boole's Thought.\n";
    write (STDOUT_FILENO, pbook, strlen (pbook));
}
```

> 每个运行在OS上的程序都会有一段初始化的代码。这个初始化的过程包括打开三个标准设备：标准输入、标准输出和标准错误。
>
> - 标准输入通常指硬盘，供每个程序获取外部输入；
> - 标准输出通常指显示器，供每个程序输出信息；
> - 标准错误通常指显示器，供每个程序输出它的错误信息；
>
> 这三个设备都被当成文件对待，所以它们的文件描述符分别是0、1、2；不需要希纳是地打开或创建，它们的预定义的；在程序开始时已经打开了；

如需将标准输入、输出、错误的结果定位到其他设备和文件可以使用“管道符”`>`，如：

```sh
./c.out > dest.txt
cat dest.txt

# content
```

于是运行结果并不在屏幕显示，而是创建并写入了文件dest.txt



下面的程序将接收标准输入并把输入输出进行标准输出：
```c
/*******************c0611.c*******************/
# include <unistd.h>

# define PROMPT "->"

int main (void)
{
    char buf [1];

    write (STDOUT_FILENO, PROMPT, strlen (PROMPT));

    while (read (STDIN_FILENO, buf, sizeof buf) > 0)
        write (STDOUT_FILENO, buf, sizeof buf);
}

```

- 宏PROMT被展开为字面串`->`
- 对`read` 的调用中， `STDOUT_FILENO` 是一个宏，被定义为整数0，是标准输入（通常为键盘）的文件描述符
- 函数`read` 在读到文件末尾时返回0，发生错误时返回-1，在while语句中，函数read从标准输入读取，如果值大于0，则返回循环体，将读来的数据写到标准输出，然后继续下一次循环

> 通常情况下，系统内会为标准IO分配一个缓存区，这两个缓存区由换行符驱动，也就是说：**直到缓存区满或遇到换行符才真正执行更底层的写入操作**

- 执行过程： 输入字符"haha"，按下回车键后，函数`read` 开始工作，从缓存区读取字符，每次1个，然后写到标准输出，就这样循环读写，直至将缓存区读空。

强制终止：

Linux: <kbd>ctrl</kbd> + <kbd>d</kbd>

Windows: <kbd>ctrl</kbd> + <kbd>z</kbd>

#### 成员选择符`.`

错过了初始化后，能为成员变量提供值的方法不多，第一种是将一个结构变量的值赋值到另一个结构变量，如：

```c
struct t {char a [20]; int m;} ta = 
{"hello",21}, tb;
tb = ta;

// 函数也可
struct t frets(struct t tm){
    return tm;
}
```

为了给结构的成员变量提供值，需要用到运算符`.`，右边是指示那个成员的标识符，如：`emp.name`。

- 如果左操作数是左值，则运算符`.`的结果的得到那个成员的值，结构类型和那个成员的类型相同。

> 在表达式`emp.name`中，左操作数`emp`是左值，故表达`emp.name`的结果是左值，代表结构变量`emp`的`name`成员本身

### 复合字面值

```c
(类型名) {初始化器列表}
(类型名) {初始化器列表 ,}
```

复合字面值用于创建一个没有名字的变量，“类型名”指定了该变量的类型，“初始化器列表”用于指定变量的初始值，例如`(int){0}` ，可以用作函数的形参

```c
func((int){0})
```

### 控制台IO

我们知道，对标准输入输出异常的操作其实是对文件操作，对文件操作前需要先拿到句柄，在windows上：

```c
/**********************c0613.c*********************/
# include <windows.h>

int main (void)
{
    HANDLE hstdo = CreateFile ("CONOUT$", GENERIC_WRITE, 0, \
                                     NULL, OPEN_ALWAYS,\
                                     FILE_ATTRIBUTE_NORMAL, NULL);
    char buf [] = "Hello world.\n";
    WriteFile (hstdo, buf, lstrlen (buf), (DWORD []) {0}, NULL);
}

```

- `lstrlen`用于返回不带末尾'\0'长度的字符串长度值

### 函数main的定义

函数`main`作为整个程序的主函数出现，程序启动并完成初始化操作后，将调用main函数。如果用户在启动时指定了命令行参数，则操作系统将代收这些参数。

如果不接受命令行接受的参数，函数main可以定义为返回int的、无参数的形式：

```c
int main (void){/*....*/}
```

如果需要使用命令行参数，则可以定义为一下这种具有两个参数的形式

```c
int main (int argc, char * argv[]){}
```

- 参数`argc`具有非负值，而`argv`虽然在形式上是数组，实际上会被转化为指向头部的指针。

以上无参数和有参数的形式是C语言定义的标准形式

![image-20220825215615736](https://cdn.notcloud.net/static/md/cy948/202208252156791.png)

- 参数变量`argv`的值指向一个内部数组的首元素，这个内部数组保存了当前正在运行的程序名，以及用户输入的所有命令参数
- 参数 变量`argc`的值可用于计算这个内部数组的大小因为这个值等于该数组最后一个元素的下标

## C标准库

> 本章中宏定义的位置默认在<stdio.h>中声明

### 流

> 写入或者读取一个文件，POSIX有一套方法。写入输出的对象可以是结构化存储设备（硬盘、光盘等）支持的文件，也可是一些物理设备，如磁带、终端（显示器或老式电传打印机等）。无论是那种，都是比特或者字节的序列在计算机内部或者在设备之间传输，像水流。因此，在C标准库中，都可以被映射为逻辑上的数据流，或者简称为流。

要访问和操作流（中的数据），需要一个流和文件关联，这是流的来源和目的地。这样做是为了简化操作方便IO操作，这样一来，当我们打开或者创建一个文件，就能使一个流与该文件结合，或者相关联。

C语言支持两种形式的数据流映射，分别是文本流和二进制流。

文本是肉眼可以识别的文字信息，如果一个文件的内容指数纯粹的文本，可以将它映射为一个 **文本流** ，这样做的好处是可以根据计算机系统环境的不同而改变文本呈现方式，如： 对文本流进行增、删、改。

> C中的'\n'用于换行，是unix/linux的习惯，在windows上是'\r\n'，C标准库会自动进行转换

和文本流不同，二进制流用于透明地记录内部数据，相对于流的创建者和接收者来说，中间的、用于处理流的C标准库可视为不存在，因为他们不会改变流中的数据，仅起到传输的作用。 **写入二进制流的数据，当再读出来时应当是相同的**；

标准库中的打开文件函数：

```c
FILE * fopen(const char * restrict filename, const char * restrict mode);
```

参数`filename` 用于接收一个指向字符串的指针，字符串的内容是要创建或者打开的文件名，而`mode` 则用来指定以什么样的方式（模式）来创建或者打开文件。

### restrict 限定类型

和`const` 一样，都是类型限定符，但不同是的是，`restrict` 只用来限定指针类型，也就是说只能生成指针类型的`restrict` 限定版本：

```c
int r = 0, * restrict pr = & r;
```

变量`pr`的类型是`restrict` 限定的指针。这种限定被视为程序员向C实现保证：在指针`pr`所在的块中，变量`r`只会通过指针`pr`访问，不会通过其他途径，例如其他指针访问。如：

```c
int i = 1, * a = &i, * b = &i;
void fool(int * restrict pr){
    
}
fool(a);
```

指针`a` `b` 都是指针类型的变量，当声明为`restrict` 后，C实现便可以在块开始处安全地缓存“该指针所指向的变量”的值，执行的各种操作都在该变量上完成。

> 所以上述在函数`fool`内，只能通过`a`对变量`i`进行操作，使用`b`进行的操作是无效的。

最后，在退出块之前，再将缓存的值（可能已经更新过）刷新到那个指针所指向的变量。毕竟，对于某些复杂的操作而言，缓存一个变量的值，并将这个值用于后续计算的开销，比频繁地调用那个指针访问那个变量的代价要小。

### C标准库的实现

```c
FILE * fopen(const char * restrict filename, const char * restrict mode);
```

函数`fopen`的第二个参数是模式，如图：

![image-20220825222705487](https://cdn.notcloud.net/static/md/cy948/202208252227561.png)

- “更新” 是指读和写，“追加”是指在文件末尾添加
- “追加” 是指在文件末尾添加，这个模式下可以读整个文件，但写操作只能在尾部进行。
- 被创建或者打开的文件有两种：文本文件和二进制文件。

一旦创建或打开文件，函数`fopen`就会返回一个指向`FILE` 的指针。`FILE` 是一个结构类型的别名，该结构类型是在`<stdio.h>`内声明的，他的成员用于记录一些对于控制文件读写来说非常重要的信息。通过库文件操作函数时，会改变文件状态，比如当前读写的位置，等等，这些信息都记录在阵列，供后续的文件操作函数使用；

> 如果`fopen` 返回的`FILE` 类型的指针是空指针，则意味着打开失败

### 标准输入和标准输出

文件的写入工作是由函数`fputc` 完成的，也是在`<stdio.h>` 中声明的，其原型为：

```c
int fputc (int c, FILE * stream);
```

该函数将一个字符写入由参数`stream`所指定的流，要写入的字符在参数`c`中。虽然参数`c`的类型是int，但该函数把它转换为`unsigned char` 类型后再写入。也就是说，它实际上只能处理单字节编码的字符，比如ASCII字符，再比如说，字符串常量'm'的类型是int，但这个字符的编码也能被unsigned char 类型表示。

如果函数执行成功将返回那个被写入的字符，也就是参数c的值；如果写入错误，则返回`EOF` （end of file 文件末尾），它是一个宏，在`<stdio.h` 中被定义为`-1`；

```c
# define EOF -1
```

打开文件后，如果不再需要操作它，可以将它关闭以释放系统资源。为此需要使用C标准库函数`fclose`

```c
int fclose(FILE * stream);
```



程序启动时，将预定义3个文本流，并不需要显示打开即可使用，分别是：标准输入（用于读取一般性的输入）、标准输出（用于写入一般性的输出，通常对应着显示器）和标准错误（用于写入诊断信息，通常对应着显示器）。

为方便使用，在头文件`<stdio.h>`里定义了三个宏，`stdin stdout stderr` 这三个宏被定义为指向这三种标准设备的指针，也就是`FILE`结构，分别表示标准输入、标准输出和标准错误。

下面程序演示了如何从标准输入读取字符，然后写到标准输出，下面程序中每次从标准输入中读取一个字符，所用的函数是`fgetc`：

```c
int fgetc(FILE * stream);
```

```c
/**************c0620.c************/
# include <stdio.h>

int main (void)
{
    int c;

    while ((c = fgetc (stdin)) != EOF)
        fputc (c, stdout);
}
```

### 标准IO的缓冲区

数据传输过程中，为了提高传递效率，需要用一小块像蓄水池一样的缓冲区进行缓存。

![image-20220825230820095](https://cdn.notcloud.net/static/md/cy948/202208252308154.png)

C标准库的缓冲区有三种类型，分别是全缓冲、行缓冲和无缓冲。

- 全缓冲：当填满缓冲区后才进行实际的I/O操作；

>  典型地，对于磁盘文件的操作是全缓冲操作，在一个流上首次执行I/O操作时，才由相关的库函数创建缓冲区；（在汇编中已经知道硬盘的写入是整块写入，对 对齐有要求）

一般地，`fputc`函数收集了足够的数据后，将调用系统的 I / O功能，如果等不及，可以用函数`ffulsh` 将数据刷出：

```c
int fflush(FILE * stream);
```

如果由参数`stream` 所指向的输出流在最近一段时间没有数据输入，则该函数将把流中那些未写的数据刷出。如果参数`stream`是空指针，则将由当前程序所创建的所有输出流的数据刷出。成功返回0，否则返回EOF。

>  文本是肉眼可识别的文字信息，以行为单位，每行末尾都有一个换行符，可以控制在显示和打印时的折行。相应地，当文件被映射为文本流时，文本流就成了以行为单位、有序的文件序列，每行由0个或多个字符，换行符是行的结束标志，是每行的最后一个字符，也是行的组成部分。

在下面的程序中，我们以行为单位从文件myfile.txt里读取文本，并写到标准输出

```c
/******************c0621.c*****************/
# include <stdio.h>

int main (void)
{
    FILE * hfile = fopen ("myfile5.txt", "r");
    if (hfile == NULL) return -1;

    char buf [BUFSIZ];

    while (fgets (buf, BUFSIZ, hfile) != NULL)
        fputs (buf, stdout);

    fclose (hfile);
}
```

- 在程序中，我们先以模式“r”打开文本文件，这个模式含义是“读取一个已存在的文件”。接着声明了已给数组buf以保存读出的文件文本行并将它的内容输出。
- 数组的长度定义为**BUFSIZ**，这是在头文件`<stdio.h>`中定义的宏，代表着一个整数值，意思是“缓冲区长度”，定义如：

```c
# define BUFSIZ 512
```

程序中的`while`语句用于从流中读取文本行，并写到标准输出。读取文本行用的函数是`fgets`，原型为：

```c
char * fgets(char * restrict s, int n, FILE * restrict stream);
```

从参数`stream`所指向的流中读取字符并写入由参数`s`所指定的缓冲区。缓存区的长度由参数n的值指定，该操作一直持续，直至碰上换行字符，但即使没有碰到换行字符，读取字符的数量也**不超过**参数**n的值-1**.在后一种情况下，该函数将返回一个不完整的行。但下一次读取将继续从改行未读处进行；

当最后一个字符从流中读入缓冲区后，该函数立即会在后面添加一个空字符。若函数执行成功将返回指向缓冲区的指针，也就是将参数s的值作为返回值；如果已经读到了流的尾部，则没有字符可以读取，缓冲区的内容不受影响，且该函数返回空指针。

```c
int fputs(const char * restrict s, FILE * restrict stream);
```

该函数将参数s所指向的字符串写到由参数stream所指向的流，但不包括字符串末尾的空字符。该函数的返回值类型是int，如果在操作过程中返回错误则返回EOF，否则返回一个非负值。



当然，缓冲区还可以关闭，可以通过函数`setvbuf`设置关闭缓冲区：

```c
int setvbuf(FILE * restrict stream, char * restrict buf, int mode, size_t size);
```

该函数用于调整`stream`所指向那个流的缓冲区，参数mode用于指定缓冲区的类型，可以在这里由头文件`<stdio.h>` 所定义的三个宏： `_IOFBF _IOLBF _IONBF`，分别代表全缓冲、行缓冲、无缓冲。

函数`setvbuf`和`setbuf` 必须在一个流被打开之后立刻调用，而且也应该在使用C标准库函数进行任何I/O操作之前使用。如果函数执行成功返回0；如果参数不正确或者条件不满足则返回非0值；

> 按行读文件中，实际上是：1. 取得文件句柄； 2. 通过`fgets`函数读取文本内容到缓冲区，这时需要句柄、缓冲区、读取长度；3. 通过`fputs`将缓存区中的内容输出，需要句柄、缓冲区；

### 直接的输入输出（二进制流）

> 前面所讲的c标准库函数，诸如fgetc、fputc、fgets和fputs等，都比较适用于文本流。虽然它们也可以用于二进制流，但会有一些限制。比如，函数Puts在遇到空字符时就停止处理，而一个二进制流中，空字符和其他特殊字符都不应该被区别对待。

因为这个原因，C标准库引入了用于直接输入输出的函数。和一次一个字符的I/0或者一次一行的I/O不同，这些函数更适宜于处理数组和结构这样的数据类型，所以也经常称这些输入输出为二进制I/O、面向数组和I/O或者面向结构的I/O。

在下面的程序中，我们将使用直接输入/输出函数将结构类型的数据写入文件。

```c
/********************c0623.c******************/
# include <stdio.h>

typedef struct employee
{
    char name [20];
    char gender;
    char age;
    unsigned int score;
} stgEMP;

int main (void)
{
    FILE * hfile = fopen ("myfile6.dat", "wb");

    if (hfile == NULL) return -1;

    stgEMP empa [] = {
        {"LiShuangyuan", 'F', 12, 600},
        {.age = 20, 1500, .name = "LiJianan", 'F'},
        [5] = {"WangXiaobo", 'F', 35, 20000},
        [6].name = "LiZhiping", 'M', 15, 800,
    };

    fwrite (empa, sizeof (stgEMP),\
              sizeof empa / sizeof (stgEMP), hfile);

    fclose (hfile);
}

```

- 在程序开始，声明了一种结构类型，并添加了别名`stgEMP`；
- 接下来，以二进制写入模式 "wb" 创建一个文件myfile6.dat；
- 然后声明了一个变量`empa`，元素类型为`stgEMP`；
- 因为变量`empa`是数组，是包含自变量的变量，所以初始器外层的`{}`对应整个数组本身。
- 最后一个初始化器中，虽然没有花括号，但等价于`[6].name = "LiZhiping", [6].gender = 'M', [6].age = 15, [6].score = 800,` 不提倡该写法；



使用直接输入输出，可以使用C标准库函数`fwrite`：

```c
size_t fwrite(
    const void * restrict ptr, 
    size_t size, 
    size_t nmemb, 
    FILE * restrict stream
);
```

在这里，`ptr`用于接收一个指向缓冲区的指针。即`empa`的值，第二第三个参数用于指定要写入的数据量。

- 参数`size`用于指定记录的大小（以字节计）；
- 参数`nmemb`用于指定记录的数量；

因为我们要写入的是一个数组，数组的元素类型是结构，所以，记录的大小就是结构类型`stgEMP`的大小，也就是程序中给出的`sizeof (stgEMP)`；记录的数量就是数组的长度，这个数量可以用数组的总大小`sizeof empa` 除以数组的元素大小`sizeof (stgEMP)`得到。

```c
fwrite (
    empa, 
    sizeof (stgEMP),\
    sizeof empa / sizeof (stgEMP), 
    hfile
);
```



要读取数据，需要使用C标准库函数`fread`：

```c
size_t fread(
    void * restrict ptr, 
    size_t size, 
    size_t nmend, 
    FILE * restrict stream
);
```

### 格式化输出

> 截至目前，当我们从键盘获取输入的时候，取到的都是字符，即使你按下数字键，得到的也只不过是数字字符一代表数字的字符，而不是真正的数字。
> 相反地，如果你想在屏幕上显示一个“5”，你不能把数字5写到标准输出，而只能写如数字字符'5'的编码值

C标准库中提供了格式化的输入输出函数，允许从流里获取输入，并把它转换为我们要求的格式；或者，把输出转换为我们希望的格式之后插入流中。

格式化输入/输出函数很多，本次介绍`fprintf`：

```c
/*******************c0624.c*******************/
# include <stdio.h>

int main (void)
{
    fprintf (stdout, "hello world.\n");		//S1
    fprintf (stdout, "hello, %d!\n", 25);	//S2
}

```

`fprintf` 原型为：

```c
int fprintf(FILE * restrict stream, const char * restrict fomat,...);
```

以上，参数stream用于指定一个输出流，比如：创建或者写入的方式打开一个文本文件并映射为文本流。上述程序中，将输出流设为标准输出：

- S2 中，'%d' 是一个**转换模板**，函数`fprintf` 会把这个便餐的值转换为一个数字字符的序列以替代'%d';

#### 定点数和浮点数

假定要用32位的存储区保存一个任意的小数：

**定点法**： 前16位用于保存整数部分，后16位用于保存小数部分；

> 缺点： 在实际应用中缺乏弹性，如果整数数位很多而小数很少，会产生浪费；

**浮点法**：

> 我们知道，将一个二进制的小数点移动相当于乘/除以2，利用这个特点，以下的方法都可以用于得到十进制数123.5

![image-20220827192639295](https://cdn.notcloud.net/static/md/cy948/202208271926360.png)

所以，通常的做法是正负号一位，指数部分8位；其余比特用于保存有效数字；

指数可能为正，也可能为负。如果使用8个比特来保存指数部分，则指数的范围是-127到+127。因为负数使用补码，这对两个浮点数的比较是很不方便的。为此，指数在存放时要先加上127。如图6-13所示，保存123.5时，指数6加上127等于133，其二进制形式为10000101，这部分称为阶码。

![image-20220827192707371](https://cdn.notcloud.net/static/md/cy948/202208271927419.png)

再来看有效数字部分，因为有效数字的小数点之前始终为1，因此，实际的做法是把这个1省略不予存储，这样就能多腾出一个比特来提高精度。浮点数123.5转换为二进制后的有效数字部分为1.1110111，如图6-13所示，我们只截取1110111，后面补0，使之能够正好填充32位存储空间的剩余部分，这一部分称为尾数。

#### 浮点类型和浮点常量

C语言引入了三种浮点类型：`float double long double`，他们是内置的；

```c
float f, ff(float);
double d, da[3], * pd = da;
```

> C语言并未规定这三种浮点类型的长度，仅规定在取值范围上，float是double是子集；double是long double的子集。
>
> 典型地，float类型具有32位长度，可拥有6个十进制小数数位，可拥有最大值为$3.14 \cdot 10^{38}$；double类型具有64位长度，可拥有10个十进制小数数位，可拥有最大值为$1.79 \cdot 10^{308}$；long double类型可具有80到128位的长度，可拥有19个以上的十进制小数数位，最大值至少为$1.1 \cdot 10^{4392}$

浮点常量有两种，分别是十进制浮点常量和十六进制浮点常量：

**十进制**：如2.0、6.25；如果小数点前面或者后面是0，则这个0可以省略，例如2.和.11982都是合格的浮点常量；指数部分可以添加一个"e" or "E" 引导指数部分，如：2.e9和5.2E-3分别表示$2.0 \cdot 10^{9}$ 和 $5.2 \cdot 10{-3}$。如果带有指数部分，前面数字可以没有小数点，如2e3，1E-5；

**十六进制**：以“0x” “0X”引导，指数部分是必须要有的，以"p" or "P" 引导 ，例如 0x2p3、0X.3FP6、0xa.p2，分别表示 0x2 x 2^3， 0x.3F x 2^6 0xa. x 2^2；



 #### 默认实参提升

```c
/*******c0625.c**********/
# include <stdio.h>

int main (void)
{
    float fa [] = {.7, 9., 3e2, 2.2e+0, 0x3.5fp2};

    for (int x = 0; x < sizeof fa / sizeof (float); x ++)
        fprintf (stdout, "fa[%d]=%f\n", x, fa [x]);
}
```

转换模板`%f`用于打印一个浮点数，要求一个double类型的变参。如果参数是float类型的，则会自动提升到double；

进一步地，如果被调用函数是用原型声明的，但它是一个变参函数（参数类型列表是以“,...”结束的），则对应于省略号的实参都必须先做默认的实参提升。

>  默认实参提升对阶低于int或者unsigned int的整数类型，以及float类型才起作用。比如，_Bool、char、signed char和unsigned char等都被实施默认实参提升，但对指针、结构等类型不起作用。

#### 函数`fprintf` 的转换模板

函数`fprintf` 的转换模板由以下几个部分组成：
$$
\% \ 标志_{可选} \ 最小栏宽{可选} \ 精度_{可选} \\ 长度修饰符_{可选} \ 转换指定符
$$

```c
/**********************c0626.c*********************/
# define __USE_MINGW_ANSI_STDIO 1
# include <stdio.h>

int main (void)
{
    fprintf (stdout, "%+11.5lld%-11.2Lf%011f\n",
             385LL, -6.25777L, -3.25);
    fprintf (stdout, "-----------+++++++++++-----------\n");
}
```

以上定义的模板中：

> d和f都是转换指定符，其他转换指定符包括但不限于c、s、p、F、%、i、o、u、x、X、a、A、e、E、g和G

- `%+11.5lld` 
- `%-11.2Lf` 

长度修饰符用来和转换指定符一起共同决定（所对应）实参的大小（类型）。在上述转换模板中，长度修饰符为ll和F；

如果转换模板里没有长度修饰符，则：

> 记得全部小写即可

- 转换指定符`d`和`i`用于将一个int类型的实参转换为有符号的十进制形式，例如321和-78
- 类型指定符`o u x X` 用于将一个`unsigned int`类型的实参转换为无符号的八进制`o`，无符号十进制`u`、无符号十六进制（`x`或者`X`）形式，例如78、2a、3FACE。转换指定符x和X的区别在于十六进制的字母采用小写a、b、c、d、e、f，还是大写的A、B、C、D、E、F；
- 转换指定符`f`和`F`用于将一个double类型的实参转换为有符号十进制浮点形式，形如：6.25和-123.5；
- 转换指定符`e`和`E`用于将一个double类型的实参转换为形如3e+002、-8.9e-002等浮点数形式。转换指定符`e`和`E`的区别在于指数部分是用`e`还是`E`引导；
- 转换指定符`g`等同于`e`或者`f`；转换指定符`G`等同于`E`或者`F`。如果数值的指数部分小于-4或者大于等于精度值，则`g` 等同于`e`，而`G`等同于`E`；否则，`g`扽沟通与`f`，而`G`等同于`F`；
- 转换指定符`a`和`A`用于将一个doub1e类型的实参转换为形如0x3.6p+2和0X5.abcdP-1的形式。转换指定符a在结果中使用前缀0x、小写字母abcdef,并用小写字母P引导指数部分；转换指定符A在结果中使用前缀0X、大写字母ABCDEF,并用大写字母P引导指数部分；
- 转换指定符`c`用于将一个int类型的实参转换为unsigned char类型的字符：
- 转换指定符`s`需要一个指向字符数组首元素的指针作为实参，并输出数组中的字符直至遇到空字符
- 转换指定符`p`需要一个指向void的指针作为实参，并将其输出为一系列可打印的字符（将指针打印成数字形式）
- 转换指定符号不需要对应的实参，它将输出一个“%”。

 如果转换模板里有长度修饰符，则：

> 长度中，h转为char，h转为int，l long， ll long long;

- 长度修饰符`hh`可用于修饰转换指定符d、i、o、u、x和X,取决于这些转换指定  符原先的符号性，表示将它们对应的实参转换为signed char或者unsigned
    char类型；
- 长度修饰符`h`可用于修饰转换指定符d、i、o、u、×和X,取决于这些转换指定符原先的符号性，表示将它们对应的实参转换为short int或者unsigned
   short int类型；
- 长度修饰符`l`可用于修饰转换指定符d、i、o、u、×和X,取决于这些转换指定符原先的符号性，表示将它们对应的实参转换为long int或者unsigned long int类型
- 长度修饰符`11`可用于修饰转换指定符d、i、o、u、x和X,取决于这些转换指定符原先的符号性，表示将它们对应的实参转换为long long int或者unsigned  long long int类型；
- 长度修饰符工可用于修饰转换指定符a、A、e、E、f、F、g和G,表示将它们对 应的实参转换为long double类型。



接着来看精度可选项，当它作用于转换指定符d、i、o、u、×和X时，表示最少打印几位数字。如果要打印的数位超过精度，则不受约束地完整打印；若少于精度，则前面补0以达到精度的要求；当精度作用于转换指定符a、A、e、E、f和F时，表示小数点后面有几位数字；当精度作用于转换指定符g和G时，表示最多有几位有效数字；当精度作用于转换指定符s时，表示最多打印几个字节（字符）。

精度必须是点“.”后面跟一个整数。在上述程序中的第一条语句里，第一个转换模板
中的.5表示所打印的整数至少有5个数位，不足5个时，前面补0；第二个转换模板中的.2
表示小数点后面保留2个数字；第三个转换模板里未指定精度，默认的精度是6。按规定，
如果没有指定精度，则对于转换指定符d、i、o、u、×和X来说，默认的精确度是1；对
于转换指定符e、E、f、F、g和G来说，默认的精度为6。



#### 移位运算符<<和>>

运算符`<<`需要两个整数类型的操作数，用于组成一个形如`e1<<e2`的表达式，例如5<<2，移动前，要对e1和e2作整形提升，如e1的类型是char，则表达式e1<<e2的结果类型是e1提升后的int类型；

![image-20220827210128334](https://cdn.notcloud.net/static/md/cy948/202208272101394.png)



#### `printf` 函数

如果只针对标准输出，`fprintf`可以用`printf`代替

```c
int printf(const char * restrict format,...);
```

#### 整数类型最小值和最大值

头文件`<limits.h>`里定义了以下最小值最大值：

- CHAR MIN和CHAR MAX->char类型的最小值和最大值；
- SCHAR MIN和SCHAR MAX->signed char类型的最小值和最大值；
- UCHAR MAX->unsigned char类型的最大值；
  SHRT MIN和SHRT MAX->short int类型的最小值和最大值；
- USHRT MAX->unsigned short int类型的最大值：
- INT MIN和INT MAX->int类型的最小值和最大值：
- UINT MAX->unsigned int类型的最大值：
- LONG MIN和LONG MAX->long int类型的最小值和最大值；
- ULONG MAX->unsigned long int类型的最大值；
- LLONG MIN和LLONG MAX->longlong int类型的最小值和最大值；



### 格式化输入

```c
/***********************c0628.c*********************/
# define __USE_MINGW_ANSI_STDIO 1
# include <stdio.h>

int main (void)
{
    unsigned long long n, t, sum = 0;

    printf ("A number less or equal 1,000,000,000:");

    fscanf (stdin, "%llu", & n), t = n;
    while (n) sum += n --;

    printf ("1+2+3+...+%llu=%llu\n", t, sum);
}
```

函数`fscanf` 原型为：

```c
int fscanf(FILE * restrict stream, const char * restrict format, ...);
```

转换过程：

```c
/**********************c0629.c*********************/
# include <stdio.h>

int main (void)
{
    char a [100], c;
    int d;
    unsigned int i, o, u, x;

    fscanf (stdin, "GBT%s%d%c%i-%o,%u,,%x",\
                      a, & d, & c, & i, & o, & u, & x);
    printf (
  "a=%s\nd=%d\nc=%c\ni=%i\no=%o\nu=%u\nx=%x\n",a, d, c, i, o, u, x
    );
}
```

从输入流采集格式串所指定的成分并加以转换，然后将它们嵌入到另一个格式串中写到输出流。

函数`fscanf`首先从格式串中取得字符，如果不是%，也不是空白字符，则它必须与输入流的内容完全匹配，如：对于规则`GBT%s`来说，输入`GBThaha`将会得到`haha`，其中，如遇到空白字符会跳过。

转换模板`%s`需要一个变参，这个指针应指向一个缓冲区（典型地，是一个字符类型的数组），收集到的内容被保存到指针所指向的缓冲区里。

转换模板`%c`需要输入流中的一个字符与之对应，与其他模板不同，**它并不忽略空格**；

模板`%i`需要输入流的内容表示有符号整数；

### 动态内存分配和链表

在以下例子中，从输入流获取一批学生的基本信息，并打印到到屏幕上。

将学生的结构体定义如下：

```c
struct ss {
    char name [20];
    char gender [7];
    unsigned int age;
    char grade [10]; //freshman/sophomore/junior/senior
    float score;
    struct ss * next;
}
```

在结构中，我们定义了`next`的指针指向下一个学生，但该定义是“不完整定义”。按照规定，在声明一个结构类型时，如果它有标记，则标记在完全出现之前就立即可用；如果它有成员列表，那么在到达结构成员列表的右花括号“}”之前，这种结构类型是不完整的，称为不完整结构类型。不允许声明不完整结构类型的变量，因为不知道类型的大小，从而无法分配空间，所以以下声明是非法的：

```c
struct A {char c; struct A a};
```

但是，我们却可以声明一个指向不完整类型的指针。这是因为指针的大小只与被指向的类型有关，与被指向的类型有多大、都包括那些具体成员无关。换句话说，**所有指向结构类型的指针都有相同的大小。** 所以开头对学生的结构声明是合法的；

#### 动态创建变量（malloc）

使用`malloc`向操作系统申请内存：

```c
void * malloc(size_t size);
```

- 参数`size`用于指定分配的字节数，具体是多少要取决于你准备用它保存什么类型的数据。如果要保存一个int类型的数据，那就传入`sizeof (int)`

函数`malloc`分配指定大小的内存，并返回指向那片内存的指针。失败则返回空指针。

显然，用malloc函数创建的变量没有名字，无法使用。但它返回了一个指向该变量的指针，只能通过该指针去访问变量，如果指针丢了就找不到了。需要声明一个指针类型来保存这个指针，例如：

```c
int * pint = malloc(sizeof (int));
* pint = 10083;
```

此处声明了一个变量`pint`，并初始化为表达式`malloc(sizeof (int))`的返回值。在此之后，我们就可以用这个指针访问刚才分配的变量。函数malloc返回的是一个指向void的指针，但pint的类型是指向int的指针，C语言支持这样的自动转换，也可以手动转换：

```c
int * pint = (int *) malloc (sizeof (int));
```

> 对齐，一个容易忽略的问题。非对齐的访问是危险的，但malloc函数并不知道所分配内存的存储区。在这种情况下，它分配的存储区将起始于一个具有最大对齐的地址，这个存储区的对齐值是C语言所支持的所有类型对齐值的最小公倍数。换句话说，**任何类型的变量都可位于（对齐于）malloc函数所分配的存储区**



以下语句定义了链表的头部：

```c
PSSTUD header = malloc(sizeof (SSTUD));
```

![image-20220828010025246](https://cdn.notcloud.net/static/md/cy948/202208280100285.png)

申请完变量，用完后还需要用`free`函数释放：

```c
void free(void * ptr);
```

#### 成员选择符“->”

`->` 操作符的左操作数必须是指针类型的值，比如指向结构类型的指针，右操作数是成员的名字。同样的，成员选择运算符“->”用于得到那个成员；

运算符需要一个指针类型的左操作数，所以表达式`pstd -> name` 求值时，左值`pstd`先执行左值转换，得到指针类型的值。进一步地，运算符`->`得到这个值所指向的那个结构变量的`name`成员。也就是说，`pstd -> name`就代表`name`本身。

#### 实例

```c
/**********************c0631.c*********************/
# include <stdio.h>
# include <stdlib.h>

typedef struct ss {
    char name [20];
    char gender [7];		//F/M 或者 Female/Male
    unsigned int age;
    char grade [10];		//freshman/sophomore/junior/senior
    float score;
    struct ss * next;
} SSTUD, * PSSTUD;

void destroy_stud_info (PSSTUD pps)
{
    PSSTUD tmp;
    while (pps != NULL)
        tmp = pps, pps = pps -> next, free (tmp);
}

PSSTUD get_stud_info (void)
{
    FILE * pf = fopen ("students.dat", "r");
    if (pf == NULL)
    {
        printf ("File open failed.\n");
        return NULL;
    }

    PSSTUD pstd = malloc (sizeof (SSTUD));
    if (pstd == NULL)
    {
        printf ("Memory allocated failed.\n");
        return NULL;
    }

    if (fscanf (pf, "%s%s%u%s%f", pstd -> name, pstd -> gender,\
                  & pstd -> age, pstd -> grade, & pstd -> score)\
                  == EOF)
    {
        printf ("Empty file.please append some records.\n");
        free (pstd);
        return NULL;
    }

    pstd -> next = NULL;

    PSSTUD temp = pstd;
    do {
        if (temp -> next != NULL) temp = temp -> next;
        if ((temp -> next = malloc (sizeof (SSTUD))) == NULL)
        {
            printf ("Memory allocated failed.\n");
            destroy_stud_info (pstd);
            return NULL;
        }
        temp -> next -> next = NULL;
    } while (fscanf (pf, "%s%s%u%s%f", temp -> next -> name,\
               temp -> next -> gender, & temp -> next -> age,\
               temp -> next -> grade, & temp -> next -> score) != EOF);

    free (temp -> next);
    temp -> next = NULL;
    fclose (pf);

    return pstd;
}

void print_stud_info (PSSTUD pps)
{
    printf ("%-20s%5s%5s%15s%10s\n",\
             "NAME", "GENDR", "AGE", "GRADE", "SCORE");
    printf ("------------"\
             "-------------------------------------------\n");

    int total = 0;
    float sum = 0.0f;

    while (pps != NULL)
    {
        total ++;
        sum += pps -> score;
        printf ("%-20s%5s%5u%15s%10.2f\n", pps -> name, pps ->\
                  gender, pps -> age, pps -> grade, pps -> score);
        pps = pps -> next;
    }

    printf ("-------------"\
             "------------------------------------------\n");
    printf ("%-20s%35u\n", "Total:", total);
    printf ("-------------"\
             "------------------------------------------\n");
    printf ("%-20s%35.2f\n", "Sum:", sum);
    printf ("-------------"\
             "------------------------------------------\n");
    printf ("%-20s%35.2f\n", "Average:", sum / total);
}

int main (void)
{
    PSSTUD pstd = get_stud_info ();

    if (pstd != NULL)
    {
        print_stud_info (pstd);
        destroy_stud_info (pstd);
    }
    else
        printf ("No students information to print.\n");
}
```

