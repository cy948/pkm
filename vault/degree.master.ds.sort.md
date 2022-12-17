---
id: ud2ogi6bhlmj8zbfnfxh975
title: '排序'
desc: ''
updated: 1670120952592
created: 1670120198217
---

> 主要考察算法之间的比较和实际应用。

## 比较

> 比较有 时空复杂度 、 稳定性、 过程特征

### 时空复杂度

**时间复杂度**

- **简单选择**排序、**直接插入**排序和**冒泡**排序的**平均**情况下的时间复杂度为$O(n^2)$ ，好在**实现简单**，但**直接插入**排序和**冒泡**排序**最好**情况下时间复杂度能达到$O(n)$，简单选择与初始状态无关；
- **希尔**排序是插入排序的拓展，对**大规模**的排序仍有较高的效率，但为得出其精确的时间；
- **堆**排序利用了堆的数据结构，能在线性时间内完成建堆，且在 $O(n\log_2n)$ 内完成排序过程；
- **分治**思想：
  - **快速**排序，虽然**最坏**情况下会达到 $O(n^2)$ ，但**平均**能达到$O(n\log_2n)$ ，实际应用中往往优于其他排序算法；
  - **归并**排序，与分割子序列初始无关，均为$O(n\log_2 n)$



**空间复杂度**

- **简单选择**排序、**插入**排序、**冒泡**排序、**希尔**排序和**堆**排序仅需**常数**个辅助空间，为 $O(1)$；
- **快速**排序需要辅助栈（人工实现或隐性栈）用于递归，**平均**大小为 $O(n\log_2n)$ ，最坏情况下 $O(n)$ ；
- **2-归并**排序在合并操作中需要借助较多的辅助空间用于复制，大小为 $O(n)$ ，有方法减少，但操作会更复杂；



**稳定性**

- **插入**排序、**冒泡**排序、**归并**排序和**基数**排序是稳定的排序方法；
- **简单选择**排序、**快速**排序、**希尔**排序和**堆**排序都是不稳定的排序方法；

> 🤔有无快且稳定？
>
> **归并排序**，稳定且 *2-归并排序* 的平均时间复杂度为 $O(n\log_2n)$ ；
>
> 不用硬背，在熟知过程的情况下，只需要举反例；

**总结表格**

> **简单**选择排序、**归并**排序：**初始条件不影响排序时间**，没有最好最坏；
>
> **希尔**排序：无法计算精准时间，但大规模下仍然有效率；
>
> 空间复杂度中，只有**快速**、**归并**、**基数** 需要辅助空间，其余均可原地进行，复杂度为 $O(1)$；


| 算法种类     | 最好   | 平均     | 最坏     | 空间 | 稳定  |
| ------------ | ------ | -------- | -------- | ---- | ----- |
| 直接插入排序 | $O(n)$ | $O(n^2)$ | $O(n^2)$ |  | <font color="green">是</font> |
| 冒泡排序     | $O(n)$ | $O(n^2)$ | $O(n^2)$ |      | <font color="green">是</font> |
| 简单选择排序 |        | $O(n^2)$ |          |      | <font color="red">否</font> |
| 希尔排序     |        |          |          |      | <font color="red">否</font> |
| 快速排序     | $O(n\log_2n)$ | $O(n\log_2n)$ | $O(n^2)$ | $O(\log_2n)$ | <font color="red">否</font> |
| 堆排序       |        | $O(n\log_2n)$ |          |      | <font color="red">否</font> |
| 2路归并排序 | | $O(n\log_2n)$ | | $O(n)$ | <font color="green">是</font> |
| 基数排序 | | $O(d(n+r))$ | | $O(r)$ | <font color="green">是</font> |



**过程特征**

> 一趟排序后能出现“最大、最小、确定最终位置”？❗放在最大、最小的位置也意味着放在了最终位置；
>
> 给出一个某种算法进行 *1* 或 *n* 次循环后的中间态，问是什么算法。

- 能放在**最大、最小**位置。**冒泡**排序和**堆**排序在每趟处理后都能产生当前的最大值或最小值；
- 仅**最终位置**。**快速**排序一趟确定一个元素的最终位置；第 *i* 趟排列后，会有 *i* 个以上的数出现在最终位置；

