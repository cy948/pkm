---
id: 3g5hqrdjtu484pinvvaevvt
title: 02 函数极限连续
desc: ''
updated: 1660639409343
created: 1660616348354
---

# 函数极限连续

[TOC]

## 定义

### 自变量趋于无穷大时函数的极限

$$
\lim_{n\to\infty}f(x)=A \\
\forall \varepsilon > 0, \exist x>0,当|x|>X时，|f(x)-A|<\varepsilon \\
$$

注：

![image-20220816103753525](https://cdn.notcloud.net/static/md/cy948/202208161037546.png)
$$
\lim_{n\to\infty}f(x)=A \\
\forall \varepsilon > 0, \exist x>0,当x>X时，|f(x)-A|<\varepsilon \\
\\
\lim_{n\to-\infty}f(x)=A \\
\forall \varepsilon > 0, \exist x>0,当x>-X时，|f(x)-A|<\varepsilon \\
$$
示例：


$$
\lim_{n\to-\infty}f(x)=A
$$


![image-20220816102339498](https://cdn.notcloud.net/static/md/cy948/202208161023527.png)

### 自变量趋于有限值时的函数的极限

$$
\lim_{n\to\infty}f(x)=A \\
\forall \varepsilon > 0,\exist \delta >0\\
当0<|x-x_0|< \delta时，|f(x)-A|<\varepsilon \\ \\ 左右邻域：\\
\lim_{x\to {x_0}^+}f(x)=A ：\\
\forall \varepsilon >0,\exist \delta > 0,\\
当x_0<x<x_0+\delta 时，|f(x)-A|<\varepsilon \\
\\
\lim_{x\to{x_0}-}f(x)=A：\\
\forall \varepsilon>0 \exist \delta > 0 \\ 

当x_0-\delta<x<x_0时|f(x)-A|<\varepsilon \\

\\
默认情况下，\lim_{x\to x_0}f(x)=A 是指 \\

从两边靠近x_0都=A：\\
\lim_{x\to {x_0}^+}f(x)=A \\
\lim_{x\to {x_0}^-}f(x)=A
$$



![image-20220816103841863](https://cdn.notcloud.net/static/md/cy948/202208161038884.png)

#### 邻域$\mathring{U}$

$x_0$的范围可以用“领域”表示
$$
0<|x-x_0|<\delta \\
\\
右邻域：x_0<x<x_0+\delta \\
左邻域：x_0-\delta<x<x_0
$$


![image-20220816104422793](https://cdn.notcloud.net/static/md/cy948/202208161044815.png)

### 定理：函数极限与数列极限的关系

如果极限$lim_{x\to x_n}f(x)存在，\{x_n\}为函数f(x)$ 定义域内任一收敛于$x_0(收敛于意味着是：lim_{n\to x_0}x_n=x_0)$的数列，且满足：$x_n \neq x_0(n\in N_+)$，那么相应的函数值数列$f(x)$必收敛且$lim_{n\to \infty }f(x_n)=lim_{x\to x_0} f(x)$

### 定理：函数极限的唯一性

如果$lim_{x\to x_0}f(x)$存在的话，那么极限唯一

### 定理：函数极限的局部有界性

如果$lim_{x\to x_0}f(x)=A$，那么存在常数$M>0和\delta>0$，使得当$0<|x-x_0|<\delta时，有|f(x)| \le M$
$$
\lim_{x\to x_0}f(x)=A \\
\forall \varepsilon > 0，当0<|x-x_0|<\delta 时，\\
有|f(x)-A|<\varepsilon \\
取：\varepsilon = 1：|f(x)-A| \le 1\\
\\
|f(x)| = |f(x)-A+A| \\
= |f(x)-A|+|A| \\
< 1 + |A| 
$$

### 定理：函数极限的局部保号性

如果$lim_{x\to x_0}f(x)=A,且A>0(或A<0)$那么存在常数$\delta>0$，使得当$0<|x-x_0|<\delta$时，有$f(x)>0或(f(x)<0)$
$$
证明： \\
\because \lim_{x\to x_0}f(x)=A \ :\\ \forall \varepsilon > 0,\exist \delta >0, 
当0<|x-x_0|<\delta时,|f(x)-A|<\varepsilon \\
设：A>0,取\varepsilon>0，\\
当0<|x-x_0|<\delta时，|f(x)-A|<\frac{A}{2}\\
\therefore -\frac{A}{2}<f(x)-A<\frac{A}{2} \\
= \frac{A}{2}<f(x)<\frac{3}{2}A \\
与f(x)同号
$$

### 定理：保号性推论

如果$lim_{x\to x_0}f(x)=A(A \ne 0)$，那么就存在着$x_0$的某一去心邻域$U (x_0)$，当$x\in U(x_0)$时，就有$|f(x)|>\frac{|A|}2 $
$$
取\varepsilon=\frac A 2 >0，\exist \delta>0，\\
当0<x<|x-x_0|，|f(x)- A| \le \frac A 2  \\
|f(x)| \\
= |f(x)-A+A| \\
\therefore |f(x)| > \frac {|A|}2
$$

#### 例1.7

已知极限$lim_{x\to x_0}\frac{f(x)-f(0)}x<0$，则存在$\delta>0$使得（利用极限的局部保号性）

- 对于任意的$x\in (0,\delta)$，有$f(x)$  ? $f(0)$
- 对于任意的$x\in (-\delta,0)$，$f(x)$ ？ $f(x)$

$$
\exist \delta > 0,当0<|x-0|<\delta时\\
\frac{f(x)-f(0)}x<0 \\
即：\\
\because 0<x<\delta时，\frac{f(x)-f(0)}x<0 \\
\therefore f(x)<f(0) \\
\because -\delta<x<0时，\frac{f(x)-f(0)}x<0 \\
\therefore f(x)>f(0) \\
$$

### 推论

如果在$x_0$的去心邻域内$f(x)\ge 0(或f(x)\le0)$，而且$\lim_{x\to x_0}f(x)=A$，那么$A \ge 0或A\le0$

注：若$x\in\mathring{U},f(x)>0且lim_{x\to x_0}f(x)=A$，则$A\ge0$

![image-20220816155943935](https://cdn.notcloud.net/static/md/cy948/202208161559966.png)

## 四则运算

### 定理

> 使用前需要先检查存在性，且都存在

若$limf(x)=A,limf(x)=B$，那么
$$
(1)\lim [f(x)\pm g(x)]\\ 
= \lim f(x)\pm \lim g(x) = A\pm B \\
\\
(2)\lim [f(x) \ g(x)] \\
=\lim f(x) \ \lim g(x) = A \ B \\
\\
(3)若又有B:\\ \ne 0，则\lim \frac{f(x)}{g(x)} =\frac{\lim f(x)}{\lim g(x)}\\
= \frac{A}{B}(B \ne 0)
$$

#### 例1.8

若$lim[f(x)+g(x)]$存在，$\lim f(x)$及$\lim g(x)$是否存在？$\lim [f(x) + g(x)]$及$\lim g(x)$存在，是否一有$\lim f(x)$存在？
$$
1. 不一定：\\
取：f(x)=\lim_{x\to\infty}[x+(-x)]=0 \\
但 \lim_{x\to\infty}x=\infty 不存在 \\
取：f(x)=\lim_{x\to\infty}[x+(-x)]=0 \\
\\
2. 一定：\\
f(x) = [f(x)+g(x)]-g(x)
$$
![image-20220816161738356](https://cdn.notcloud.net/static/md/cy948/202208161617394.png)

