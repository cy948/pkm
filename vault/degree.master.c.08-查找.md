---
id: 5h3u6l58ih1869tk542w0dg
title: 08 查找
desc: '重点'
updated: 1667398842881
created: 1666927813676
---


命题重点。
- 对于散列表的构造、冲突处理过程、查找成功和查找失败的平均查找长度、散列查找的特征和性能分析。
- 对于折半查找，应该掌握折半查找的过程、构造判定树、分析平均长度等。
- B树和B+树是本章的难点，B树：要求掌握处插入、删除和查找的过程；B+树：理解概念和性质即可。

## 基本概念

**查找**。在数据集合中寻找满足指定条件的数据元素过程称为 *查找* 。*查找* 的结果一般分为两种：一是 *查找* 成功，即在数据集合中找到了满足条件的数据元素；二是 *查找失败* 。

**查找表（查找结构）**。用于查找的数据结构的集合称为 *查找表* ，它由同一类型的数据元素（或记录）组成，可以是一个数组或链表等数据类型。对查找表经常进行的操作一般有 *4* 种：
1. 查询某个特定的数据元素是否在查找表中；
2. 检索满足条件的某个特定的数据元素的各种属性；
3. 在查找表中插入一个数据元素；
4. 从查找表中删除某个元素；

**静态查找表**。若一个查找表的操作只涉及上述操作 `1.` 和 `2.` ，则无需动态地修改查找表，此类查找表称为 *静态查找表* 。与此对应，需要动态地插入或删除的查找表称为 *动态查找表* 。适合 *静态查询表* 的查找方法有：顺序查找、折半查找、散列查找等；适合 *动态查找表* 的查找方法有 二叉排序树的查找、散列查找等。

**关键词**。数据元素中唯一标识该元素的某个数据项的值，使用基于关键字的查找，查找结果应该是唯一的。例如：一个学生的集合中，“学号”唯一地标识学生；

**平均查找长度**。在查找过程中，一次查找的长度是指需要比较的关键字次数，而平均查找长度则是所有查找过程中进行关键字的比较次数的平均值，其数学定义是：
$$
ASL = \sum^{n}_{i=1}P_iC_i
$$

> ASL(average search length)

*n* 是查找表的长度； $P_i$ 是查找第 *i* 个数据元素的概率，一般认为每个数据元素的查找概率相等，即 $P_i=\frac{1}{n}$ ； $C_i$ 是找到的第 *i* 个数据元素所需进行的比较次数。平均查找长度是衡量查找算法效率的最主要指标。


## 顺序查找和折半查找

### 顺序查找

顺序查找又称 *线性查找* ，它对关键字和链表都是适用的。对于顺序表，可通过数组下标递增来扫描每个元素。顺序查找通常分为对一般的无序线性表的顺序查找和对按关键字有序的线性表的顺序查找。

#### 一般线性表的顺序查找

```c
typedef struct {
    ElemType * elem; // 建表时从下标1开始，0留空
    int TableLen;
} SSTable;
int Search_Seq(SSTable ST, ElemType key){
    ST.elem[0] = key; // 见下文
    for(int i = ST.TableLen; ST.elem[i]; --i);
    return i;
}
```

`ST.elem[0]=key` 的作用：
- 从后往前遍历的过程中，可能没有一个元素 *= key* ；
- 遍历的语句遇到元素 *= key* 时退出；
- 将 *0* 号元素赋值为 *key* 可以使在整个过程中的一定能找到 *key* ，不至于循环无法终止导致数组越界

对于有 *n* 个元素的表，给定指 *key* 与表中第 *i* 个元素相等，即定位第 *i* 个元素时，需进行 *n-i+1* 次关键字的比较，即 $C_i=n-i+1$ 。查找成功时，顺序查找的平均长度为：

$$
ASL_{\text{成功}}=\sum^{n}_{i=1} P_i(n-i+1) \\
$$

当每个元素的查找概率相等，即 $P_i=1/n$ 时，

若查找**成功**有：
$$
ASL_{\text{成功}}=\sum^{n}_{i=1} P_i(n-i+1)=\frac{n+1}{2}
$$

> 想不起来就用推一下
> $$
> ASL_{\text{成功}}=\sum^{n}_{i=1} P_i(n-i+1)\\
> \sum^{n}_{i=1}\frac{n+1-i}{n} =\sum^{n}_{i=1} 1+\frac1n-\frac{i}n\\
> =\frac{2(n + 1)}2 - \frac{(1+n)n}{2n}=\frac{n+1}{2}
> $$