- 


## 应用

通常情况，对排序算法的应用需要考虑一下情况：

1. 待排数目 *n*；
2. 元素本身信息量的大小；
3. 关键字的结构及其分布；
4. 稳定性要求；
5. 语言工具的条件，存储结构及辅助空间大小等；

### 小结

1. **初始有序**。选与初始条件相关的排序，**直接**插入和**冒泡**排序；

2. ***n* 较少**。**直接**插入或**简单选择**排序。由于直接插入排序所需的记录移动次数比简单选择的多，如记录本身信息量较大，用 **简单** 选择排序较好；

3. **n 较大**。应采用 $O(n\log_2n)$ 的**快速**排序、**堆**排序和**归并**排序，但细节上有区别：

   - **快速**排序被认为是目前基于比较的内部算法中最好的方法，在关键字**随机分布时**，快速排序的**平均时间最短**；

   - **堆**排序所需的**辅助空间**少于快速排序，并且不会出现快速排序的最坏情况；

   - **归并**排序， **稳定且时间 $O(n\log_2 n )$ ** ，但 *2路归并* 并非最佳，通常可以与直接插入排序结合使用：利用直接插入排序求得较长的有序子文件，然后两两归并，结合后仍是稳定的。

4. **n很大**。记录的关键字位数较少且可分解时，采用基数排序较好；

5. 在基于比较的算法中，每次比较两个关键字的大小比较后，只出现两种可能的转移，因此可以用一颗二叉树来描述判定过程，比较 *n* 个关键字时，任何借助“比较”的排序算法，至少需要 $O(n\log_2n)$ 的时间；

6. 当记录本身信息量较大时，可使用链表代替数组来避免耗费大量时间移动元素；



## 各排序思想

### 插入排序

简单至上。$L(1)$ 必定有序，往后插入时找好位置，使得 $L(2),...$也有序。递推得：$L(n)$ 已经有序，为第 $L_{n+1}$  个元素在 $L(n)$ 里面找到位置插入后， $L(n+1)$ 也有序。插一个就调整前面有序序列的特性决定了两件事：

- 直至最后一次排序前，元素都**可能不出现在最终位置**上。

#### 简单插入

> **简单插入**：老老实实地按照上面定义中的实现；

![[degree.master.c.09-排序#^c3oqrfek54bh:#^w982hfh5c8dw]]

- 最坏情况下，即每次插入都要比较前面序列的每个元素，次数高达（不考虑与哨兵的比较）：

$$
\sum^n_{i=2}(i+1) = \frac{n(n-1)}{2}
$$

- 最好情况就是列表已有序，每次插入都只需比较1次，比较次数就是须排序的元素：$n-1$

#### 折半插入

> **折半插入**：对上述直接插入排序的算法进行优化，将 *比较* 和 *移动* 的操作分离，即先折半查找出元素的待插入位置，然后统一地移动待插入位置之后的所有元素。

![[degree.master.c.09-排序#^f6r15emyf3bc:#^rofnwv8448s2]]

#### 希尔排序

难实现，时间复杂度与步长 $d_k$ 相关。先将整个待排记录序列分割成若干子序列，分别进行直接插入排序，待整个序列中的记录“基本有序”时，再对全体记录进行一次直接插入排序。同样直至最后一次排序前，元素都**可能不出现在最终位置**上。

- 找步长/增量：

- 判读是否为希尔排序：

- 掌握手动模拟过程：

![[degree.master.c.09-排序#手动模拟:#^ea8hdi5889yu]]

### 交换排序

#### 冒泡排序

从后往前（或前往后）两两比较相邻元素的值，若小/大，则交换他们，第一趟结束后产生最大值。



#### 快速排序

基于分治法，每次枢纽都能把表分成两个长度接近的子表时（数据随机）最快，本身有序或逆序时，最慢；算法中，使用**栈或队列**存储区间上界只影响对子序列排序的先后，**不影响最终结果**。

![[degree.master.c.09-排序#^tsh1jnvli9gt:#^mc2xh5t92uoy]]