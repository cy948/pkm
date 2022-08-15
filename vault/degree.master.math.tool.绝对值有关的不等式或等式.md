---
id: ar1f79h65cq5rw8q1mtg1e0
title: 绝对值有关的不等式或等式
desc: ''
updated: 1660548557696
created: 1660548422342
---

> 作者：[知乎三千弱水](https://www.zhihu.com/question/474094278)
> 链接：https://www.zhihu.com/question/474094278/answer/2015826434
> 来源：知乎
> 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

# 绝对值不等值

## 不等式

### 1

$$
|a | \leqslant b, b > 0 \Leftrightarrow-b \leqslant a \leqslant b
$$

等号成立

### 2

$$
|a| > b > 0 \Leftrightarrow a > b
$$
### 3 三角不等式

$$
|a+b |\leqslant| a|+| b |
$$

仅当 $a b \geqslant 0$ 时等号成立

#### 推论 1

$$
|a+b| \geqslant|| a|-| b||
$$



仅当 $a b \leqslant 0 $时等号成立

#### 推论 2

设 $\left\{a_{k}\right\} $为实或复数列,则
$$
\left|\sum_{k=1}^{\infty} a_{k}\right| \leqslant \sum_{k=1}^{\infty}\left|a_{k}\right| \\
$$
#### 推论 3

$$
\left|\sum a_{k}\right| \geqslant\left|a_{j}\right|-\sum_{k \neq j}\left|a_{k}\right| \\
$$


其他较复杂的绝对值不等式基本都是在以上三个的基础上加以推导

### 4

设$ z=x+i y 为复数, \bar{z}=x-i y $为 $z$ 的[共轭复数](https://baike.baidu.com/item/共轭复数/2486343),则
$$
|x| \leqslant|z|,|y| \leqslant | z| \\
\max \{|x|,|y||\leqslant| z \mid \leqslant 2 \max \{|x|,|y|\} \\
\frac{1}{\sqrt{2}}(|x|+| y |) \leqslant | z|\leqslant| x|+| y | \\
||z_{1}|-| z_{2}|| \leqslant\left|z_{1}+z_{2}\right| \leqslant\left|z_{1}\right|+\left|z_{2}\right| \\
$$

### 5 Hlawka 不等式

$$
\left|a_{1}\right|+\left|a_{2}\right|+\left|a_{3}\right|-\left|a_{1}+a_{2}\right|-\left|a_{2}+a_{3}\right|-\left|a_{3}+a_{1}\right|+\left|a_{1}+a_{2}+a_{3}\right| \geqslant 0 \\
$$



推广
$$
\sum_{1\leq i < j\leq n}\left|a_{i}+a_{j}\right| \leqslant(n-2) \sum_{k=1}^{n}\left|a_{k}\right|+\left|\sum_{k=1}^{n} a_{k}\right| \\
$$
式中 $a_{k} \in R^{m}$

### 6 Hornich 不等式

设 $a, a_{k} \in R^{m}$满足
$$
\sum_{k=1}^{n} a_{k}=-t a, t \geqslant 1 \\
$$
则
$$
\sum_{k=1}^{n}\left(\left|a_{k}+a\right|-\left|a_{k}\right|\right) \leqslant(n-2)|a| \\
$$
与其他结合

#### 1 数论相关

##### 01

若 $x \geqslant 1$, 则存在正常数 c, 使得
$$
\left|\sum_{p \leqslant x} \frac{\ln p}{p}-\ln x\right| < c \\
$$

##### 02

设复数$ z$ 的实部 $\operatorname{Re} z=a > 0$, 则

$$
\left|\frac{1}{(p-1)^{z}}-\frac{1}{p^{z}}\right| \leqslant \frac{|z|}{(p-1)^{a+1}} \\
$$

##### 03
设$ a > 1$, 则

$$
\left|\sum_{p < N} \ln \left(1-\frac{1}{p^{a}}\right)+\sum_{p < N} \frac{1}{p^{a}}\right| \leqslant \sum_{n=1}^{\infty} \frac{1}{n^{2}} \\\left|\ln \sum_{n=1}^{\infty} \frac{1}{n^{a}}-\sum_{\rho} \frac{1}{p^{a}}\right| \leqslant \sum_{n=1}^{\infty} \frac{1}{n^{2}} \\
$$

##### 04 Dirichlet 不等式
对任意实数$ \alpha$ 和$ \beta>1$, 必存在有理数 $p / q$,使得
$$
\left|\alpha-\frac{p}{q}\right|<\frac{1}{q \beta}, q \leqslant \beta \\
$$

##### 05 Hurwitz 不等式

对任意实数 \alpha, 必存在无限多个有理数 p / q 使得
$$
\left|\alpha-\frac{p}{q}\right|<\frac{1}{\sqrt{5} q^{2}} \\
$$
式中$\sqrt{5}$ 是最佳常数

##### 06 Thue 不等式

设 $\alpha$ 是次数 $n \geqslant 3$ 的代数数, 则
$$
\left|\alpha-\frac{p}{q}\right| \leqslant \frac{1}{q^{n}} \\
$$
##### 07 Mahlc 不等式:

存在 $$1 < m < n$$, 使得
$$
\frac{1}{m^{42}}<\left|\pi-\frac{n}{m}\right|<\frac{\pi}{2 m} \\
$$
##### 08 联立渐近不等式

对于任意 $n$ 个实数 $a_{1}, \cdots, a_{n}$, 都存在不同时为零的整数$ k_{1}, \cdots, k_{n}$, 及自然数$ m$, 使得
$$
\left|a_{j}-\frac{k_{j}}{m}\right| \leqslant \frac{n}{n+1} \cdot m^{-(1+1 / n)}, 1 \leqslant j \leqslant n \\
$$
#### 2 代数相关

##### 01 

$C_{p}$ 不等式设$a, b$ 为实数, $p > 0$, 则
$$
(|a|+|b|)^{p} \leqslant C_{p}\left(|a|^{p}+|b|^{p}\right) \\
$$
式中
$$
C_{p}= \begin{cases}1, & 0 < p \leqslant 1, \\ 2^{p-1}, & p > 1 .\end{cases} \\
$$
这个不等式有蛮多推广，篇幅有限，只举一种

推论
设$ 0 \leqslant t \leqslant 1$, 则当$ p \geqslant 1$ 时, 成立
$$
|t a+(1-t) b|^{p} \leqslant t|a|^{p}+(1-t)|b|^{p} \\
$$
##### 02 Bohr 不等式

设$ c > 0, a, b$ 为实数或复数,则
$$
|a+b|^{2} \leqslant(1+c)|a|^{2}+\left(1+\frac{1}{c}\right)|b|^{2} \\
$$
仅当 $a=c b$ 时等号成立

##### 03 Mazur 不等式

设$p \geqslant 1$, 则
$$
2^{1-p}|x-y|^{p} \leqslant\left.|x| x\right|^{p-1}-y|y|^{\mid p-1}|\leqslant p| x-y \mid\left(|x|^{p-1}+|y|^{p-1}\right) \\
$$
##### 04 Young 不等式

设 $p, q > 0, \frac{1}{p}+\frac{1}{q}=1$. 则当 $1 < p < \infty$ 时成立
$$
|a b|\leqslant \frac{1}{p}| a|^{p}+\frac{1}{q}|b|^{q} \\
$$
当$ 0 < p < 1$ 时,不等号反向

#### 3 三角函数相关

##### 01 Gronwall 不等式

设
$$
f(x)=\frac{\sin x}{x}, g(x)=\frac{1-\cos x}{x} \\
$$
(1) $\mid f^{(n)}(x) । \leqslant \frac{1}{n+1}$, 仅当 $n $为偶数且 $x=0$ 时等号成立.

(2)$ \mid g^{(n)}(x) । \leqslant \frac{1}{n+1}$, 仅当$ n $为奇数且 $x=0 $时等号成立.

##### 02 Goodman 不等式

设 $\alpha, \beta $为实数,$ n$ 为自然数,则
$$
\left|\frac{\cos n \alpha-\cos n \beta}{\cos \alpha-\cos \beta} \right|\leqslant n^{2} \\
$$
推广
设 $\alpha, \beta $为实数, $m, n $为自然数, 则
$$
\left|\frac{\cos m \alpha \cos n \beta-\cos m \beta \cos n \alpha}{\cos \beta-\cos \alpha}\right| \leqslant\left|m^{2}-n^{2}\right| \\
$$
##### 03 Fejer不等式

设
$$
x_{k}=\frac{2 k-1}{2 n} \pi, 1 \leqslant k \leqslant n, 0 < x < \pi \\
$$
则
$$
\left|\frac{\cos n x}{\cos x-\cos x_{k}}\right| \sin x_{k} \leqslant 2 n \\
$$
##### 04 Makouski 不等式

若 $x, y, \alpha$ 为实数.$ c > 0$, 则
$$
(x-y)^{2} \sin \alpha+(x+y)^{2} \cos \alpha \leqslant(1+c|\cos 2 \alpha|) x^{2}+\left(1+\frac{1}{c}|\cos 2 \alpha|\right) y^{2} \\
$$
##### 05 两个反三角函数不等式

$$
|\operatorname{arctan} x| < \frac{2 |x|}{1+\sqrt{1+x^{2}}}<2 \\|\operatorname{arctan} x-\operatorname{arctan} y| \leqslant 2\left|\operatorname{arctan} \frac{x-y}{2}\right| \leqslant|x-y| \\
$$
##### 06

设$ \sum A=k \pi, k $为奇数, 则
$$
\left|\prod \cos \left(n+\frac{1}{2}\right) A\right| \leqslant \frac{3}{8} \sqrt{3} \\
$$
##### 07

设 $\sum A=k \pi, k$ 为奇数,$t > 0$, 令 $\beta=1-(t / 2)$, 则
$$
\sum|\sec (n+(1 / 2)) A|^{t} \geqslant 2^{t} 3^{\beta}\\
$$
#### 4 积分不等式

##### 01 Opial——华罗庚不等式

设$f^{\prime} \in C[0, a], f(0)=f(a)=0, f(x)>0, x \in(0, a)$则：
$$
\int_{0}^{a}\left|f f^{\prime}\right| \mathrm{~d}x\leqslant \frac{a}{4} \int_{0}^{a}\left(f^{\prime}\right)^{2}\mathrm{~d}x \\
$$
推广(华罗庚不等式)

设 $f \in A C[0, a], f(0)=0, p \geqslant 0, q \geqslant 1$  则
$$
\int_{0}^{a}\left|f\right|^{p} |f^{\prime}|^{q}\mathrm{~d}x \leqslant \frac{q a^{p}}{p+q} \int_{0}^{a}\left|f^{\prime}\right|^{p+q} \mathrm{~d}x \\
$$
##### 02 Hardy 不等式(任意区间上)

$0 \leqslant a < b \leqslant \infty, 1 < p <\infty,则当 \alpha< 1-1 / p 时，$
$$
\int_{a}^{b}\left|x^{\alpha- 1} \int_{a}^{x} f(t) \mathrm{d} t\right|^{p} \mathrm{~d} x \leqslant c \int_{a}^{b}\left|x^{\alpha} f(x)\right|^{p} \mathrm{~d} x \\
$$
而当 $\alpha>1-1 / p $时，
$$
\int_{a}^{b}\left|x^{\alpha-1} \int_{a}^{b} f(t) \mathrm{d} t\right|^{p} \mathrm{~d} x \leqslant c \int_{a}^{b}\left|x^{\alpha} f(x)\right|^{p} \mathrm{~d} x . \\
$$
##### 03 Gruss 型不等式

设$ f, g \in L[a, b]$, 记
$$
A(f)=\frac{1}{b-a} \int_{a}^{b} f \\
$$
则
$$
|A(f g)-A(f) A(g)| \leqslant \frac{1}{b-a} \int_{0}^{b}[f(x)-A(f)][g(x)-A(g)] \mathrm{d} x \\
$$
##### 04 Ostrowski 不等式

设 f 在 (a, b) 上可微,且
$$
\left\|f^{\prime}\right\|_{\infty}=\sup \left\{f^{\prime}(x) \mid\right.\\
: x \in(a, b)\}<\infty.
$$

则$ \forall x \in(a, b)$, 成立

$$
\left|f(x)-\frac{1}{b-a} \int_{a}^{b} f\right| \leqslant\left[\frac{1}{4}+\left(\frac{x-\frac{a+b}{2}}{b-a}\right)^{2}\right](b-a)\left\|f^{\prime}\right\|_{\infty} . \\
$$
##### 05 Iyengar 不等式

设在区间 $[a, b]$ 上, $f $的导数$f^{\prime} $的绝对值有界: $\left|f^{\prime}(x)\right| \leqslant M$, 则：

$$
\left|\frac{1}{b-a} \int_{a}^{b} f(x) \mathrm{d} x-\frac{1}{2}[f(a)+f(b)]\right| \leqslant \frac{1}{4} M(b-a)\left[1-\left(\frac{f(b)-f(a)}{M(b-a)}\right)^{2}\right] \\
$$

推广:

设在区间$ [a, b]$ 上,$ |f^{\prime \prime}(x) | \leqslant M$, 则
$$
\left| \frac{1}{b-a} \int_{a}^{b} f(x) \mathrm{d} x-\frac{1}{2}[f(a)+f(b)]+\frac{1}{8}\left(1+Q^{2}\right)(b-a)\left[f^{\prime}(b)-f^{\prime}(a)\right] \right| \leqslant \frac{M(b-a)^{2}}{24}\left(1-3 Q^{2}\right) \\
$$
式中
$$
Q^{2}=\frac{\left[f^{\prime}(a)+f^{\prime}(b)+f(a)-f(b)\right]^{2}}{M^{2}(b-a)^{2}-\left[f^{\prime}(b)-f^{\prime}(a)\right]^{2}} \\
$$

##### 06 Mahajani 不等式

设 $f^{\prime} \in C[a, b]$ 且$ f(a)=0,$ 则
$$
\left|\int_{a}^{x} f(t) \mathrm{d} t\right| \leqslant \frac{(x-a)^{2}}{2}\left\|f^{\prime}\right\|, x \in[a, b] \\
$$
推广

设在区间 $[a, b]$ 上,$ | f^{\prime}(x) | \leqslant M,$ 且$ \int_{a}^{b} f(x) \mathrm{d} x=0,$ 则对于 $a \leqslant x \leqslant b$, 有
$$
\left|\int_{a}^{x} f(x) \mathrm{d} x\right| \leqslant \frac{M(b-a)^{2}}{8} \\
$$
若加上条件 $f(a)=f(b)=0$, 则
$$
\left|\int_{a}^{x} f(x) \mathrm{d} x\right| \leqslant \frac{M(b-a)^{2}}{12} \\
$$
若函数 $f$ 在区间$ [a, b]$ 上有 $2 n$ 阶连续导数,且$f^{(k)}(a)=f^{(k)}(b)=0, k=0, 1,2, \cdots, n-1$, 则
$$
\left|\int_{a}^{x} f(x) \mathrm{d} x\right| \leqslant \frac{(n !)^{2}(b-a)^{2 n+1}}{(2 n) !(2 n+1) !}\left\|f^{(2 n)}\right\| \\
$$

##### 07 Lyapunov 不等式

设$ p$ 是 $[a, b] $上实值连续函数,若微分方程$ y^{\prime \prime}+p(x) y=0$有非平凡解$ y$, 且 $y$ 在$ [a, b]$ 的两点为零,$ p$ 必满足不等式:
$$
(b-a) \int_{a}^{b}|p(x)| \mathrm{d} x>4 \\
$$
##### 08 Zmorovic 不等式

设导数$ f^{\prime} $在区间$ [a, b] $上绝对连续,则
$$
\int_{a}^{b}\left[f^{\prime \prime}(x)\right]^{2} \mathrm{~d} x \geqslant \frac{12}{(b-a)^{3}}\left|f(b)-2 f\left(\frac{a+b}{2}\right)+f(a)\right|^{2} \\
$$
式中系数$ \frac{12}{(b-a)^{3}}$ 不能再改进

推广
设导数$ f^{\prime}$ 在区间$ [a, b]$ 上绝对连续,则对于任意$ c, a < c < b, p > 1$. 有
$$
\int_{a}^{b}\left|f^{\prime \prime}(x)\right|^{p} \mathrm{~d} x \geqslant\left|\frac{p-1}{2 p-1}(b-a)\right|^{1-p}\left|\frac{f(b)-f(c)}{b-c}-\frac{f(c)-f(a)}{c-a}\right|^{p} \\
$$
##### 09 梯度不等式

设 $\nabla f $为 $f$ 的梯度:
$$
|\nabla f(x)|=\left(\sum_{k=1}^{n}\left(\partial f / \partial x_{k}\right)^{2}\right)^{1 / 2} \\
$$
##### 10 抛物线公式(Simpson 公式) :

设
$$
R_{n}=\int_{u}^{b} f-\frac{b-a}{6 n}\left[f(a)+f(b)+2 \sum_{k-1}^{n-1} f\left(x_{2 k}\right)+4 \sum_{k=1}^{n} f\left(x_{2 k-1}\right)\right] \\
$$
式中
$$
x_{k}-x_{k-1}=\frac{b-a}{2 n}, x_{0}=a, x_{2 n}=b \\
$$
则
$$
|R_{n} | \leqslant \frac{b-a}{180}\left(\frac{b-a}{n}\right)^{4}\left\|f^{(4)}\right\| \\
$$
##### 11 Dirichlet 核$D_{n}(t)$ 的积分不等式

##### 

$$
\int_{0}^{\pi}\left|D_{n}(t)\right| \mathrm{d} t=\int_{0}^{\pi / 2} \frac{|\sin (2 n+1) t |}{\sin t} \mathrm{~d} t < \pi\left(1+\frac{\log n}{2}\right) \quad(n \geqslant 2) \\
$$
推广
$$
\begin{aligned}&\frac{2}{\pi} \ln (n+1) \leqslant \int_{0}^{\pi}\left|D_{n}(t)\right| \mathrm{d} t \leqslant \frac{\pi}{2}(1+\ln (2 n+1))\\ &\int_{0}^{2 \pi} \mid D_{n}(t)| \mathrm{d} t < \left\{\begin{array}{l}\pi(\ln n+\ln \pi)+2\left(1+\frac{1}{2 n}\right) \\ \pi \ln n\left(1+\frac{\ln \pi}{\ln 2}+\frac{5}{2 \pi \ln 2}\right) ;\end{array}\right.\\ &\int_{0}^{1 / n}| D_{n}(t) | \mathrm{d} t \leqslant 1+\frac{1}{2 n} ;\\ &\int_{1 / n}^{\pi}\left|D_{n}(t)\right| \mathrm{d} t \leqslant \frac{\pi}{2}(\ln \pi+\ln n)\\ &\int_{x}^{\pi} |D_{n}(t) |\mathrm{d} t \leqslant \frac{\pi}{(n+1) x}, 0 < x < \pi \end{aligned}\\
$$
#### 杂例

##### 01 积分不等式

(1)
$$
\begin{aligned} \left|\int_{0}^{\infty} \frac{\alpha \sin \sqrt{\beta^{2}+x^{2}} }{\sqrt{x^{2}+\beta^{2}}\left(x^{2}+\alpha^{2}+\beta^{2}\right)} \mathrm{d} x \right| \leqslant \frac{c}{\sqrt{\alpha^{2}+\beta^{2}}} \end{aligned}\\
$$
(2)
$$
\left|\int_{\frac{2}{(2 n+1) \pi}}^{\frac{2}{(2 n-1) \pi}} \sin \left(\frac{1}{\sin (1 / t)}\right) \mathrm{d} t\right| \leqslant \frac{c}{n^{3}} \\
$$
(3) 若 p \geqslant 2, 则
$$
\int_{-\infty}^{\infty}\left|\frac{\sin t}{t}\right|^{p} \mathrm{~d} t \leqslant \sqrt{\frac{2}{p}} \cdot \pi \\
$$
(4) 设 0 < a < \pi, 则
$$
\int_{a / 2}^{\pi / 2}\left|\frac{\sin (2 n+1) t}{\sin t}\right| \mathrm{d} t \leqslant \frac{2}{2 n+1} \csc \frac{a}{2}+\frac{2}{\pi} \log \frac{4}{a} \\
$$
(5)
$$
\int_{\frac{k-1}{n}}^{\frac{k}{n}}\left|\frac{\sin n \pi x}{\sin \pi x} \mathrm{~d} x\right| \geqslant \frac{2}{k \pi} \\
$$
(6) 对于所有实数 $a_{k}, k=1,2, \cdots, n-1$, 有
$$
\int_{0}^{\pi}\left|x-\sum_{k=1}^{n-1} a_{k} \sin k x\right| \mathrm{d} x \geqslant \frac{\pi^{2}}{2n} \\
$$
(7)
$$
\int_{-\pi}^{\pi}\left|\cos \frac{2 n+1}{2} t\right| \cdot \left|\frac{1}{\sin \left(\frac{t}{2}+\frac{\pi}{4 n+2}\right)}-\frac{1}{\sin \left(\frac{t}{2}-\frac{\pi}{4 n+2}\right)}\right| \mathrm{d} t<8 \pi^{2} \\
$$
(8) 对于在区间 (0,1) 上的连续函数
$$
\int_{0}^{1} \int_{0}^{1}|f(x)+f(y)| \mathrm{~d} x \mathrm{~d} y \geqslant \int_{0}^{1} \int_{0}^{1}|f(x)-f(y)| \mathrm{~d} x \mathrm{~d} y \\
$$
##### 02 级数不等式

(1)

任何一组实数 $x_{1}, \cdots, x_{n}$, 存在不等式
$$
\sum_{i=1}^{n} \sum_{j=1}^{n}\left|x_{i}+x_{j}\right| \geqslant \sum_{i=1}^{n} \sum_{j=1}^{n}\left|x_{i}-x_{j}\right| \\
$$
(2)

设 f 是 (0, b) 上非负凸函数
$$
f(0)=0,0 \leqslant a_{k} < b, 0 \leqslant k \leqslant n, a_{0}=0，\sum_{k=1}^{n}\left|a_{k}-a_{k-1}\right| < b \\
$$
则
$$
\sum_{k=1}^{n}\left|f\left(a_{k}\right)-f\left(a_{k-1}\right)\right| \leqslant f\left(\sum_{k=1}^{n}\left|a_{k}-a_{k-1}\right|\right) \\
$$
##### 未解问题

01 Erdös 猜想
\int_{-\pi}^{\pi}\left|T_{n}(x)\right| \mathrm{~d} x \leqslant 4 \\

02 Keogh 猜想
设

a_{k}=\mp 1, k=0,1, \cdots, n, b_{k}=a_{n} a_{n-k}+a_{n-1} a_{n -k-1}+\cdots+a_{k} a_{0} \\

是否成立

\sum_{k=1}^{n}\left|b_{k}\right|^{2}>A n^{2} \\

其中 A 为绝对常数,



## 几道常见绝对值积分不等式习题

例1[1]
设 f(x)f(x) 在 [0,1][0,1] 上有连续的二阶导数, f(0)=f(0)= f(1)=0f(1)=0, 当 $x \in(0,1)x \in(0,1) 时, f(x) \neq 0f(x) \neq 0$, 证明:
$$
\int_{0}^{1}\left|\frac{f^{\prime \prime}(x)}{f(x)}\right| \mathrm{d} x \geqslant 4 \\\int_{0}^{1}\left|\frac{f^{\prime \prime}(x)}{f(x)}\right| \mathrm{d} x \geqslant 4 \\
$$
例2
设 $a>0, f(x)a>0, f(x) 在 [0, a][0, a] $上有连续的导函数, 证明
$$
\frac{1}{a} \int_{0}^{a}|f(x)| \mathrm{d} x+\int_{0}^{a}\left|f^{\prime}(x)\right| \mathrm{d} x \geqslant |f(0)| \\\frac{1}{a} \int_{0}^{a}|f(x)| \mathrm{d} x+\int_{0}^{a}\left|f^{\prime}(x)\right| \mathrm{d} x \geqslant |f(0)| \\
$$
例3
设$ f(x)f(x) 在 [0,1][0,1] $上有连续的导函数, 证明
$$
| f(x) | \leqslant\int_{0}^{1}|f(x)| \mathrm{d} x+\int_{0}^{1}\left|f^{\prime}(x)\right| \mathrm{d} x \\| f(x) | \leqslant\int_{0}^{1}|f(x)| \mathrm{d} x+\int_{0}^{1}\left|f^{\prime}(x)\right| \mathrm{d} x \\
$$
例4
$$
\left|\int_{k}^{k+1} \sin \left(t^{2}\right) \mathrm{d} t\right|<\frac{1}{k} , \quad k \in \mathbb{Z}^{+} \\\left|\int_{k}^{k+1} \sin \left(t^{2}\right) \mathrm{d} t\right|<\frac{1}{k} , \quad k \in \mathbb{Z}^{+} \\
$$
例5

设$ f(x)f(x) 在 [0,1][0,1] $上有连续的导函数, 且 $f(0)=f(0)= f(1)=0f(1)=0$, 则对任意 的$ \xi \in(0,1)\xi \in(0,1)$, 都有
$$
|f(\xi)|^{2} \leqslant\frac{1}{4} \int_{0}^{1}\left|f^{\prime}(x)\right|^{2} \mathrm{~d} x \\|f(\xi)|^{2} \leqslant\frac{1}{4} \int_{0}^{1}\left|f^{\prime}(x)\right|^{2} \mathrm{~d} x \\
$$
例6

设$ f(x)f(x) 在 [0,1][0,1] 上连续可导, 且 f(0)=0f(0)=0, f(1)=1f(1)=1$, 证明:
$$
\int_{0}^{1}\left|f^{\prime}(x)-f(x)\right| \mathrm{d} x \geqslant \frac{1}{\mathrm{e}} \\\int_{0}^{1}\left|f^{\prime}(x)-f(x)\right| \mathrm{d} x \geqslant \frac{1}{\mathrm{e}} \\
$$
例7-1[2]

设$ f(x)f(x) 在 [a, b][a, b] 上连续可导,且 f(b)=0f(b)=0,$ 则
$$
\int_{a}^{b}\left|f(x) f^{\prime}(x)\right| \mathrm{d} x \leqslant \frac{b-a}{2} \int_{a}^{b} f^{\prime 2}(x) \mathrm{d} x . \\\int_{a}^{b}\left|f(x) f^{\prime}(x)\right| \mathrm{d} x \leqslant \frac{b-a}{2} \int_{a}^{b} f^{\prime 2}(x) \mathrm{d} x . \\
$$
例7-2

设 $f(x)f(x) 在 [a, b][a, b] 上连续可导,且 f\left(\frac{a+b}{2}\right)=0f\left(\frac{a+b}{2}\right)=0,$ 则
$$
\int_{a}^{b}\left|f(x) f^{\prime}(x)\right| \mathrm{d} x \leqslant \frac{b-a}{4} \int_{a}^{b}\left|f^{\prime}(x)\right|^{2} \mathrm{~d} x \\\int_{a}^{b}\left|f(x) f^{\prime}(x)\right| \mathrm{d} x \leqslant \frac{b-a}{4} \int_{a}^{b}\left|f^{\prime}(x)\right|^{2} \mathrm{~d} x \\
$$
例7-3

设$ f(x)f(x) 在 [a, b][a, b] $上连续可导,且$ \exists x_{0} \in(a, b)\exists x_{0} \in(a, b) 使 f\left(x_{0}\right)=0f\left(x_{0}\right)=0$, 试证明
$$
\int_{a}^{b}\left|f(x) f^{\prime}(x)\right| \mathrm{d} x \leqslant \frac{b-a}{2} \int_{a}^{b} f^{\prime 2}(x) \mathrm{d} x \\\int_{a}^{b}\left|f(x) f^{\prime}(x)\right| \mathrm{d} x \leqslant \frac{b-a}{2} \int_{a}^{b} f^{\prime 2}(x) \mathrm{d} x \\
$$

