---
id: ek862reo0vix5s1qk17r3aa
title: 01 数列极限连续
desc: ''
updated: 1660527438749
created: 1660527336244
---

# 函数极限连续

[TOC]

## 数列极限

### 定义

#### 数列极限的简单定义：

简单定义，如：$x_n = \frac{1}{n}$ 任意取值：$1, \frac{1}{2}, \frac{1}{3}$ 越来越接近于0

![image-20220815102710086](https://cdn.notcloud.net/static/md/cy948/202208151027111.png)

即：
$$
\lim_{x\to\infty} \frac{1}{n} = 0
$$

#### 严格定义：

设 $\{X_n\}$ 为一数列，如果存在常数$a$，对于任意给定的正数$\varepsilon$，总存在正整数$N$，当$n > N$时，有：
$$
|x_n - a | < \varepsilon
$$
则称$\{ X_n \}$收敛于常数$a$，也视为：
$$
\lim_{n\to\infty} x_n = a
$$

#### 全称量词和存在量词

> 对任意：$\forall$
>
> 存在：$\exists$

上述的定理可以表述为：
$$
\lim_{n\to\infty} x_n = a \leftrightarrow \\
\forall \varepsilon > 0 \exists N \in N_+, 当n > N时，|X_n - a| < \varepsilon
$$

#### 示例1.1

$$
\lim_{n\to\infty} \frac{1}{n} = 0
$$

$假设： \varepsilon = 0.1 = \frac{1}{10} \exists N = 10，当n > N = 10时，|\frac{1}{n} - 0| < \frac{1}{10}$

可以发现$n$从$10$开始，都会小于$\frac{1}{10}$，且越来越接近$0$；

#### 示例1.2 判断两个数列运算结果是否发散

设$\{ x_n \}$收敛，$\{ y_n \}$发散，则

(A) $\{ x_n y_n \}$ 必收敛；

(B) $\{ x_n y_n \}$ 必发散；

> 如果: $x_n = \frac{1}{n}, y_n=n 则 x_n y_n=1成立$，则$lim_{n\to\infty}x_ny_n=1$ 收敛；B不成立；
>
> 如果: $x_n = \frac{1}{n}, y_n=n^2 则 x_n y_n=1成立$，则$lim_{n\to\infty}x_ny_n=n$ ；A不成立；

(C) $\{ x_n + y_n \}$ 必收敛；

- [x] (D) $\{ x_n + y_n \}$ 必发散；

> 反证法：
>
> 1. 假设$lim_{n\to\infty}(x_n+y_n)=a$收敛；
> 2. 由题$\{ x_n \}$必收敛得 $lim_{n\to\infty}x_n=b$
> 3. 进行转换 $\{ y_n \} \rightarrow (x_n+y_n)-x_n$后，使用常数置换变量：
>
> ![image-20220815113639838](https://cdn.notcloud.net/static/md/cy948/202208151136861.png)
>
> 4. 所以，$lim_{n\to\infty} y_n = a - b$，是常数，与题目条件$\{ y_n \}$ 必分散矛盾，故假设不正确，$\{ x_n + y_n \}$ 必发散；

### 收敛数列的性质

#### （极限的唯一性）如果数列$\{ x_n \}$收敛，那么它的极限唯一。

$$
lim_{n\to\infty}=a
$$

很好理解，如果收敛，无限趋于一个极限值，而不是趋于多个；

![image-20220815114456546](https://cdn.notcloud.net/static/md/cy948/202208151144568.png)

#### （收敛数列的有界性）如果数列$\{ x_n \}$收敛，那么数列 $\{ x_n \}$一定有界

数列有界即：$ \exist M > 0 , \forall \varepsilon \in N_+ $ 有：$ | x_n | \leqq m$ ；

收敛即：$lim_{n\to\infty} x_n = a \leftrightarrow \exist N \in N_+ 当 n > N 时，|x_n-a|< \varepsilon$

取：$ \varepsilon =1, \exists N \in N_+ 当 n > N时，有|x_n -a|<1$

1. 得到$|x_n -a|<1$的推论

$$
|x_n -a|<1 \rightarrow |x_n| < |a| + 1 \\
$$

过程：

$$
|x_n| \\ 
= |x_a-a+a| \\
\leqq |x_n-a| + |a| \\
1 + |a|
$$

![image-20220815161308777](https://cdn.notcloud.net/static/md/cy948/202208151613805.png)

2. 令$M=\max \{ |x_1|, |x_2|, ..., |a| + 1 \}$

$$
\forall n \in N_+ : |x_n| \leqq M 有界
$$

##### 例1.1

设$z_n = x_n y_n(n=1,2,...)$，且$lim_{n\to\infty} z_n=0$，则下列命题正确的是

(A)必有$lim_{n\to\infty}x_n=0或lim_{n\to\infty}y_n=0$；

> 设有以下函数：
> $$
> \begin{equation}
> x_n=\left\{
> 	\begin{aligned}
> 		n, n为奇数 \\
> 		0, n为偶数
> 	\end{aligned}
> \right.
> \end{equation}
> $$
>
> $$
> \begin{equation}
> y_n=\left\{
> 	\begin{aligned}
> 		0, n为奇数 \\
> 		n, n为偶数
> 	\end{aligned}
> \right.
> \end{equation}
> $$
>
> 符合条件: $lim_{n\to\infty} x_n y_n=0$
>
> 但实际上 $lim_{n\to\infty} x_n \neq 0$  $  lim_{n\to\infty} y_n \neq 0$

(B)若$lim_{n\to\infty}y_n=0$，则$\{ x_n \}$必为有界数列；

> 设 $x_n = n, y_n=\frac{1}{n^2}$ ，则$lim_{n\to\infty} x_n y_n$是无界函数；

- [x] (C)若$lim_{n\to\infty}x_n=\infty$，则必有$lim_{n\to\infty} y_n=0$；

> 因$lim_{n\to\infty} x_n = \infty$，则$x_n \neq 0$；
>
> 因为：$y_n = \frac{x_n y_n}{x_n}$，当$x$趋于无穷大时，$lim_{n\to\infty} y_n = 0$；

(D)数列$\{ x_n \}$与$\{ y_n \}$ 不可能都是无界数列；

> 设有以下函数：
> $$
> \begin{equation}
> x_n=\left\{
> 	\begin{aligned}
> 		n, n为奇数 \\
> 		0, n为偶数
> 	\end{aligned}
> \right.
> \end{equation}
> $$
>
> $$
> \begin{equation}
> y_n=\left\{
> 	\begin{aligned}
> 		0, n为奇数 \\
> 		n, n为偶数
> 	\end{aligned}
> \right.
> \end{equation}
> $$
>
> 符合条件: $lim_{n\to\infty} x_n y_n=0$，两个都是无界数列；
>



#### （收敛数列与其子数列的关系）如果数列$\{ x_n \}$收敛与$a$，那么它的任一子数列也收敛，且极限也是$a$

如：

1. 若$lim_{n\to\infty} x_n = a$，则

$$
\lim_{n\to\infty} x_{2n}=a
\lim_{n\to\infty} x_{2n+1}=a
$$

> ! 但反证不成立，如：
>
> $lim_{n\to\infty} x_{2n}=a \neq lim_{n\to\infty}x_n=a$
>
> 除非：
>
> $$
> \lim_{n\to\infty} x_{2n}=a \\ \lim_{n\to\infty}x_{2n+1}=a
> $$
> 才可以证明：$lim_{n\to\infty}x_n=a$

2. 若$lim_{n\to\infty} x_n = a$，则

$$
\lim_{n\to\infty} x_{3n}=a \\
\lim_{n\to\infty} x_{3n+1}=a \\
\lim_{n\to\infty} x_{3n+2}=a
$$

> 同样，如满足：
>
> $$
> \lim_{n\to\infty} x_{3n}=a \\ \lim_{n\to\infty}x_{3n+1}=a \\
> \lim_{n\to\infty}x_{3n+2}=a
> $$
> 可以证明：$lim_{n\to\infty}x_n=a$

（收敛数列的保号性）如果$lim x_n=a$且$a>0$或（$a<0$），那么存在正整数$N>0$，当$n>N$时，都有$x_n >0$（或$x_n<0$）。

证明：

1. 因为数列收敛，有：

$$
lim_{n\to\infty}x_n=a$ ，$\forall \varepsilon > 0 \\
   当 n> N时，有|x_n-a|< \varepsilon
$$

2. 取$\epsilon = \frac{a}{2} > 0,\exist N \in N_+,当n>N时，有$

$$
|x_n-a|<\frac{a}{2} \\
所以：a-\frac{a}{2} < x_n < a + \frac{a}{2} 
$$

3. 所以$x_n > a - \frac{a}{2} > 0$

##### 推论：如果数列$\{ x_n \}$从某项起有$x_n > 0$（或$x_n \leq 0$，且$lim_{n\to\infty}=a$，那么$a>0$或$a \leq 0$

如：
- 若$\exist N \in N_+ ，当n>N时，有x_n > 0，且lim_{n\to\infty}x_n = a$，则：$a \geq 0$
- 若$\exist N \in N_+ ，当n>N时，有x_n < 0，且lim_{n\to\infty}x_n = a$，则：$a \leq 0$

#### 定理：（夹逼准则）

如果数列$\{x_n \} \{y_n\}及\{z_n\}$满足以下条件

a. 从某项起，即 $\exists E \in N+，当n>N时，有y_n \leq x_n \leq z_n$；

b. $lim_{n\to\infty}y_n = lim_{n\to\infty}z_n = A$;

> 此处条件中，需要分别推$lim_{n\to\infty}y_n=A$ $lim_{n\to\infty}z_n=A$，因此，如果替换成更specific,更弱的限制条件：
$$
\lim_{n\to\infty}(y_n-z_n)=0 \\
\lim_{n\to\infty}\frac{y_n}{z_n}=1
$$
> 则不成立；

那么数列$\{x_n\}$的极限存在，且$lim_{n\to\infty}x_n=A$

##### 例1.3 注意题目给出条件

$设ln x_n \leq lny_n \leq lnz_n(n=1,2...)且lim_{n\to\infty} \frac{z_n}{x_n}=1，则 lim_{n\to\infty} ln y_n$

(A)存在且等于1

(B)存在且等于0

(C)一定不存在

- [x] (D)不一定存在

> 1. 假设有：
>
$$
x_n = n, y_n = n + \frac{1}{n},z_n=n+ \frac{2}{n} \\
> x_n \leq y_n \leq z_n
$$
>
> 且能满足条件：
> $$
> \lim_{n\to\infty} \frac{z_n}{x_n} = \lim_{n\to\infty} 
> 	\frac{n+\frac{2}{n}}{n} \\
> = \lim_{n\to\infty}(1+\frac{2}{n^2}) 
> = 1
> $$
> 但$lim_{n\to\infty}y_n=+\infty$，不存在；



> 2. 假设有
>
> $$
> $x_n=1,y_n=1+\frac{1}{n},z_n=1+\frac{2}{n} \\
> x_n \leq y_n \leq z_n
> $$
>
> 且能满足条件：
> $$
> \lim_{n\to\infty} \frac{z_n}{x_n} = \lim_{n\to\infty} \frac{1+\frac{2}{n}}{1} = 1
> $$
> 但$lim_{n\to\infty}y_n=1, lim_{n\to\infty}ln y_n=0$

##### 例1.4 怎么用

$$
\lim_{n\to\infty}n(
\frac{1}{n^2+ \pi}+
\frac{1}{n^2+ 2\pi}+
...+
\frac{1}{n^2+ n\pi}
)
$$

> 夹逼准则常用于数列的和式极限；

1. 使用夹逼准则，对数列进行放大缩小

- 放大：

$$
原式 \le \lim_{n\to\infty}n(
\frac{1}{n^2+ \pi}+
\frac{1}{n^2+ \pi}+
...+
\frac{1}{n^2+ \pi}
) \\
= \lim_{n\to\infty} n\frac{n}{n^2+ \pi} \\
= \lim_{n\to\infty} \frac{n^2}{n^2+ \pi}
$$

- 放小：

$$
\lim_{n\to\infty}n(
\frac{1}{n^2+ n\pi}+
\frac{1}{n^2+ n\pi}+
...+
\frac{1}{n^2+ n\pi}
) \\
= \lim_{n\to\infty} n\frac{n}{n^2+ n\pi} \\
= \lim_{n\to\infty} \frac{n^2}{n^2+ n\pi} 
\le 原式
$$

因为：
$$
\lim_{n\to\infty} \frac{n^2}{n^2+ \pi} \\
= \lim_{n\to\infty} \frac{1}{1 + \frac{\pi}{n^2}}
$$

$$
\lim_{n\to\infty} \frac{n^2}{n^2+n \pi} \\
= \lim_{n\to\infty} \frac{1}{1+\frac{\pi}{n}}\\
= 1
$$
由夹逼准则得：
$$
\lim_{n\to\infty}n(
\frac{1}{n^2+ \pi}+
\frac{1}{n^2+ 2\pi}+
...+
\frac{1}{n^2+ n\pi}
) \\ = 1
$$

##### 例1.5 

$$
\lim_{n\to\infty} \sqrt[n]{1+2^n}
$$

> 夹逼准则常用于数列的和式极限；这里是$1+2^n$是几项求和，可以使用，注意：
>
> - 对于最小项的放缩，优先考虑当前最大项

- 放大：

$$
2^0 + 2^n \leq 2^n+2^n = 2*2^n \\
代入原式求值得：\\ 
\lim_{n\to\infty} \sqrt[n]{2*2^n} \\
=\lim_{n\to\infty} 2^{\frac{1}{n}}*2 \\
= 2
$$

- 放小：

>  对于最小项的放缩，优先考虑当前最大项

$$
2^n \leq 1+2^n \\
代入原式求值得：\\
\lim_{n\to\infty} \sqrt[n]{2^n} = \lim_{n\to\infty} 2 = 2
$$

由夹逼准则得：
$$
\lim_{n\to\infty} \sqrt[n]{1+2^n} = 2
$$
同理推广得：
$$
\lim_{n\to\infty} \sqrt[n]{1+2^n+3^n} = 3
$$

###### 一般性推广

$$
\lim_{n\to\infty} \sqrt[n]{{a_1}^n+{a_2}^n+...+{a_m}^n} \\
= max \{ a_1, a_2, a_3, ..., a_m \} \\
a_i > 0,(1 \le i\le m)
$$

#### 定理：（单调有界收敛准则）单调有界的数列必有极限：

如果数列$\{ x_n \}$单调递增有上界（或单调递减有下界），则$lim_{x\to\infty}x_n$一定存在

- 单调递增有上界：

$$
\exist N，当n>N时： \\
x_n \le x_{n+1} \le ... \le M \rightarrow \lim_{x\to\infty}x_n存在
$$

![image-20220815194550129](https://cdn.notcloud.net/static/md/cy948/202208151945159.png)

- 单调递减有下界：

$$
\exist N，当n>N时： \\
x_n \ge x_{n+1} \ge ... \ge M \rightarrow \lim_{x\to\infty}x_n存在
$$

![image-20220815194600483](https://cdn.notcloud.net/static/md/cy948/202208151946514.png)

需要考虑数列的单调性；

##### 例1.6

有数列如下：
$$
\sqrt{2}, \sqrt{2+\sqrt{2}}, \sqrt{2+\sqrt{2+\sqrt{2}}},...
$$
证明数列的极限存在。

1. 使用数学归纳法证明：$\forall n \in N_+, x_n < 2$

- 当$n=1时，x_1=\sqrt{2} < 2，成立$
- 当$n=k时，结论成立，即x_k<2$
- 当$n=k+1时，x_{k+1}=\sqrt{2+x_k} < \sqrt{2+2} = 2$

$\therefore 由数学归纳法知：\forall n \in N_+, x_n < 2$

2. 证明数列单调递增：

需证明：$x_{n+1} - x_n \ge 0 或 \frac{x_{n+1}}{x_n} \ge 1$
$$
x_{n+1}-x_n = \sqrt{2+x_n} - x_n \\
= \frac{(\sqrt{2+x_n}-x_n) + (\sqrt{2+x_n}+x_n)}{\sqrt{2+x_n}+x_n} \\
= \frac{- {x_n}^2+x_n+2}{\sqrt{2+x_n}+x_n} \\
= \frac{- ({x_n}^2-x_n-2)}{\sqrt{2+x_n}+x_n} \\
= \frac{- (x_n+1)(x_n-2)}{\sqrt{2+x_n}+x_n} \\
$$
即证明：
$$
\frac{- (x_n+1)(x_n-2)}{\sqrt{2+x_n}+x_n} >0 \\
$$
证明如下：
$$
\because x_n < 2 \& x_n > 1\\
\therefore - (x_n+1)(x_n-2) > 1 \\

\because x_n > 0 \\
\therefore \sqrt{2+x_n}+x_n > 0 \\

\therefore \frac{- (x_n+1)(x_n-2)}{\sqrt{2+x_n}+x_n} > 0 \\
\\
\therefore x_{n+1}>x_{n} \\
\therefore \{ x_n \} 单调 \\
$$

$$
\therefore 由单调有界准则知，\lim_{n\to\infty}x_n存在 \\
\\
令\lim_{n\to\infty}x_n=A，\\
在x_{n+1}=\sqrt{2+x_n}两边同取n\to\infty \\
\lim_{n\to\infty}x_{n+1}=\lim_{n\to\infty}\sqrt{2+x_n} \\
\therefore A=\sqrt{2+A} \\
\therefore A^2-A-2=0 \\
\therefore (A-2)(A+1)=0 \\
\therefore A=2;
$$

数列极限存在