查找**不成功**时，与表中关键字的比较次数显然是 *n+1* 次，从而顺序查找不成功的平均查找长度为 $ASL_{\text{不成功}}=n+1$ 

**结论：**

- **缺点** 是当 *n* 比较大时，平均查找的长度较大，效率低；

- **优点** 是对数据元素的存储没有要求，顺序存储或链式存储皆可。对表中记录的有序性也没有要求，无论记录是否按关键字有序，均可应用。同时还需注意，对线性的链表只能进行顺序查找（因为其无法通过 *O(1)* 的事件访问某个元素）。
- 通常，查找表中的概率并不相等。**改进**： 若能预先得知每个记录的查找概率，则应对记录的查找概率进行排序，使表中的该路按查找概率由大至小重新排列。

#### 有序表的顺序查找

若在查找之间就知道表是关键字有序的，则查找失败时可以不用再比较到表的另一端就能返回查找失败的信息，从而降低查找失败的平均查找长度；

假设表 *L* 是按关键字从小到大排列的，查找的顺序是从前往后，待查找元素的关键字为 *key*，当查找到第 *i* 个元素时，发现第 *i* 个元素关键字大于 *key*，这时就可以返回查找失败的信息。

使用判定树来描述有序线性表的查找过程。树中的圆形结点表示有序线性表中存在的元素；树中的矩形结点称为 **失败结点** （若有 *n* 个结点，则相应地有 *n+1* 个查找失败结点）。它描述的是不在集合中的点，若 *key* 处在描述的范围内，则查找不成功。

