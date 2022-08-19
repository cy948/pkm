---
id: 583fx9se7hlrnoypvkm9jci
title: 04 无穷小和无穷大
desc: ''
updated: 1660654680208
created: 1660654680208
---

# 无穷小和无穷大

[TOC]

## 定义

### 无穷小

若$\lim_{x\to x_0}f(x)=0$或$\lim_{x\to \infty}f(x)=0$，则称$f(x)$为应当$x\to x_0$或$x\to \infty$时的无穷小

例：
$$
\lim_{x\to x_0}(x-1)=0 \ \lim_{x\to \infty}(\frac{1}{x})=0
$$
需要$\lim f(x)=0$才存在无穷小，无穷小不是$-\infty$
$$
\lim_{x\to\infty}f(x):\\
\forall \varepsilon > 0,\exist \delta>0 \\
当0<|x-x_0|<\delta,|f(x)|<\varepsilon
$$
特例：
$$
若f(x)=0，则\forall \varepsilon >0,|f(x)|<\varepsilon
$$

### 无穷大

> 无穷大不是一个数字，是一种趋势，$\infty, \ -\infty$都是无穷大

$$
f(x)=\frac{1}{x}
$$



![image-20220816211254989](https://cdn.notcloud.net/static/md/cy948/202208162112012.png)
$$
\lim_{x\to x_0}f(x): \\
\forall M >0, \exist \delta >0,\\
当0<|x-x_0|<\delta时，|f(x)|>M \\
\\
\lim_{x\to \infty}f(x): \\
\forall M >0, \exist \chi >0,\\
当|x|>\chi时，|f(x)|>M
$$

## 性质

### 定理：在自变量的同一变化过程$x\to x_0或x\to \infty$中，函数$f(x)$具有极限$A$的充分必要条件是$f(x)=A+\alpha$，其中$\alpha$是无穷小



### 定理：在自变量的同一变化过程中，如果$f(x)$为无限大，则$\frac{1}{f(x)}$为无穷小；反之如果$f(x)$为无穷小，且$f(x)\ne 0则\frac{1}{f(x)}为无穷大$



#### 例1.13

- [x] 设$\lim_{x\to x_0}f(x)=\infty$，则$\lim_{x\to x_0}\frac{1}{f(x)}=0$
- [ ] 设$\lim_{x\to x_0}f(x)=0$，则$\lim_{x\to x_0}\frac{1}{f(x)}=\infty$

>  若$f(x)=0$，则不成立；

- [ ] 设$\lim_{x\to x_0}f(x)=\lim_{x\to x_0}f(x)=+\infty$，则$\lim_{x\to x_0}(f(x)-g(x))=0$

> $\infty - \infty$的结果是未定式，结果不一定存在，如：
>
> ![image-20220816214612387](https://cdn.notcloud.net/static/md/cy948/202208162146412.png)

- [x] 设$\lim_{x\to x_0}f(x)=\lim_{x\to x_0}f(x)=+\infty$，则$\lim_{x\to x_0}(f(x)+g(x))=+\infty$

## 比较

### 无穷小的比较

$$
3x ,\ x^2 ,\ \sin x
$$

虽然这些函数都趋于0，但是速度不一样，把它相比求值即可知道速度大小：
$$
3x,\ x^2: \\ 
\because \lim_{x\to 0} \frac{x^2}{3x} = \lim_{x\to 0} \frac{x}{3} = 0 \\
\therefore x^2 趋于0的速度>3x \\
\\
x^2,\ 3x: \\ 
\because \lim_{x\to 0} \frac{3x}{x^2} = \lim_{x\to 0} \frac{3}{x} = +\infty\\
\therefore 3x趋于0的速度<x^2 \\
\\
\sin x,\ 3x: \\
\because s
$$
比较方法：
$$
\lim \alpha=0(\alpha \ne 0) \ \lim \beta = 0 \\
$$

#### 高阶的无穷小$\lim \frac \beta \alpha=0$

$$
若 \lim \frac \beta \alpha=0,\\
则\beta是比\alpha 高阶的无穷小，趋于0的速度更快\\记作：\beta=o(\alpha)\\
如：\lim_{x\to 0} x^3 \ 与 \lim_{x\to 0} x^2\\
lim_{x\to 0}\frac{x^3}{x^2}=0 \\
$$

#### 低阶无穷小$\lim \frac{\beta}{\alpha}=\infty$
$$
若\lim \frac{\beta}{\alpha}=\infty\\
则称\beta为\alpha的低阶无穷小，趋于0的速度更慢\\
如：\lim_{x\to 0} x^2 \ 与 \lim_{x\to 0} x^3\\
=\lim_{x\to 0}\frac{x^2}{x^3}\\
=\lim_{x\to 0}\frac{1}{x} = \infty\\
\\
$$
#### 同阶无穷小$\lim \frac{\beta}{\alpha}=C(C\ne 0)$

$$
若\lim \frac{\beta}{\alpha}=C(C\ne 0) \\
则称\beta为\alpha的同阶无穷小，趋于0的速度一样，系数可能有区别\\
如：\lim_{x\to 0} x^2 \ 与 \lim_{x\to 0} x^3=\infty\\
$$

#### 等价无穷小

$$
特别地：若\lim \frac{\beta}{\alpha}=1 \\
则称\beta为\alpha的等价无穷小，趋于0的速度一样\\
记作：\beta \sim \alpha \\
如：\lim_{x\to 0} x^2 \ 与 \lim_{x\to 0} x^3=\infty\\
$$

#### K阶无穷小

$$
若\lim \frac{\beta}{{\alpha}^k}=C(C\ne 0,k>0) \\
则称\beta为\alpha的k阶无穷小\\
$$

#### 例1.14

当$x\to 0$时，用$o(x)$表示比$x$高阶的无穷小，则下列式子错误的是

- [x] (A) $x \ o(x^2)=o(x^3)$

将左边整体当作$\beta$，右边整体当作$o(a)$；
$$
\because \beta=o(a) \leftrightarrow \lim \frac{\beta}{\alpha}=0 \\
\therefore 要证：x \ o(x^2)=o(x^3) \\
即证: \lim_{x\to 0} \frac{x \ o(x^2)}{x^3} = 0\\
= \lim_{x\to 0} \frac{o(x^2)}{x^2} = 0\\
$$

> 最后化简的步骤是：a的高阶无穷小除以a，结果是0

- [x] (B) $o(x) \ o(x^2)=o(x^3)$

将左边整体当作$\beta$，右边整体当作$o(a)$；
$$
\lim_{x\to 0} \frac{o(x) \ o(x^2)}{x^3}\\
= \lim_{x\to 0} \frac{o(x)}{x} \frac{o(x^2)}{x^2}\\
= \lim_{x\to 0} 0 \ \lim_{x\to 0} 0 = 0\\
$$

- [x] (C) $o(x^2)+o(x^2)=o(x^2)$

将左边整体当作$\beta$，右边整体当作$o(a)$；
$$
\lim_{x\to 0} \frac{o(x^2) \ o(x^2)}{x^2}\\
= \lim_{x\to 0} (\frac{o(x^2)}{x^2} +\frac{o(x^2)}{x^2})\\
= \lim_{x\to 0} 0 + \lim_{x\to 0} 0 = 0\\
$$

- [ ] (D) $o(x)+o(x^2)=o(x^2)$

将左边整体当作$\beta$，右边整体当作$o(a)$；
$$
\lim_{x\to 0} \frac{o(x) \ o(x^2)}{x^2}\\
= \lim_{x\to 0} (\frac{o(x)}{x^2} +\frac{o(x^2)}{x^2})\\
= ? + \lim_{x\to 0} 0 = ?\\
无法求解
$$

### 无穷小性质

#### 定理：有限个无穷小的和也是无穷小

#### *定理：有界函数与无穷小的乘积也是无穷小

如：$lim_{x\to\infty}e^{-x}\sin x=0$

![image-20220818110312004](https://cdn.notcloud.net/static/md/cy948/202208181103039.png)

#### 定理：$\beta$与$\alpha$是等价无穷小的充分必要条件为$\beta=\alpha+o(\alpha)$

#### *定理：$\alpha \sim \alpha', \beta \sim \beta',且\lim \frac{\beta'}{\alpha'}存在，则\lim \frac{\beta}{\alpha}=\lim\frac{\beta'}{\alpha'}$

$$
若\alpha \sim \alpha',\beta \sim \beta'\\
且\lim \frac {\alpha'} {\beta'}存在\\
则\lim \frac{\alpha}{\beta} = \lim \frac{\alpha'}{\beta'}\\
\because \lim \frac{\alpha}{\beta} = \lim \frac{\alpha'}{\beta'}\\
\therefore \lim \frac{\alpha}{\beta} = \lim \frac{\alpha}{\alpha'} \frac{\alpha'}{\beta}\\
此处\frac {\alpha} {\alpha'}的结果是1，因为他们是等价的\\
\therefore \lim \frac{\alpha}{\beta} = \lim \frac{\alpha'}{\beta}
$$

### 常见的等价无穷小

当$x\to0$时，以下 $\sim x$
$$
\sin x, \tan x, \arcsin x, \arctan x,\\
e^x-1, \ln(1+x)
$$
除此之外：
$$
1-\cos x \sim \frac{1}{2}x^2 \\
(1+x)^\alpha-1 \sim \alpha x
$$
使用示例：
$$
\lim_{x\to0} \frac{x(e^x-1)}{\frac{1}{2}{x^2}} = \\
\lim_{x\to0} \frac{x \ x}{\frac{1}{2}{x^2}} = 2\\
\\
\lim_{x\to0} \frac{x \ \ln(1+2x)}{\cos x - 1} = \\
=\lim_{x\to0} \frac{x \ 2x}{\cos x - 1} \\
= \lim_{x\to0} \frac{x \ 2x}{-\frac{1}{2}x^2} = -4\\
$$

#### 例1.15

设$\alpha_1=x(\cos \sqrt{x} - 1)$，$\alpha_2=\sqrt{x} ln(1+\sqrt[3]{x})$，$\alpha_3=\sqrt[3]{x+1}-1$当$x\to0^+$时，以上3个无穷小从低阶到高阶的排序是：$\alpha_2,\alpha_3,\alpha_1$
$$
\alpha_1=x(\cos \sqrt{x} - 1)\\
= -x(1- \cos \sqrt{x})\\
\sim -x \ \frac1 2 (\sqrt{x})^2
= - \frac 1 2 x^2\
\\
\alpha_2=\sqrt{x} \ ln(1+\sqrt[3]{x}) \\
=\sqrt{x} \ \sqrt[3]{x} \\
= x^{\frac 1 2} \ x^{\frac 1 3} \\
= x^{\frac 5 6}\\
\\
\alpha_3=\sqrt[3]{x+1}-1\\
= (1+x)^{\frac 1 3}-1\\
=\frac 1 3 x
$$

#### 例1.16

$$
\lim_{x\to \infty} x(\sin \ln(1+\frac 3 x)-\sin \ln(1+\frac 1 x))
$$


$$
原式 \\ 
= \lim_{x\to \infty} \frac{ \sin \ln(1+\frac 3 x)-\sin \ln(1+\frac 1 x)}{\frac 1 x}\\
令t=\frac 1 x，则\\
= \lim_{t\to 0} \frac{ \sin \ln(1+3t)-\sin \ln(1+t)}{t}\\
其中\\
1. \ \lim_{t\to 0} \frac{ \sin \ln(1+3t)}{t}\\
= \lim_{t\to 0} \frac{ \ln(1+3t)}{t}\\
= \lim_{t\to 0} \frac{ 3t }{t} = 3\\
\\
2. \ \lim_{t\to 0} \frac{ \sin \ln(1+t)}{t}\\
= \lim_{t\to 0} \frac{ \ln(1+t)}{t}\\
= \lim_{t\to 0} \frac{ t }{t} = 1\\
\\
原式=3-1=2
$$

#### 例1.19

$$
\lim_{x\to 0}\frac{e^{x^2}-1}{\ln(1+x) \sin 2x}
$$


$$
原式 \\
= \lim_{x\to 0}\frac{x^2}{\ln(1+x) \sin 2x}\\
= \lim_{x\to 0}\frac{x^2}{x \ 2x} = \frac 1 2\\
$$

#### 例1.20

$$
\lim_{x\to 0}\frac{\ln(1+x^3)}{x(1-\cos x)}
$$



将$ln(1+x) \sim x$推广得 $\ln (1+\square) \sim \square$，前提是$\square$趋向于0

![image-20220818123849052](https://cdn.notcloud.net/static/md/cy948/202208181238096.png)


$$
原式\\
=\lim_{x\to 0}\frac{x^3}{x \ \frac 1 2 x^2} = 2\\
$$

#### 例1.21

$$
lim_{x\to0}\frac{\sin x-\tan x}{(\sqrt[3]{1+x}-1)(\sqrt{1+\sin x}-1}
$$



>  注意，进行等价无穷小变换时，需要保证他们能够被独立拆分的

$$
原式\\
= lim_{x\to0}\frac{\tan x \ \cos x -\tan x}{({(1+x)}^{\frac 1 3}-1)(({1+\sin x})^{\frac 1 2}-1}\\
= lim_{x\to0}\frac{-\tan x (1- \cos x)}{\frac 1 3 x \ \frac 1 2 \sin x} \\
= lim_{x\to0}\frac{-\frac 1 2 x^2}{\frac 1 3 x \ \frac 1 2 x} = -3\\
$$

#### 例1.22

$$
lim_{x\to0}\frac{e-e^{\cos x}}{\sqrt[3]{1+x^2}-1}
$$


$$
原式\\
= \lim_{x\to0}\frac{e^{\cos x}(e^{1- \cos x}-1)}{(1+x^2)^{\frac 1 3} -1}\\
= e \ \lim_{x\to0}\frac{1- \cos x}{\frac 2 3 x^2 -1}\\
= e \ \lim_{x\to0}\frac{\frac 1 2 x^2}{\frac 2 3 x^2} = \frac 3 2 e\\
$$

#### 例1.23

$$
\lim_{x\to0}\frac{3\sin x+x^2 \ \cos \frac 1 x}{(1+\cos x) \ \ln(1+x)}
$$

解：
$$
原式 \\
=\lim_{x\to0}\frac{1}{1+\cos x} \ \lim_{x\to0}\frac{3\sin x+x^2 \ \cos \frac 1 x}{\ln(1+x)}\\
= \frac 1 2 \lim_{x\to0}\frac{3\sin x+x^2 \ \cos \frac 1 x}{\ln(1+x)}\\
= \frac 1 2 \lim_{x\to0}\frac{3\sin x+x^2 \ \cos \frac 1 x}{x}\\
= \frac 1 2 (\lim_{x\to0}\frac{3\sin x}{x} + \lim_{x\to0} \frac{x^2 \cos \frac 1 x} x)\\
此处利用重要极限\frac {\sin x}{x} = 1\\
= \frac 1 2 (3+x \ \cos \frac 1 x)\\
x \ \cos \frac 1 x 中 \cos x 有界，表达式结果趋于0\\
= \frac 3 2
$$

### 抓大头

抓大头：一般看到上下都有很多个$x$，且上下的$x$乘起来差不多次方，则上下同时除以$x$的最大次方。

![image-20220818154030355](https://cdn.notcloud.net/static/md/cy948/202208181540405.png)

#### 例1.24

$$
\lim_{n\to \infty} \frac {1+2+...+(n-1)}{n^2}
$$

> 属于有限项多项式$\frac {\infty} {\infty}$型极限，不能直接得出值，看到有$n^2$优先考虑抓大头

解：
$$
原式 = \lim_{n\to \infty} \frac {\frac {(1+n-1)(n-1)}{2}} {n^2}\\
= \frac 1 2 \lim_{n\to \infty}(1-\frac 1 n) = \frac 1 2\\
$$

#### 例1.25

$$
\lim_{x\to\infty} \frac{(x+1)(2x-1)(x+3)}{x^2 \ (3x+1)}
$$

$$
实际上，利用抓大头的公式可得结果：\\
\frac {x \ 2x \ x}{x^2 \ 3x} = \frac 2 3
$$

解：
$$
= \lim_{x\to\infty} \frac{(x+1)(2x-1)(x+3)}{x^2 \ (3x+1)}\\
\lim_{x\to\infty} \frac{(\frac 1 x+1)(2\frac 1 x-1)(\frac 1 x+3)}{3 + \frac 1 x}\\
= \frac {1-1+3}{3}
$$

### 求极限时，先分别检查分子分母极限

#### 例1.17

若：
$$
\lim_{x\to0} \frac {\sin x(\cos x - b)}{e^x-a} = 5
$$
则a=? b=?

>  求极限时，养成先分别检查分子分母的极限的习惯

$$
\because \lim_{x\to0} \sin x(\cos x - b)=0\\
\therefore \lim_{x\to0} (e^x-a)=\lim_{x\to0} \frac {\sin x(\cos x -b)}{\frac {\sin x(\cos x -b)}{e^x-a}}\\
因为\lim_{x\to0} \frac {\sin x(\cos x - b)}{e^x-a} = 5\\
= \frac 0 5 = 0\\
\therefore \lim_{x\to0}(e^x-a)\\
= \lim_{x\to0}e^x-\lim_{x\to0}a\\
= 1-a = 0\\
\therefore a =5\\
\therefore 原式=\lim_{x\to0} \frac {\sin x(\cos x - b)}{e^x-1}\\
=\lim_{x\to0} \frac {\sin x(\cos x - b)}{x}\\
=\lim_{x\to0} \frac {x(\cos x - b)}{x}\\
= 1-b=5\\
\therefore b = -4
$$

#### 例1.18

$$
设a>0，且\lim_{x\to0}\frac{x^2}{(b-\cos x)\sqrt{a+x}}=1\\
则a=? b=?
$$

解：
$$
\because x^2 = 0 \\
\therefore \lim_{x\to0} (b-\cos x)\sqrt{a+x} \\
= \lim_{x\to0} \frac{x^2}{ \frac{x^2}{(b-\cos x)\sqrt{a+x}}} = \frac 0 1 = 0\\
\therefore (b-1) \ \sqrt{a} = 0\\
\because a > 0 \therefore b=1\\
\because 原式=\lim_{x\to0}\frac{x^2}{(1-\cos x)\sqrt{a+x}}\\
= \lim_{x\to0}\frac{x^2}{\frac 1 {2} x^2 \sqrt{a+x}}\\
= \lim_{x\to0}\frac {2}{\sqrt{a+x}} = 1\\
\therefore a=4
$$
