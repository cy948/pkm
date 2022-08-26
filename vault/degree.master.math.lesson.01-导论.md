---
id: cx3x4d77119ynfeklugxuy8
title: 01 导论
desc: ''
updated: 1661516593705
created: 166151659370
---

# 导论

## 高数的两大问题

1. 求瞬时变化率（$f(x)$）；
2. 求面积（$F(x)$）；

#### 瞬时变化率

从O点出发，求A点的瞬时速度？

![image-20220826203006638](https://cdn.notcloud.net/static/md/cy948/202208262030683.png)

上上述平均速度的公式上，若$\vartriangle t \ \to 0$，可以求出A点的瞬时速度：
$$
f^{'}(x) = \lim_{t\to0} \frac{f(t+\vartriangle t)-f(t)}{\vartriangle t}
$$

#### 面积

求面积实际上是求两个函数包裹区域的面积差（几何代数化）

![image-20220826203511537](https://cdn.notcloud.net/static/md/cy948/202208262035576.png)

将一个函数的面积分割成一定数量的长方形，求面积长方形面积的和（$\sum$）即可：

![image-20220826203747831](https://cdn.notcloud.net/static/md/cy948/202208262037860.png)

将函数$y=x^2$在0到1之间划分为$n$块，则面积为：

![image-20220826203825111](https://cdn.notcloud.net/static/md/cy948/202208262038137.png)
$$
\sum^{n}_{i=1} \frac 1 n \frac {i^2} {n^2} \\
= \frac 1 {n^3} \sum^{n}_{i=1} i^2 \\
= \frac 1 {n^3} \frac {n(n+1)(2n+1)} 6 \\
= \frac {2n^2 + 3n + 1} {n^2} \\
= 2 + \frac 3 n + \frac 1 {n^2} \\ \\
\lim_{n\to\infty} 2 + \frac 3 n + \frac 1 {n^2}  = \frac 1 3
$$

### 主要关系



![image-20220826204710588](https://cdn.notcloud.net/static/md/cy948/202208262047626.png)

求面积（积分）是求变化率（微分）的逆问题：

![image-20220826204757927](https://cdn.notcloud.net/static/md/cy948/202208262047953.png)

## 性质

### 单调性

$$
f(x) \uparrow g(x) \downarrow \\

设 x_1 < x_2\\
\because f(x_1)<f(x_2), g(x_2) < g(x_1)\\
\therefore f(g(x_2)) < f(g(x_1))\\
\therefore f(g(x)) \downarrow \\
\\
f(x) \downarrow g(x) \downarrow \\
设x_1 < x_2 \\
\because f(x_1)>f(x_2), g(x_2)<g(x_1)\\
\therefore f(g(x_2)) > f(g(x_1))\\
\therefore f(g(x)) \uparrow\\
\\
f(x) \uparrow g(x) \uparrow \\
设x_1 < x_2 \\
\because f(x_1) < f(x_2), g(x_1)<g(x_2)\\
\therefore f(g(x_1)) <  f(g(x_2)) \\
\therefore f(g(x)) \uparrow
$$

### 奇偶性

奇函数关于原点对称，有：$f(x) = -f(-x)$

偶函数关于y轴对称，有：$f(x)=f(-x)$



#### 相乘

$$
F(X) = f(x) \cdot g(x) 
$$

##### 一奇一偶

$$
设f(x)为奇函数，g(x)为偶函数\\
F(x) = [f(x)] \cdot [g(x)] \\
F(-x) = [f(-x)] \cdot [g(-x)] \\
= [-f(x)] \cdot [g(x)]\\
\therefore F(x) = -F(-x)\\
F(x) 为奇函数 \\
\\
$$

##### 相同

$$
设f(x)为奇函数，g(x)为奇函数\\
F(x) = [f(x)] \cdot [g(x)] \\
F(-x) = [f(-x)] \cdot [g(-x)] \\
\therefore F(x) = F(-x)\\
F(x) 为偶函数 \\
\\
设f(x)为偶函数，g(x)为偶函数\\
F(x) = [f(x)] \cdot [g(x)] \\
F(-x) = [f(-x)] \cdot [g(-x)] \\
\therefore F(x) = F(-x)\\
F(x) 为偶函数 \\
$$

#### 嵌套

$$
F(X) = f(x) \cdot g(x)
$$

##### 一奇一偶

$$
设f(x)为奇函数，g(x)为偶函数\\
G(x) = f(g(x)) \\
G(-x) = f(g(-x))\\
= f(g(x))\\
\therefore F(x) = F(-x)\\
F(x) 为偶函数 \\
\\
$$

##### 相同

$$
设f(x)为奇函数，g(x)为奇函数\\
G(x) = f(g(x))\\
G(-x) = f(g(-x)) \\
= f(-g(x))\\
= -f(g(x))\\
\therefore F(x) = -F(-x)\\
G(x) 为奇函数 \\
\\
设f(x)为偶函数，g(x)为偶函数\\
G(x) = f(g(x)) \\
G(-x) = f(g(-x)) \\
G(-x) = f(g(x)) \\
\therefore F(x) = F(-x)\\
G(x) 为偶函数 \\
$$

### 周期性

$$
f(x+\sigma) = f(x) \\
\exist \sigma \in D\\
最小正周期\\
f(x+\sigma) \equiv f(x) \equiv C
$$

### 凹凸性



![image-20220826213249806](https://cdn.notcloud.net/static/md/cy948/202208262132847.png)



## 习题



### 例题2 

已知
$$
\sin θ_1 = \sin θ_2 = a, \\
θ_1 ∈ (0, \frac π 2 ), θ_2 ∈ ( \frac π 2 , π)
$$
, 试用a表示θ1和θ2
$$
\arcsin \alpha = \theta_1 \\
\because \arcsin \alpha = \theta_1 ,\frac \pi 2 - \theta_1 = \theta_2 - \frac \pi 2\\
\therefore \theta_2 = \pi - \theta_1\\
= \pi - \arcsin \alpha
$$


### 例题1

![image-20220826232222831](https://cdn.notcloud.net/static/md/cy948/202208262322860.png)
$$
\\
g(f(x)) = \left\{ 
\begin{array}{lc}
\sin (x+2) & x \le -2 \\
e^{(x+2)} & -2 < x < 0 \\
e^{(x^2+1)}  & x \ge 0 \\
\end{array}\right.
$$


