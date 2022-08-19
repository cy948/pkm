---
id: kaf2gwr8s6w59hcpt1lx0rr
title: 06 渐近线
desc: ''
updated: 1660835274660
created: 1660835274660
---
# 渐近线

## 定义

寻找线前先需要找未定义点。

### 垂直渐近线

若$\lim_{x\to\alpha^+}f(x)=\infty$或$lim_{x\to\alpha^-}f(x)=\infty$，则称$x=\alpha$为一条垂直渐近线。数量不限制，如$y=\tan x$ 有无限条。

![image-20220819004723104](https://cdn.notcloud.net/static/md/cy948/202208190047130.png)

求法：

1. 找无定义点 x=a
2. 若$\lim_{x\to a^+}f(x)=\infty$或$\lim_{x\to a^-}f(x)=\infty$ ，则称$a$为一条渐近线；

### 水平渐近线

若$\lim_{x\to + \infty}f(x)=a$或$lim_{x\to - \infty}f(x)=a$，则称$x=\alpha$为一条水平渐近线。最多两条（正负无穷各一条）。记得看情况分别讨论正负无穷。

求法：

1. 求$\lim_{x\to + \infty}f(x)=a$ 和$lim_{x\to - \infty}f(x)=a$

![image-20220819005409247](https://cdn.notcloud.net/static/md/cy948/202208190054267.png)

### 斜渐近线

1. 若$\lim_{x\to +\infty}\frac {f(x)}{x}=k，\lim_{x\to + \infty} [f(x)-kx]=b$，则斜渐近线为$y=kx+b$.
2. 若$\lim_{x\to -\infty}\frac {f(x)}{x}=k，\lim_{x\to - \infty} [f(x)-kx]=b$，则斜渐近线为$y=kx+b$.

![image-20220819010047815](https://cdn.notcloud.net/static/md/cy948/202208190100842.png)

#### 例1.29

曲线$f(x)=e^{\frac{1}{x^2}} \arctan \frac{x^2+x+1}{(x-1)(x+2)}$的渐近线为?

找无定义点：x=0, x = 1, x = -2
$$
垂直渐近线：\\
x=0\\
\lim_{x\to 0}f(x) = e^{\frac{1}{x^2}} \arctan \frac{x^2+x+1}{(x-1)(x+1)}\\
= \infty\\
\\
x=1\\
\lim_{x\to 1}f(x)
= e^{\frac{1}{x^2}} \arctan \frac{x^2+x+1}{(x-1)(x+1)}\\
\ne \infty\\
\\
x=-2\\
\lim_{x\to -2}f(x)
= e^{\frac{1}{x^2}} \arctan \frac{x^2+x+1}{(x-1)(x+1)}\\
\ne \infty\\
\\
水平渐近线：\\
\lim_{x\to\infty}f(x)=\\
\lim_{x\to\infty}e^{\frac{1}{x^2}} \arctan \frac{x^2+x+1}{(x-1)(x+2)}=\frac{\pi}{4}
\\
斜渐近线：无，因为已经有水平渐近线了
$$

#### 例1.30

当$x>0$时，曲线$y=x\sin \frac{1}{x}$

- [ ] (A) 有且仅有水平渐近线;
- [ ] (B) 有且仅有铅直渐近线;
- [ ] (C) 既有水平渐近线，又有铅直渐近线;
- [ ] (D) 既无水平渐近线，又无铅直渐近线;


$$
垂直x=0(虽然大于0，但可以趋于0)\\
\lim_{x\to0}=x\sin \frac{1}{x}=0 \\
不存在\\
\\
水平\\
\lim_{x\to\infty}=x\sin \frac{1}{x}\\
=x \ \frac 1 x = 1\\
有一条y=1
$$

#### 补充

曲线$y=\frac 1 x + \ln(1+e^x)$渐近线有( )条？
$$
垂直渐近线：x=0\\
\lim_{x\to0}(\frac 1 x + \ln(1+e^x))\\
= \lim_{x\to0}(\frac 1 x + \ln(1+e^x)) \ne \infty\\
不存在\\
\\
水平渐近线：\\
\lim_{x\to + \infty}(\frac 1 x + \ln(1+e^x))\\
=\lim_{x\to + \infty}(\frac 1 x + \ln(1+e^x))=\infty\\
在+\infty方向上不存在\\
\lim_{x\to - \infty}(\frac 1 x + \ln(1+e^x))=0\\
(e^x趋于0，\ln1=0)
\\
因为正无穷方向没有水平渐近线，\\所以需要讨论正无穷方向的斜渐近线\\
求k：k=\lim_{x\to+\infty}\frac{y}x\\
=\lim_{x\to+\infty}[\frac 1 {x^2}+\frac{\ln(1+e^x)}{x}]=1\\
b=\lim_{x\to+\infty}[y-kx]\\
=\lim_{x\to+\infty}[\frac 1 x + \ln(1+e^x)-x]=0
$$
![image-20220819113031884](https://cdn.notcloud.net/static/md/cy948/202208191130919.png)



