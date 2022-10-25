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

