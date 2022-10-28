---
id: 148mt0uteo4vs2q3tzitzaq
title: '07 图的遍历与应用'
desc: ''
updated: 1666698276161
created: 1666620258948
---


## 图的遍历

图的遍历是指从某一顶点出发，按照某种方式沿着图中的边对所有顶点访问且只访问一次。图的遍历算法求解的是图的 *连通性问题* 、*拓扑排序* 和 *求关键路径* 的基础；

> 树是的一种特殊的图，所以树的遍历实际上也可视为一种特殊的图遍历。
>
> 为避免重复访问，设置了 `_Bool visited[]` 数组记录访问；
>
> ```c
> #include <stdbool.h> //可选，不引入就用 _Bool，0替换false 1替换true (C99)
> #define MAX_VERTEX_NUM 100
> bool visited[MAX_VERTEX_NUM]; // 访问记录数组
> void visit(int v); // 访问
> ```

`FirstNeighbor(&G, x)` （获取一个顶点的第一条邻接边）和 `NextNeighbor(&G, x, y)` 下一条邻接边方法是进行图的遍历的基础：

>  ![[degree.master.c.06-图#^burgrclrn2q5:#^bnr3hcx2iz07]]

`BFS` 和 `DFS` 的区别在于：对一个顶点处理时，`BFS` 先访问该顶点的各个邻接点，而 `DFS` 则先递归处理其中一个邻接点，待返回时再访问下一个邻接点；

### BFS

广度优先遍历，类似二叉树的层序遍历，先访问 **距离** 开始的顶点最近的一组邻接边。

#### 思路

遍历检查图的每个顶点，对于顶点 $v_i$ 

- 如未被访问：遍历其邻接点 $w_1, w_2,...,w_n$ ，对于邻接点 $w_i$ ：

  - 如未被访问，访问并标记，从 $w_i$ 出发重复上述动作；

  - 如已被访问, continue；

- 如已被访问, continue；

**实现思路**：

- 遍历每个顶点
  - 如未被访问过就调用 `BFS` 方法；
- `BFS` 方法：
  - 访问 并标记方法传入的顶点，并入队；
  - 如队列不为空，取头顶点，遍历该顶点的邻接点，对于每个邻接点：
    - 如未访问过就访问并标记，随后将其加入队列；
    - 如已访问过，则continue；

**实现（伪代码）**：

```c
void BFSTraverse(Graph * G){
    int v; 
    for(v = 0; v < G->vexnum; ++v){
        // 初始化已访问的初始数据
        visited[v] = true;
    }
    // 初始化队列
    InitQueue(q);
    for(v = 0; v < G->vexnum; ++v){
        if(!visited[v]) BFS(G, v, q);
    }
}
```

`BFS` 方法：

```c
void BFS(Graph * G, int v, Queue q){
    // 访问该顶点并标记为已访问
    visit(v); visited[v] = true;
    EnQueue(q, v);//将顶点v入队
    // 当队列不为空时
    while(!QueueIsEmpty(q)){
        // 取出队列中第一个顶点
        int vertex; DeQueue(q, & vertex);
        // 获取第一个邻接点
        int neighbor;
        for(neighbor = FirstNeighbor(G, vertex);
            neighbor != -1;/*如果顶点存在邻接边*/
            /*下一此循环开始时获取下一个邻接点*/
            neighbor = NextNeighbor(G, v, neighbor)){
            // 判断该邻接点是否已访问过
            if(!visited[neighbor]){
                // 未访问过，进行访问、标记后入队
	            visit(v); visited[neighbor] = true;
                EnQueue(q, neighbor);
            }//if
        }//for
    }//while
}
```

#### 性能分析

**空间：** 需要借助一个辅助队列 *Q* 完成，最坏情况下复杂度为 *O(|V|)*；

> 空间最坏情况：
>
> <img src="https://cdn.notcloud.net/static/md/cy948/202210222027903.png" style="zoom:50%;" />

**时间：** 

> 主要耗时在查找邻接点，与存储结构相关；

- **邻接矩阵**：查顶点还是邻接点都需循环检测矩阵中的整整一行（ *n* 个元素），因此在 `BFSTraverse` 中耗时 *O(|V|)*，在`BFS()` 方法中查找邻接点的时间复杂度为 *O(|V|)*，最坏情况下总的时间复杂度为 $O(|V|^2)$；
- **邻接表**： 在方法 `BFSTraverse` 中遍历每个顶点时，复杂度为 *O(|V|)* ，在 `BFS()` 中遍历每个顶点的邻接边总共耗时 *O(|E|)* (每条边最少会被经过一次)，加上访问 *n* 个头结点的时间，时间复杂度为 *O(|V|+|E|)*；

#### 广度优先生成树

在遍历过程中会产生一棵树，成为 *广度优先生成树* 。给定图的 *邻接矩阵* 是唯一的，产生唯一的广度优先生成树，但 *邻接表* 不是唯一的，生成的树也不唯一；

<img src="https://cdn.notcloud.net/static/md/cy948/202210231639142.png" style="zoom:80%;" />

### DFS

类似树的先序遍历，尽可能 “深” 地遍历一棵树

#### 思路

> 思路与 `BFS` 在对邻接顶点的处理上有差别

遍历检查图的每个顶点，对于顶点 $v_i$ 

- 如未被访问：遍历其邻接点 $w_1, w_2,...,w_n$ ，对于邻接点 $w_i$ ：

  - 如未被访问，访问并标记，调用自身，传入 $w_i$ ；

  - 如已被访问, continue；

- 如已被访问, continue；

**实现思路**：

- 遍历每个顶点
  - 如未被访问过就调用 `DFS` 方法；
- `DFS` 方法：
  - 访问 并标记方法传入的顶点；
  - 如队列不为空，取头顶点，遍历该顶点的邻接点，对于每个邻接点：
    - 如未访问过就访问并标记，随后将其加入队列；
    - 如已访问过，则continue；

**实现（伪代码）：**

> 此处不需要再创建队列，因为采用的是递归调用，使用语言所提供的虚拟方法栈

```c
void DFSTraverse(Graph * G){
    int v;
    for(v = 0; v < G->vexnum; ++v){
        // 初始化已访问的初始数据
        visited[v] = true;
    }
    for(v = 0; v < G->vexnum; ++v){
        if(!visited[v]) DFS(G, v);
    }
}
```

`DFS` 方法：

```c
void DFS(Graph * G, int v){
    // 访问并标记
    visit(v); visited[v] = true;
    // 使用第一条邻接边初始化邻居
    int neighbor;
    for (neighbor = FirstNeighbor(G, v); 
        neighbor != -1;
        neighbor = NextNeighbor(G, v, neighbor)){
        // 如果该顶点未被访问，则以该顶点作为起始点开始深度遍历
        if(!visited[neighbor]){
            DFS(G, neighbor);
        } //if
    } //for
}
```

`DFS` 免递归写法：

> 主要区别在调用自身进行递归时

```c
void DFS_Non_RC(Graph * G, int v){
    // 初始化栈和访问数组
    Stack s; InitStack(&s);
    for(v = 0; v < G->vexnum; ++v){
        // 初始化已访问的初始数据
        visited[v] = true;
    }
    
    // 标记
    visited[v] = true; Push(&s, v);
    int w;
    while(!StackIsEmpty(&s)){
        int neighbor, k;
        Pop(&s, &k); visit(k);
        // 使用第一条邻接边初始化邻居
        for (neighbor = FirstNeighbor(G, k); 
            neighbor != -1;
            neighbor = NextNeighbor(G, k, neighbor)){
            // 如果该顶点未被访问，则以该顶点作为起始点开始深度遍历
            if(!visited[neighbor]){
			    visited[v] = true; Push(&s, neighbor);
            } //if
        } //for        
    }
}
```





#### 性能分析

> 同 BFS；

**空间**： 虽不借助队列，但使用了方法栈，最坏情况下使用空间 *O(|V|)* ；

> 最坏情况：度为1的树；

**时间**： 

>  与BFS一样，耗时也在寻找顶点的邻接点中；

**邻接矩阵**： 查每个顶点 *O(|V|)*，每个顶点邻接点 *O(|V|)* ， 总 $O(|V|^2)$ ；

**邻接表**： 查每个顶点 *O(|V|)*，每条边最少会被访问 *1* 次，所有顶点的邻接点加起来 *O(|E|)* ， 总 *O(|V| + |E|)* ；

#### 深度优先生成树和森林

> 与BFS不同，DFS如果在不连通的情况下，生成的是森林

对 *连通图* 调用 `DFS` 才能产生深度优先树，否则是森林；与 BFS 类似，生成树是否唯一取决于存储结构；

![](https://cdn.notcloud.net/static/md/cy948/202210231926067.png)

### 图的遍历与连通性

> 图的遍历算法可以用来判断连通性

**无向图**： 若连通，则从任一结点出发，仅需一次遍历就能访问所有顶点；若不连通，`BFSTraverse` 或 `DFSTraverse` 中调用 `BFS` 或 `DFS` 方法的次数就是图的 *连通分量* 的个数；

> ![[degree.master.c.06-图#^4zupil2zo7v4:#^r90kbxvwh0fn]]

**有向图**： 有向图分为 *强连通* 和 *非强连通* 的，它的 *连通子图* 也分为 *强连通分量* 和 *连通分量* 。对于有向图，初始点必须对每个顶点都存在路径才能一次访问整个图，所以*非强连通* 分量一次调用 `BFS` 或 `DFS` 都无法访问到该连通分量的所有顶点；

<img src="https://cdn.notcloud.net/static/md/cy948/202210231959702.png" style="zoom:50%;" />

> ![[degree.master.c.06-图#^5ro2khlzxl4m:#^smgtzrxiyfzg]]



## 应用

这部分直接以算法题的出现的可能性较少，但必须要会手工模拟各个算法的执行过程，还需要掌握使用既定模型解决问题的方法

### 最小生成树

> 假设要在 n 个城市之间建立通讯联络网，则连通 *n* 个城市只需要修建 *n-1* 条线路，如何在最节省经费的前提下建立这个通讯网？该问题等价于：构造网的一棵最小生成树，即：在 *e* 条带权的边中选取 *n-1* 条边（不构成回路），使“权值之和”为最小。
>
> 算法一：Prim 普里姆算法
>   归并顶点，与边数无关，适于**稠密**网
> 算法二：Kruskal 克鲁斯卡尔算法
>   归并边，适于**稀疏**网

#### 含义及性质

连通图的生成树：

- 包含图的所有顶点；
- 只含尽可能少的边；
  - 砍去一条边就变成非连通图；
  - 增加一条边就形成回路；

对于一个带权连通无向图 *G=(V, E)* ，生成树不同，每棵树的权（即树中所有边上的权值之和）也可能不同。设 $R$ 为 *G* 的所有生成树的集合，若 $T$ 为 $R$ 中边的权值之和最小的那颗生成树，则 $T$ 称为 *G* 的最小数生成树[^minimumspaningtree]。

[^minimumspaningtree]: [Minimum Spanning Tree Tutorials & Notes | Algorithms | HackerEarth](https://www.hackerearth.com/practice/algorithms/graphs/minimum-spanning-tree/tutorial/)

生成树具有以下性质：

1. **树形不唯一**。$R$ 中可能有多个最小生成树。当图 *G* 的各边权值**互不相等**时，*G* 的最小生成树是**唯一**的； 若无向连通图 *G* 的边数比顶点数少1，即 *G* 本身是一棵树时，则 *G* 的最小生成树就是它本身；
2. **边的权值之和唯一**。虽然最小生成树不唯一，但其对应的边的权值之和总是唯一的，而且是最小的；
3. 边数为 顶点数 - *1* ；

#### 构造

构造生成树有多种算法，但大多数算法都利用了最小生成树的下列性质： 

- 假设 $G=(V,E)$ 是一个带权连通无向图，*U* 是顶点集 *V* 的一个非空子集；
- 若 $(u, v)$ 是一条具有最小权的值的边，其中 $u \in U, v \in V-U$ ；

则必存在一颗包含边 $(u,v)$ 的最小生成树；

一个通用的最小生成树模板：

```c
GENERIC_MST(G){
    bool T = null;
    while (T){
        /* 
        找到一条最小代价边，
        并加入 T 后不会形成回路
        */
    }
}
```



### 最小生成树-Prim 算法

> 归并顶点，与边数无关，适于**稠密**网

#### 定义及手动模拟

设有连通网络 *G = (V, E)*

1. 从某顶点 $V_1$ 出发，选择与它关联的具有最小权值的边 $(V_1,V_3)$，将其顶点加入到生成树顶点集合 *U* 中 ；
2. 每一步从一个顶点在 *U* 中，而另一个顶点不在 *U* 中的各条边中：选择权值最小的边 *(u, v)* ,把它的顶点加入到 *U* 中；
3. 直到所有顶点都加入到生成树顶点集合U中为止；

**步骤**：

b. 在 $V_1$ 出发，选择权值最小的 $V_3$ ，*U* 中的集合为 $\{ V_1,V_3 \}$ ；

c. 选择一个在 *U* 中的顶点 $V_3$ ，不在U中且对于 $V_3$ 来说权值最小的 $V_6$ 加入 *U* ，此时 *U* $\{V_1,V_3,V_6\}$；

d. 选 *U* 中 $V_6$ ，选不在 *U* 中对于 $V_6$ 最小权值的 $V_4$ ，此时 *U* $\{V_1,V_3,V_6, V_4 \}$；

e. 选 *U* 中 $V_3$ ，选不在 *U* 中对于 $V_3$ 最小权值的 $V_2$ ，此时 *U* $\{V_1,V_3,V_6, V_4, V_2 \}$；

f. 选 *U* 中 $V_2$ ，选不在 *U* 中对于 $V_2$ 最小权值的 $ V_5 $ ，此时 *U* $\{V_1,V_3,V_6, V_4, V_2, V_5 \}$；

![image-20221027211158339](https://cdn.notcloud.net/static/md/cy948/202210272111390.png)

#### 伪代码

设置一个辅助数组，对当前 *V－U* 集中的每个顶点，记录和顶点集 *U* 中顶点相连接的代价最小的边；

```c
typedef struct {
     VertexType  adjvex;  // U集中的顶点序号
     VRType  lowcost;  // 边的权值
} closedge[MVNUM];
```

1. 第一次遍历时：

- 以点 *a* 开始，遍历该顶点所有邻接边的权值；
- 如红线，下一次开始时，对权值最小的 *e* 进行此操作；

<img src="https://cdn.notcloud.net/static/md/cy948/202210272156734.png" alt="image-20221027215641673" style="zoom:33%;" />

2. 第二次遍历时：

- 以点 *e* 开始，遍历该顶点所有邻接边的权值；
  - 如遇到 *e* 到该顶点的权值比 *a* 的小时（如途中的 e->b, e->g）则进行覆盖；
  - 覆盖时修改`Adjvex` 数组中的名称及 `Lowcost`  数组中的数值；
- 如红线，下一次开始时，对权值最小的 *d* 进行此操作；

<img src="https://cdn.notcloud.net/static/md/cy948/202210272200430.png" alt="image-20221027220038370" style="zoom:33%;" />

3. 第三次遍历时：

- 以点 *d* 开始，遍历该顶点所有邻接边的权值；

<img src="https://cdn.notcloud.net/static/md/cy948/202210272201384.png" alt="image-20221027220138324" style="zoom:33%;" />

4. 遍历结束：

即可通过 `Adjvex` 数组中的名称及 `Lowcost`  数组中的数值组合成为一颗带权路径树；

<img src="C:\Users\cy948\AppData\Roaming\Typora\typora-user-images\image-20221027220347707.png" alt="image-20221027220347707" style="zoom:33%;" />

把上述步骤抽象成代码：

```c
void MiniSpanTree_Prim(AMGraph G, VertexType u) 
{
  //从顶点u出发构造网G的最小生成树
  k = LocateVex ( G, u ); 
  for ( j=0; j<G.vexnum; ++j )  // 辅助数组初始化
      if (j!=k)  
          closedge[j] = { u, G.arcs[k][j].adj };  
  closedge[k].lowcost = 0;      // 初始，U＝{u}

    for (i=1; i<G.vexnum; ++i) {
  k = Min(closedge[] | closedge[].lowcost>0);  
	// 求出加入生成树的下一个顶点(k)
  cout << closedge[k].adjvex << G.vexs[k]; 
	// 输出生成树上一条边
  closedge[k].lowcost = 0;    // 第k顶点并入U集

  for (j=0; j<G.vexnum; ++j) 
         //修改其它顶点的最小边
      if (G.arcs[k][j] < closedge[j].lowcost)
             closedge[j] = { G.vexs[k], G.arcs[k][j] }; 
}

```

