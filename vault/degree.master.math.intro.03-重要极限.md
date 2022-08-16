---
id: gsn2euq59efizyi45094v20
title: 03 重要极限
desc: ''
updated: 1660641878515
created: 1660641878515
---

# 重要极限

## 定义

>  重要极限是一个词

### $\lim_{x\to 0}\frac{\sin x}x=1$

#### 例1.9 证明$\lim_{x\to 0}\frac{\tan x}x=1$

$$
\lim_{x\to 0}\frac{\tan x}x \\
=\lim_{x\to 0} \frac{\frac{\sin x}{\cos x}}{x} \\
=\lim_{x\to 0} \frac{\sin x}{x \ \cos x} \\
=\lim_{x\to 0} \frac{\sin x}{x} \ \frac{1}{\cos x} \\
= 1 * 1
$$

#### 例1.10 求$\lim_{x\to 0}\frac{1- \cos x}{x^2}$

$$
\lim_{x\to 0} \frac{1-\cos x}{x^2} \\
=\lim_{x\to 0} \frac{(1-\cos x)(1+\cos x)}{x^2 \ (1+\cos x)} \\
=\lim_{x\to 0} \frac{\sin^2 x}{x^2 \ (1+\cos x)} \\
=\lim_{x\to 0} \frac{\sin^2 x}{x^2} \ \frac{1}{1+\cos x} \\
= 1^2 \ \frac{1}{1+\cos x} \\
= \frac{1}{2}
$$

### $\lim_{x\to\infty}(1+\frac{1}{x})^x=e$

- 该函数是幂指函数$f(x)^{g(x)}$

![image-20220816175031245](https://cdn.notcloud.net/static/md/cy948/202208161750265.png)

- 该函数中的$\frac 1 x 和 {}^x $互为倒数，所以也可以这样表达：

![image-20220816174613285](https://cdn.notcloud.net/static/md/cy948/202208161746312.png)
$$
\lim_{x\to\infty}(1+x)^{\frac{1}{x}}=e
$$

- 底数都是$(1+\square)^{\frac{1}{\square}}$

- 实际上，$lim$部分无论趋向$\infty还是0$，目的都是使得底数$(1+\square)^{\frac{1}{\square}}$部分趋近于$0$

![image-20220816174948026](https://cdn.notcloud.net/static/md/cy948/202208161749049.png)

所以有：
$$
若：\lim f(x)=1,\ \lim g(x)=\infty \\ \lim {f(x)}^{g(x)} = \lim[1+(f(x)-1)]^{\frac 1 {f(x)-1} \ g(x)} \\
= {e}^{\lim[f(x)-1]\ g(x)} \\
= {e}^{\lim[f(x)-1]\  \lim g(x)} \\
= {e}^{0\  \lim g(x)} \\
=1
$$
![image-20220816175509119](https://cdn.notcloud.net/static/md/cy948/202208161755145.png)

#### 例1.11

$$
\lim_{x\to 0}(1-x)^{\frac{1}{x}}
\\
= \lim_{x\to 0}(1+(-x))^{\frac{1}{-x} \ (-1)}\\
= e^{(-1)}
$$

