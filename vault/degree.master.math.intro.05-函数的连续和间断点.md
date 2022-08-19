---
id: yyicwor5t98f1j66c3p5f1z
title: 05 函数的连续和间断点
desc: ''
updated: 1660796577986
created: 1660796577986
---

# 函数的连续和间断点

## 连续函数的定义

$$
\vartriangle y = f(x_0+\vartriangle x)\\
若\lim_{\vartriangle x\to 0} \vartriangle y = 0\\则y=f(x)在x=x_0出连续\\ 
\\
若\lim_{x\to x_0}[f(x)-f(x_0)]=0，\\
则y=f(x)在x=x_0出连续\\
\\
y=f(x)在x_0处连续\Longleftrightarrow \\
\lim_{x\to x_0}f(x)=\lim_{x\to x_0}f(x_0) \Longleftrightarrow \\
\lim_{x\to {x_0}^-} f(x)= \lim_{x\to {x_0}^+} f(x) = f(x_0)
$$



![image-20220818164830635](https://cdn.notcloud.net/static/md/cy948/202208181648658.png)

#### 例1.26

设：
$$
\begin{equation}
f(x)=\left\{
\begin{array}{rcl}
    x \ \sin \frac 1 x  & {x>0}\\
    a+x^2 &  {x \le 0}\\
\end{array} \right.
\end{equation}
$$
在$(-\infty,+\infty)$处连续，求$a$.

解：
$$
依题意：f(x)在x=0处连续\\
\lim_{x\to 0^+}f(x)=\lim_{x\to 0^-}f(x)=f(0)\\
\therefore \lim_{x\to 0^+} x \sin \frac 1 x = 0\\
\lim_{x\to 0^-} a+x^2 =0\\
\therefore a = 0
$$

## 函数的间断点

### 分类

> 按照间断点是否存在进行划分

#### 第一类间断点

左右两个间断点均存在
$$
\lim_{x\to x^-}f(x),\lim_{x\to x^+}f(x)均存在
$$

1. 左右极限相等（可去间断点）

$$
\lim_{x\to x^-}f(x) = \lim_{x\to x^+}f(x) \ne f(x_0)
$$

间断点不存在或间断点不等于极限

![image-20220818171918400](https://cdn.notcloud.net/static/md/cy948/202208181719422.png)

2. 左右极限不等

$$
\lim_{x\to x^-}f(x) \ne \lim_{x\to x^+}f(x)
$$

跳跃间断点

![image-20220818172046411](https://cdn.notcloud.net/static/md/cy948/202208181720432.png)

#### 第二类间断点

左间断点或右间断点不存在

1. 无穷间断点

$$
\lim_{x\to x^-}f(x) = \infty 或 \lim_{x\to x^+}f(x) = \infty
$$

2. 震荡间断点

$$
x=0, y=\sin \frac 1 x
$$

靠近0时，y会震荡变化

#### 例1.27

有函数$f(x)$定义如下，则$f(x)$的第一类间断点、第二类间断点分别是？
$$
f(x)=\frac{1}{e^{\frac{x}{x-1}}-1}
$$
解：
$$
找无定义点 x=1，x=0\\
\lim_{x\to0}f(x)=\lim_{x\to0}\frac{1}{e^{\frac{x}{x-1}}-1}=\infty\\
属于第二类间断点\\
\\
\lim_{x\to1}f(x)=\lim_{x\to1}\frac{1}{e^{\frac{x}{x-1}}-1}\\
此处因为e^{\frac{x}{x-1}}是指数函数，需要分正负方向\\
x\to1^-,\frac{x}{x-1}\to-\infty,e^{\frac{x}{x-1}}\to0\\
\lim_{x\to1^-}\frac{1}{e^{\frac{x}{x-1}}-1}=\frac 1 {-1} = -1\\
x\to1^+,\frac{x}{x-1}\to\infty,e^{\frac{x}{x-1}}\to\infty\\
\lim_{x\to1^+}\frac{1}{e^{\frac{x}{x-1}}-1}=0\\
属于第一类间断点
$$

#### 例1.28

设$x_0$为$f(x)$的间断点，则下列函数一定在$x_0$处间断的是

- [ ] (A)$ f(x) sin x$

- [x] (B)$f(x)+\sin x$

反证法：
$$
假设x_0在f(x)+\sin x上连续，则有：\\
f(x)=[f(x)+\sin x] -\sin x\\
因为f(x)+\sin x和\sin x均为连续\\
所以f(x)也是连续，\\
与题设x_0为f(x)间断点矛盾
$$


- [ ] (C)$f^2(x)$

- [ ] (D)$|f(x)|$