![image-20221103200407338](https://cdn.notcloud.net/static/md/cy948/202211032004383.png)

在有序线性表的顺序查找中，查找成功的平均查找长度和一般线性表的顺序查找一样。查找失败时，查找指针一定走到了某个失败结点。这些失败和节点实际上是不存在的，查找不成功的平均查找长度在相等查找概率下为：
$$
ASL_{\text{不成功}}=\sum^{n}_{j=1}q_j(l_j-1)\\
=\frac{1+2+...+n+n}{n+1} = \frac n2+\frac{n}{n+1}
$$
$q_i$ 是到达第 *j* 个失败结点是概率，在相等查找概率的情形下，它为 $\frac{1}{n+1}$ ； $l_j$ 是第 *j* 个失败结点所在的层数。当 *n=6* 时， $ASL_{\text{不成功}} = 6/2 + 6/7 = 3.86$  ，比一般的顺序查找算法好一些。

> ❗有序线性表的顺序查找和后面折半查找的思想不同，且有序线性表的顺序查找的线性表可以是 *链式存储结构*；

### 折半/二分查找

> 仅适用于有序的顺序表

首先将给定值 *key* 与表中中间位置的元素进行比较：

- 若相等则查找成功，则返回该元素的存储位置；
- 若不等，则所需查找的元素一定位于中间元素以外的前半部分或后半部分；

🔁然后缩短范围，重复上述过程；

> ❗注意：
>
> - 初始化时，`low =1 ` ，`hight = ST.Length` 。这是因为 `ST.R[0]` 为 *key* ，并不是第一个元素；
> - 运算过程中，向下取整：`1 + 4 / 2 = 2` ；

```c
int Search_Bin(SSTable ST, KeyType key){ 
    //若找到，则函数值为该元素在表中的位置，否则为0
    low = 1; high = ST.length;

    while(low <= high) {
    // 如果左指针小于右指针，证明遍历已完成，但无法找到

        mid = low + (high - low) / 2;
        //防止整型溢出
        
        if(key == ST.R[mid].key) return mid; //匹配成功
        
        else if(key < ST.R[mid].key)  high = mid - 1; 
        //前往值更小的子表查找

        else low = mid + 1;  
        //前往值更大的子表查找
    }      
    return 0; //表中不存在待查元素
}
```

查看动画：[704. 二分查找 - 力扣（Leetcode）](https://leetcode.cn/problems/binary-search/solutions/6700/hua-jie-suan-fa-704-er-fen-cha-zhao-by-guanpengchn/#画解)，看完记得顺手A一下：

```c
int search(int* nums, int numsSize, int target){
    int left = 0, right = numsSize-1, mid;
    while(left <= right){
        mid = left + (right - left)/2;
        if(nums[mid] == target) return mid;
        if(nums[mid] > target){
            right = mid - 1;
            continue;
        }
        if(nums[mid] < target){
            left = mid + 1;
        }
    }
    return -1;
}
```

递归版：

```c
int search(int* nums, int numsSize, int target){
    return search_iterate(nums, 0, numsSize-1, target);
}
int search_iterate(int* nums, int left, int right, int target){
    if(left > right) return -1;
    int mid = left + (right - left)/2;
    if(nums[mid] == target) return mid;
    if(nums[mid] > target) return search_iterate(nums, left, mid -1, target);
    return search_iterate(nums, mid + 1, right, target);
}
```

#### 复杂度



<img src="https://cdn.notcloud.net/static/md/cy948/202211032101345.png" alt="image-20221103210110306" style="zoom:80%;" />

上图二分查找 *11* 个元素的 *判定树* 中：

- 查找成功时的查找长度是：从根节点到目的结点上的路径上的结点数；

> 含义：每个结点概率相等，从 *n* 个成功的结点中选一个，但带路径长度；
> $$
> ASL_{\text{成功}}=\frac{\sum^n_{j=1}j \ n_{j\text{成功}}}{n_{元素}} \\
> ASL_{\text{成功}}=(1*1+2*2+3*4+4*4)/11=3
> $$
> $n_{j\text{成功}}$ 表示 *j* 层上成功的结点数；
>
> $n_{\text{元素}}$ 表示所有待查找的元素数量；

- 查找不成功时的查找长度为从根节点到对应失败结点父结点的路径上的结点数；

> 含义：每个结点概率相等，从 *n+1* 个失败的结点中选一个，但带路径长度；
> $$
> ASL_{\text{失败}}= \frac{\sum^n_{j=1}(j-1) \ n_{j\text{失败}} }{n_{元素}+1} \\
> ASL_{\text{失败}}=((4-1)*4+(5-1)*8)/12=\frac{11}{3}
> $$
> $n_{j\text{成功}}$ 表示 *j* 层上成功的结点数；
>
> $n_{\text{元素}}$ 表示所有待查找的元素数量；
>
> ❗查找失败结点的 *ASL* 不是图中方形结点，而是方形结点的上一层结点数量（可重复）。


每个结点均大于其左结点值，且均小于其右子结点值。若有序序列有 *n* 个元素，则对应的判定树有 *n* 个圆形的非叶结点和 *n+1* 个方形的叶结点。显然，判定树是一颗 *平衡二叉树*；

$$
ASL=\frac1n\sum_{i=1}^{n}l_i\\
=\frac1n(1 * 1 + 2*2+...+h*2^{h-1})\\
=\frac{n+1}{n}log_2(n+1)-1\\
\therefore O(log_2n)
$$
其中，*h* 是树的高度，并且每个元素为 *n* 时树高 $h=[log_2(n+1)]$ 。所以，二分查找的时间复杂度为 $O(log_2n)$，平均情况下查找效率比顺序查找的效率高；



![[degree.master.c.05-树和二叉树#^cd86a6f7e9uj:#^v25hp7lycs3k]]



#### 特点

> 🤷‍♂️Again， 二分查找需要方便定位查找区域，所以不适用 *链式存储结构*；

- 基于顺序表存储结构；适合**一次排序，多次查找**。因此针对**有序且静态**数据。在动态数据集合中快速查找数据则考虑树查找；

- 数据量小，不需要二分。很直观地可以看到过程中有大量的判断语句分支，数据量小时不及顺序查找。

- 数据量太大时，即使对 `mid` 的计算时产生的整型溢出可以优化，但本身二分查找所要求的连续存储空间会耗费大量内存；不像顺序查找那样，可以将大量数据分段，作为流进行输入。



## 分块查找

> ❗块间有序，块内无序

分块查找又称 *索引顺序查找* ，它吸取了顺序查找和折半查找各自的优点，既有动态结构又适合于快速查找。块内的元素的无需的，块之间是有序的。

**分块有序**，即分成若干子表，要求每个子表中的数值都比后一块中数值小(但子表内部未必有序)。然后将各子表中的最大关键字构成一个索引表，表中还要包含每个子表的起始地址（即头指针）。

<img src="https://cdn.notcloud.net/static/md/cy948/202211032136100.png" alt="image-20221103213644055" style="zoom: 50%;" />

### 特点

分块查找算法的运行效率受两部分影响：查找块的操作和块内查找的操作。所以平均查找长度为：
$$
ASL=L_I+L_S
$$

> 🛑以下内容可以理解

将长度为 *n* 的查找标均匀地分为 *b* 块，每块有 *s* 个记录，再等概率的情况下，若在块内和索引表中均采用顺序查找，则平均查找长度为：
$$
ASL=L_I+L_S=\frac{b+1}{2}+\frac{s+1}2\\
=\frac{s^2+2s+n}{2s}
$$

此时，若 $s=\sqrt{n}$，则平均查找长度取最小值 $\sqrt{n}+1$ ；若对索引表采用折半查找时，则平均查找长度为：
$$
ASL=L_I+L_S=[log_2(b+1)] + \frac{s+1}2
$$
🔎 查找块的操作可以采用顺序查找，也可以采用折半查找（更优）；块内查找的操作采用顺序查找的方式。

## 树型查找

### 二叉排序树

![[degree.master.c.05-树和二叉树#二叉排序树:#^4qnxcb6a1v3g]]



#### 查找

从根节点开始，沿着某个分支向下比较的过程：

- 若二叉排序树不为空，先比较二叉树和目标值，若相等，则成功；
- 若不等：
  - 小于则往左寻找；
  - 大于则往右寻找；

通常，取二叉链表作为二叉排序树的**存储结构**：

```c
typedef struct { // 结点的数据域结构
    KeyType   key; //关键字项
    InfoType  otherinfo;  // 与关键字相关的其他数据项
}ElemType;

typedef struct BSTNode { // 结点结构
    ElemType  data;
    struct BSTNode *lchild, *rchild;      // 左右孩子指针
}BSTNode, *BSTree;
```

搜索**算法**：

```c
BSTree SearchBST(BSTree T, KeyType key){
   if((T == NULL) || key == T->data.key){
		return T;
   }else if(key < T->data.key){
		return SearchBST(T->lchild, key);
       //在左子树中继续查找
   }else return SearchBST(T->rchild, key);    		 
    //在右子树中继续查找
}
```

#### 插入/构造

> 二叉排序树作为一种动态的链表，其特点是树的结构通常不是一次生成的，而是在查找中不断插入的。

- 若二叉排序树为空，则插入结点应为根结点；
- 否则，继续在其左、右子树上查找：
  - 树中已有，不再插入
  - 树中没有，继续查找；
  - 🔁查找直至某个叶子结点的左子树或右子树为空为止，则插入结点应为该叶子结点的左孩子或右孩子。

> ❗插入的元素一定在叶结点上！

```c
int InsertBST(BSTree * T, ElemType e) {
   // 当二叉排序树T中不存在关键字等于e.key 的
   // 数据元素时，插入该元素。
   if (T == NULL){   
       s = malloc(sizeof(BSTNode));
       s->data = e;
       s->lchild = s->rchild = NULL;
       return 1;
   }
   else if (e.key < T.data.key)
       return InsertBST(T -> lchild, e);
   else if (e.key > T.data.key)
       return InsertBST(T -> rchild, e);
} // Insert BST
```

**构造**：依照一个列表依次插入二叉排序树

```c
void CreateBST(BiTree * T, ElemType * keys, int size){
    T = NULL; //初始化 T 为空树
    int i = 0;
    while(i < size){
        InsertBST(T,keys[i++]);
    }
}
```



#### 删除

> ❗ 删除时能简单地把以该节点为根的子树直接删除，删除出后性质必须保持不变；

可分三种情况讨论*被删除的结点*：
1. 是叶子，直接删；
2. 只有左子树或者只有右子树，用子树填补；
3. 既有左子树，也有右子树。

此处直接讨论*既有左子树，也有右子树* 的情况：

1. 因为被删除的结点有左、右子树，所以需要找一个结点：

- 比被删结点的左子树都要大，只能在右子树寻找；
- 也不能太大，因为该结点将替换被删结点，所以该值需要比右子树的值都要小。也就是右子树的“中序遍历第一个结点”；

2. 细化方案：

- 首先，找到其右子树的中序第一个结点，我们知道其通常位于树的最左边。方案是使用 `while` 循环向左进行 `DFS` ，如 `T->left == NULL` ，即结点没有左子树，即为当前树结点的最小值，即：“中序遍历第一个结点”；
- 然后，调用方法对该结点进行删除；
- 最后，将该结点的值替换到待删除结点的值；

> 题目不难

LC [450. 删除二叉搜索树中的节点 - 力扣（Leetcode）](https://leetcode.cn/problems/delete-node-in-a-bst/description/) 参考：[450. 题解](https://leetcode.cn/problems/delete-node-in-a-bst/submissions/379499753/)

>  采用递归算法，每一层递归都向上一层返回删除完成后的根结点；

```c
/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

struct TreeNode* deleteNode(struct TreeNode* root, int key){
    if (root == NULL) return NULL;
    // 如果根结点的值大于目标值
    // 则目标结点只可能位于左子树
    if (root->val > key)
        root->left = deleteNode(root->left, key);return root;
    if (root->val < key)
        root->right = deleteNode(root->right, key);return root;

    // 如果左右子树均存在
    if (root->left && root->right) {
        // 寻找中序遍历的第一个结点
        struct TreeNode * firstInOrder = root->right;
        while (firstInOrder->left) {
            firstInOrder = firstInOrder->left;
        }
        // 从树上删除该结点
        root->right = deleteNode(root->right, firstInOrder->val);
        // 然后把该结点替换掉待删除的目标结点
        firstInOrder->right = root->right;
        firstInOrder->left = root->left;
        // 删除目标结点
        // free(root)
        return firstInOrder;
    }

    // 如果右子树为空
    if (root->right == NULL) {
        struct TreeNode * left = root->left;
        //free(root);
        return left;
    }
    // 左子树为空
    struct TreeNode * right = root->right;
    //free(root);
    return right;
}
```



#### 查找效率分析

在前面二分查找形成的二叉树可以知道：二叉树的查找效率重要取决于树的层数。若二叉树排序树的：

- 高度之差绝对值不超过1，则这样的二叉排序树称为 *平衡二叉树* 它的平均查找长度为 $O(log_2n)$，下文会介绍。
- 若二叉排序树是一个只有左孩子/右孩子的 *单支树* （类似于有序链表），则其平均查找长度为 $O(n)$ 。

<img src="https://cdn.notcloud.net/static/md/cy948/202211051511260.png" alt="image-20221105151112219" style="zoom:80%;" />

<center>
    <h4>
        图7.8 相同关键字依照不同顺序输入的不同二叉排序树
    </h4>
</center>

**一般情况**

如上图 `a` 所示：
$$
ASL_{\text{a.成功}}=(1+2*2+3*4+4*3)/10=2.9
$$
**最坏情况**

输入的序列是有序的，则会形成一个倾斜的单支树，如图 `b` 所示；
$$
ASL_{\text{b.成功}}=(1+2+3+4+5+6+7+8+9+10)/10=5.5
$$
其查找成功的 `ASL` 为：



**总结**

在查找过程中，二叉排序树和二分查找相似。就平均时间性能而言，二叉排序树上的查找和二分查找差不多。但二分查找的判定树唯一，而二叉排序树的查找不唯一，相同关键字其插入顺序的不同可能生成不同的二叉排序树，就如上图 `7.8` 那样。

> 🤔 若在二叉排序中删除并插入某结点，得到的二叉排序树和原来的一样吗？
>
> 不一定一样。分情况讨论：
>
> 1. 左右子树均为空。一样。
>
> 2. 左右子树任一为空。不一样。
>    - 若左子树为空，删除后补充的是其右子树，重新插入后位于其右子的左子树中；
>    - 右子树同理；
> 3. 均不为空。不一样
>    - 重新插入时新结点只能位于左子树中。



### 平衡二叉树

为避免二叉排序树的高度增长过快，出现上图中的 *单支树* 情况，规定在插入或删除操作时，要保证任意结点的左、右子树高度查的绝对值不超过 *1* ，将这样的二叉树称为 **平衡二叉树** (Balanced Binary Tree)，简称 *平衡树* 。定义结点左子树与右子树的高度差为该结点 *平衡因子* ，则平衡二叉树的平衡因子的值只可能是 *1, -1, 0* 。

> 下图结点中的值为平衡因子，计算公式为：
>
> 结点左子树高度 - 结点右子树高度

![image-20221105153131117](https://cdn.notcloud.net/static/md/cy948/202211051531152.png)

#### 插入

每插入一个结点，就要检查是否导致平衡二叉树失衡，若失衡，则进行调整，调整情况如下：

> ❗**图例**：为了有针对性地展示一颗正常工作的平衡二叉树，我们引入了虚拟子树 ，图中使用矩形表示。该虚拟子树自带*高度* H  ，可以通过该 *高度* 计算出其父亲的平衡因子；

1. **LL 平衡旋转（右单旋转）**。由于在结点 *A* 的左孩子B（*L* 该标号仅为说明旋转方法的名字来源，不代表具体结点）的左子树 *BL*（*LL*）上插入了新结点，*BL* 的高度变为 *H+1*，*T* 的平衡因子由 *1* 增至 *2*，导致以 *T* 为根的子树失去平衡，需要一次向右的旋转操作。

![image-20221105221830863](https://cdn.notcloud.net/static/md/cy948/202211052218903.png)

过程包括：

```c
BSTNode * B = A->left; //保存一下B
A->left = B->right; //B->right是BR
B->right = A;
```

2. **RR 平衡旋转（左单旋转）**。同理，结点 *A* 的右孩子B（*R* ）的右子树 *BR*（*RR*）上插入了新结点，*BR* 的高度变为 *H+1*，*A* 的平衡因子由 *-1* 减至 *-2*，导致以 *A* 为根的子树失去平衡，需要一次向左的旋转操作。

```c
BSTNode * B = A->right; //保存一下B
A->right = B->left; //B->left是BL
B->left = A;
```

![image-20221105222335032](https://cdn.notcloud.net/static/md/cy948/202211052223067.png)

3. **LR 平衡旋转（先左后右双旋转）**

<img src="https://cdn.notcloud.net/static/md/cy948/202211082127193.gif" alt="localtestwithplugins" style="zoom:50%;" />

结点 *A* 的左孩子B（*L* ）的右子树 *BR*（*R*）上插入的新结点 *C* 替换了 *BR*，新增了 *CL* 和 *CR*，高度分别为 *H* (H - 1 + 1) 、*H-1* (H - 1)，*A* 的平衡因子由 *1* 增至 *2*，导致以 *A* 为根的子树失去平衡，需要二次旋转操作。

<img src="https://cdn.notcloud.net/static/md/cy948/202211052248754.png" alt="image-20221105224844709" style="zoom: 80%;" />

**手动模拟：**

- 插入 *C* ，*A* 失衡

![image-20221108214955954](https://cdn.notcloud.net/static/md/cy948/202211082149994.png)

- **提C换B**。 为把 *C* “提”到 *B* 的位置，需要两步走：
  - 分别断开 *A->B* 、*B->C*、*C->CL*，然后连接 *B->CL*，
  - 然后将 *C* 提到 *B* 的位置；
  - 连接 *A->C* 、*C->B*；


<img src="https://cdn.notcloud.net/static/md/cy948/202211082221872.png" alt="image-20221108222140825" style="zoom:80%;" />

- **LL**。
  - 去掉 *A->C* 、*C->CR*，连接 *A->CR*；
  - 将 *C* 向上提；
  - 连接 *C->A* ；

<img src="https://cdn.notcloud.net/static/md/cy948/202211082223677.png" alt="image-20221108222302629" style="zoom:80%;" />

4. **RL 平衡旋转（先右后左双旋转）**

<img src="https://cdn.notcloud.net/static/md/cy948/202211082131770.gif" alt="localtestwithplugins" style="zoom:50%;" />

结点 *A* 的右孩子B（*R* ）的左子树 *BL*（*L*）上插入的新结点 *C* 替换了 *BL*，新增了 *CL* 和 *CR*，高度分别为 *H* (H - 1 + 1) 、*H-1* (H - 1)，*A* 的平衡因子由 *-1* 减至 *-2*，导致以 *A* 为根的子树失去平衡，需要二次旋转操作。

![image-20221105230100176](https://cdn.notcloud.net/static/md/cy948/202211052301226.png)

> ❗注意，*LR* 和 *RL* 旋转时，上述新结点到底是插入 *C* 的左子树还是右子树不影响旋转过程
>
> 旋转的**命名规律**：命名即将失衡结点为 *A* ，插入 A 的左结点的左子树就是 LL，进行 *LL* 旋转、插入 *A* 的右结点的左子树树就是 *RL*，执行 *RL* 旋转；
>
> *LR&RL* 的旋转规律：以 *C* 为新的顶点，B换到对面，A往下移动；

#### 插入过程

- `d` ：插入 *7* 后，结点 `15` 平衡因子为 *2*，执行 `LR` 旋转；
- `g` ：插入 *9* 后，结点 `15` 平衡因子为 *2* ，执行 `LL` 旋转；

![image-20221108210422700](https://cdn.notcloud.net/static/md/cy948/202211082104750.png)



#### 删除

其实就是反过程，理解插入即可



#### 查找

同二分查找



### 红黑树

