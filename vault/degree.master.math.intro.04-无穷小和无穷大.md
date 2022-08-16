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

- [ ] (C)
