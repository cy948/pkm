---
id: 1j9m6b09al19l86d3pmczqo
title: layoutsincss
desc: '常见的双飞翼布局、圣杯布局'
updated: 1658932306617
created: 1658906047633
---


# 常见的CSS布局

## Flex与Float

[MDN Flex](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox)

使用以下属性定义两根轴线。

### [主轴](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox#主轴)

主轴由 `flex-direction` 定义，可以取 4 个值：`row`| `row-reverse` | `column` | `column-reverse`

> `main-axis`的方向上包含item及item的间隔，而`cross-axis`不包含item之间的间隔

如果选择了 `row` 或者 `row-reverse`，你的主轴将沿着 `inline` 方向延伸。

![](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox/basics1.png)

`column` 或者 `column-reverse` 时，你的主轴会沿着上下方向延伸 — 也就是 `block` 排列的方向。

![If flex-direction is set to column the main axis runs in the block direction.](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox/basics2.png)

### [交叉轴](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox#交叉轴)

交叉轴垂直于主轴，所以如果你的`flex-direction` (主轴) 设成了 `row` 或者 `row-reverse` 的话，交叉轴的方向就是沿着列向下的。

![If flex-direction is set to row then the cross axis runs in the block direction.](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox/basics3.png)

如果主轴方向设成了 `column` 或者 `column-reverse`，交叉轴就是水平方向。

![If flex-direction is set to column then the cross axis runs in the inline direction.](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox/basics4.png)

理解主轴和交叉轴的概念对于对齐 flexbox 里面的元素是很重要的；flexbox 的特性是沿着主轴或者交叉轴对齐之中的元素。

### [起始线和终止线](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox#起始线和终止线)

另外一个需要理解的重点是 flexbox 不会对文档的书写模式提供假设。过去，CSS 的书写模式主要被认为是水平的，从左到右的。现代的布局方式涵盖了书写模式的范围，所以我们不再假设一行文字是从文档的左上角开始向右书写，新的行也不是必须出现在另一行的下面。

你可以在接下来的文章中学到更多 flexbox 和书写模式关系的详细说明。下面的描述是来帮助我们理解为什么不用上下左右来描述 flexbox 元素的方向。

如果 `flex-direction` 是 `row` ，并且我是在书写英文，那么主轴的起始线是左边，终止线是右边。

![Working in English the start edge is on the left.](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox/basics5.png)

如果我在书写阿拉伯文，那么主轴的起始线是右边，终止线是左边。

![The start edge in a RTL language is on the right.](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox/basics6.png)

在这两种情况下，交叉轴的起始线是 flex 容器的顶部，终止线是底部，因为两种语言都是水平书写模式。

之后，你会觉得用起始和终止来描述比左右更合适，这会对你理解其他相同模式的布局方法（例如：CSS Grid Layout）起到帮助的作用。

### [Flex 容器](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox#flex_容器)

文档中采用了 flexbox 的区域就叫做 flex 容器。为了创建 flex 容器，我们把一个容器的 [`display`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/display) 属性值改为 `flex` 或者 `inline-flex`。 完成这一步之后，容器中的直系子元素就会变为 **flex 元素**。所有 CSS 属性都会有一个初始值，所以 flex 容器中的所有 flex 元素都会有下列行为：

- 元素排列为一行 (`flex-direction` 属性的初始值是 `row`)。
- 元素从主轴的起始线开始。
- 元素不会在主维度方向拉伸，但是可以缩小。
- 元素被拉伸来填充交叉轴大小。
- [`flex-basis`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/flex-basis) 属性为 `auto`。
- [`flex-wrap`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/flex-wrap) 属性为 `nowrap`。

这会让你的元素呈线形排列，并且把自己的大小作为主轴上的大小。如果有太多元素超出容器，它们会溢出而不会换行。如果一些元素比其他元素高，那么元素会沿交叉轴被拉伸来填满它的大小。

### [用 flex-wrap 实现多行 Flex 容器](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox#%E7%94%A8flex-wrap%E5%AE%9E%E7%8E%B0%E5%A4%9A%E8%A1%8Cflex%E5%AE%B9%E5%99%A8)

虽然flexbox是一维模型，但可以使我们的flex项目应用到多行中。在这样做的时候，您应该把每一行看作一个新的flex容器。任何空间分布都将在该行上发生，而不影响该空间分布的其他行。

为了实现多行效果，请为属性flex-wrap添加一个属性值wrap。现在，如果您的项目太大而无法全部显示在一行中，则会换行显示。下面的实时例子包含已给出宽度的项目，对于flex容器，项目的子元素总宽度大于容器最大宽度。由于flex-wrap的值设置为wrap，所以项目的子元素换行显示。若将其设置为nowrap，这也是初始值，它们将会缩小以适应容器，因为它们使用的是允许缩小的初始Flexbox值。如果项目的子元素无法缩小，使用nowrap会导致溢出，或者缩小程度还不够小。



在指南中您可以了解更多关于 flex-wrap的信息 Mastering Wrapping of Flex Items.

### 简写属性 [flex-flow](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox#%E7%AE%80%E5%86%99%E5%B1%9E%E6%80%A7_flex-flow)

你可以将两个属性 flex-direction 和 flex-wrap 组合为简写属性 flex-flow。第一个指定的值为 flex-direction ，第二个指定的值为 flex-wrap.

在下面的例子中，尝试将第一个值修改为 flex-direction 的允许取值之一，即 row, row-reverse, column 或 column-reverse, 并尝试将第二个指定值修改为 wrap 或 nowrap。


### 正式使用[Flex](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox#%E7%AE%80%E5%86%99%E5%B1%9E%E6%80%A7_flex-flow)进行布局

为了更好地控制 flex 元素，有三个属性可以作用于它们： `flex-grow` | `flex-shrink` |
 `flex-basis`

> 在考虑这几个属性的作用之前，需要先了解一下 可用空间 available space 这个概念。这几个 flex 属性的作用其实就是改变了 flex 容器中的可用空间的行为。同时，可用空间对于 flex 元素的对齐行为也是很重要的。

假设在 1 个 500px 的容器中，我们有 3 个 100px 宽的元素，那么这 3 个元素需要占 300px 的宽，剩下 200px 的可用空间。在默认情况下，flexbox 的行为会把这 200px 的空间留在最后一个元素的后面。

![](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox/basics7.png)


如果期望这些元素能自动地扩展去填充满剩下的空间，那么我们需要去控制可用空间在这几个元素间如何分配，这就是元素上的那些 flex 属性要做的事。

#### 使用[属性：flex-basis](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox#flex_%E5%85%83%E7%B4%A0%E5%B1%9E%E6%80%A7%EF%BC%9Aflex-basis)定义剩下空间

flex-basis 定义了该元素的空间大小（the size of that item in terms of the space），flex 容器里除了元素所占的空间以外的富余空间就是可用空间 available space。 该属性的默认值是 auto 。此时，浏览器会检测这个元素是否具有确定的尺寸。 在上面的例子中，所有元素都设定了宽度（width）为 100px，所以 flex-basis 的值为 100px。

如果没有给元素设定尺寸，flex-basis 的值采用元素内容的尺寸。这就解释了：我们给只要给 Flex 元素的父元素声明 display: flex ，所有子元素就会排成一行，且自动分配小大以充分展示元素的内容

#### 使用元素属性[flex-grow](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox#flex_%E5%85%83%E7%B4%A0%E5%B1%9E%E6%80%A7%EF%BC%9A_flex-shrink)增加元素所占剩余空间的大小

flex-grow 若被赋值为一个正整数， flex 元素会以 flex-basis 为基础，沿主轴方向增长尺寸。这会使该元素延展，并占据此方向轴上的可用空间（available space）。如果有其他元素也被允许延展，那么他们会各自占据可用空间的一部分。

如果我们给上例中的所有元素设定 flex-grow 值为 1，容器中的可用空间会被这些元素平分。它们会延展以填满容器主轴方向上的空间。

flex-grow 属性可以按比例分配空间。如果第一个元素 flex-grow 值为 2，其他元素值为 1，则第一个元素将占有 2/4（上例中，即为 200px 中的 100px）, 另外两个元素各占有1/4（各50px）。

#### 使用Flex 元素属性[flex-shrink](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Flexible_Box_Layout/Basic_Concepts_of_Flexbox#flex_%E5%85%83%E7%B4%A0%E5%B1%9E%E6%80%A7%EF%BC%9A_flex-shrink)减少元素所占剩余空间的大小

flex-grow属性是处理 flex 元素在主轴上增加空间的问题，相反flex-shrink属性是处理 flex 元素收缩的问题。如果我们的容器中没有足够排列 flex 元素的空间，那么可以把 flex 元素flex-shrink属性设置为正整数来缩小它所占空间到flex-basis以下。与flex-grow属性一样，可以赋予不同的值来控制 flex 元素收缩的程度 —— 给flex-shrink属性赋予更大的数值可以比赋予小数值的同级元素收缩程度更大。

在计算 flex 元素收缩的大小时，它的最小尺寸也会被考虑进去，就是说实际上 flex-shrink 属性可能会和 flex-grow 属性表现的不一致。因此，我们可以在文章 [《控制 Flex 子元素在主轴上的比例》](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Flexible_Box_Layout/Controlling_Ratios_of_Flex_Items_Along_the_Main_Ax) 中更详细地看一下这个算法的原理。

### 灵活[控制Flex的大小](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Flexible_Box_Layout/Controlling_Ratios_of_Flex_Items_Along_the_Main_Ax#%E6%8E%8C%E6%8F%A1flex_items%E7%9A%84%E5%A4%A7%E5%B0%8F)

什么设置 flex item 的基本大小？

flex-basis设置为auto吗，这个 flex 子元素设置了宽度吗？如果设置了，flex 子元素的大小将会基于设置的宽度。
flex-basis 设为 auto 还是content (在支持的浏览器中)? 如果是auto, flex 子元素的大小为原始大小。
flex-basis是不为0的长度单位吗？如果是这样那这就是 flex 子元素的大小。
flex-basis 设为 0呢？如果是这样，则 flex 子元素的大小不在空间分配计算的考虑之内。
我们有可用空间吗？
flex 子元素没有 positive free space 就不会增长，没有 negative free space 就不会缩小。

- 如果我们把所有的 flex 子元素的宽度相加（如果在列方向工作则为高度），那么总和是否小于 flex 容器的总宽度（或高度）？如果是这样，那么你有 positive free space，并且flex-grow会发挥作用。

- 如果我们把所有的 flex 子元素的宽度相加（如果在列方向工作则为高度），那么总和是否大于 flex 容器的总宽度（或高度）？如果是这样，那么你有 negative free space，并且flex-shrink会发挥作用。

### 分配空间的[其他方式](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Flexible_Box_Layout/Controlling_Ratios_of_Flex_Items_Along_the_Main_Ax#%E5%88%86%E9%85%8D%E7%A9%BA%E9%97%B4%E7%9A%84%E5%85%B6%E4%BB%96%E6%96%B9%E5%BC%8F)

如果我们不想空间添加到 flex 子元素中，记住你可以在 flex 容器中使用指南中所描述的对准属性来处理 flex 子元素之间或者 flex 子元素周围的空闲空间，以致可以对齐 flex 子元素。`justify-content` 属性能够在 flex 子元素之间或 flex 子元素周围分配空闲空间。您还可以在 flex 子元素上使用自动边距 ( `auto margins` ) 来吸收空间并在 flex 子元素之间创建间距。

## Grid[布局](https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Grids)

我们平时使用的栅栏化的布局。

Grid布局包含`列` `行` `间隔`

![](https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Grids/grid.png)

### 定义一个Grid布局

以下是一个HTML节点树

```pug
container
    item
    item
    item
```

#### 最简单的grid容器

```css
.container {
    display: grid;
    grid-template-columns: 200px 200px 200px;
}
```
<style>
.gridContainer{
    display: grid;
    grid-template-columns: 50px 50px 50px;
}
.gridContainer>div{
    background-color: lightblue;
    border: solid black 1px;
}
</style>
<body>
    <div class="gridContainer">
        <div>One</div>
        <div>Two</div>
        <div>Three</div>
        <div>Four</div>
        <div>Five</div>
        <div>Six</div>
        <div>Seven</div>
    </div>
</body>

#### 带有间距的动态Grid容器

> 间隔可以进行指定，如指定列的间距`column-gap`|`row-gap`
> ```css
> .container {
>    display: grid;
>    grid-template-columns: 2fr 1fr 1fr;
>    grid-gap: 20px;
>    gap: 20px;
>}
> ```
>

<style>
.gridContainerFlex{
    display: grid;
    gap: 20px;
    grid-template-columns: 2fr 1fr 1fr;
}
.gridContainerFlex>div{
    background-color: lightblue;
    border: solid black 1px;
}
</style>
<body>
    <div class="gridContainerFlex">
        <div>One</div>
        <div>Two</div>
        <div>Three</div>
        <div>Four</div>
        <div>Five</div>
        <div>Six</div>
        <div>Seven</div>
    </div>
</body>


#### 直接指定和隐式指定[MDN](https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Grids#the_implicit_and_explicit_grid)

在指定列和行时, 有两种指定方式: 直接指定行的布局方式，称为：直接指定； 由浏览器通过规则进行指定也被称为：隐式指定

通常情况下，用户通过 `grid-template-columns` 指定了列的大小，没有直接指定行的大小，此时浏览器会自动调整至覆盖内容的高度。可以通过 [ grid-auto-rows](https://developer.mozilla.org/en-US/docs/Web/CSS/grid-auto-rows) 去指定高度。

```css
.container {
  display: grid;
  /* 直接指定 */
  grid-template-columns: repeat(3, 1fr);
  /* 在创建布局时，render engine隐式指定了行的大小 */
  grid-auto-rows: 100px;
  gap: 20px;
}
```

#### 常用的函数`repeat()`|`minmax()`

`repeat()` 用来替代重复的指代，像宏。如

```css
grid-template-columns: repeat(3, 1fr);/* 等价于  grid-template-columns: repeat 1fr 1fr 1fr; */
```

`minmax()` 用来隐式指定上个Topic中提到的行高， 当我们像限制最小告诉时可以

```css
grid-auto-rows: minmax(100px, auto);
```

#### 组合使用，创建一个具有最小尺寸的响应式布局

设定行和列的最小值，使用`repeat(auto-fill, **)` 去自动计算列数量。

<style>
    .gridContainerMinsize{
        display:grid;
        /* 设定列最小值和最大值 */
        grid-template-columns: repeat(auto-fill, minmax(50px, 2fr));
        /* 行的 */
        grid-auto-rows: minmax(50px, auto);
        gap: 20px;
    }
    .gridContainerMinsize>div{
        background-color: lightblue;
    }
</style>
<body>
    <div class="gridContainerMinsize">
        <div>One</div>
        <div>Two</div>
        <div>Three</div>
        <div>Four</div>
        <div>Five</div>
        <div>Six</div>
        <div>Seven</div>
    </div>
</body>

#### Linebased 写作顺序排列

传统艺能了，布局方式都有按照写作顺序进行排列的选项，`Grid` 布局除了配列顺序外，还有

通过以下属性可以指定 `行` 或 `列` 的排列开始方向、位置等。

grid-column-start
grid-column-end
grid-row-start
grid-row-end

如：[MDN 示例](https://developer.mozilla.org/en-US/docs/Web/CSS/grid-column-start)
```css
/* span + <integer> + <custom-ident> values */
grid-column-start: span 3;
```

通过以下属性指定 `grid-item` 的大小进行单独指定

grid-column
grid-row

```css
header {
  grid-column: 1 / 3;
  grid-row: 1;
}

article {
  grid-column: 2;
  grid-row: 2;
}

aside {
  grid-column: 1;
  grid-row: 2;
}

footer {
  grid-column: 1 / 3;
  grid-row: 3;
}

```

<iframe class="sample-code-frame" title="Line-based placement sample" id="frame_line-based_placement" width="100%" height="600" src="https://yari-demos.prod.mdn.mozit.cloud/en-US/docs/Learn/CSS/CSS_layout/Grids/_sample_.line-based_placement.html" loading="lazy"></iframe>

## 双飞翼和圣杯布局

[来源](https://zhuanlan.zhihu.com/p/58355168)

首先，创建布局，使用 `float` 使中间三块脱离文档流。然后使用`margin-left` 使中间三块发生不同的偏移。

然后，根据两种布局的不同， 圣杯是使用相对定位+`padding`，双飞翼+`margin`或`padding`


```html
<style>
    .header {
        height: 20px;
        background-color: lightblue;
    }
    
    .footer {
        height: 60px;
        background-color: lightcoral;
        clear: both;
    }
    /* .clearfix::after {
        clear: both;
        display: block;
    } */
    
    .container {
        /* 圣杯布局 */
        /* padding: 0 200px 0 200px; */
    }
    
    .center,
    .left,
    .right {
        float: left;
        height: 500px;
    }
    
    .center {
        width: 100%;
        background-color: lightgray;
    }
    
    .left {
        width: 200px;
        /* 因为浮动的左边已经有父元素，所以要偏移整个父元素的width才能到左边 */
        margin-left: -100%;
        background-color: lightpink;
        /* 圣杯布局 */
        /* position: relative;
        left: -200px; */
    }
    
    .right {
        width: 200px;
        /* 偏移自己的width即可 */
        margin-left: -200px;
        background-color: lightgreen;
        /* 圣杯布局 */
        /* position: relative;
        right: -200px; */
    }
    
    .inner {
        /* 双飞翼 */
        margin: 0 200px 0 200px;
    }
</style>

<body>
    <div class="header"></div>
    <div class="container">
        <div class="center">
            <div class="inner"> 中间自适应 </div>
        </div>
        <div class="left">左列定宽</div>
        <div class="right">右列定宽</div>
    </div>
    <div class="footer"></div>
</body>
```

<html>
<style>
    .header {
        height: 20px;
        background-color: lightblue;
    }
    .footer {
        height: 60px;
        background-color: lightcoral;
        clear: both;
    }
    /* .clearfix::after {
        clear: both;
        display: block;
    } */
    .container {
        /* 圣杯布局 */
        /* padding: 0 200px 0 200px; */
    }
    .center,
    .left,
    .right {
        float: left;
        height: 500px;
    }
    .center {
        width: 100%;
        background-color: lightgray;
    }
    .left {
        width: 50px;
        /* 因为浮动的左边已经有父元素，所以要偏移整个父元素的width才能到左边 */
        margin-left: -100%;
        background-color: lightpink;
        /* 圣杯布局 */
        /* position: relative;
        left: -200px; */
    }
    .right {
        width: 50px;
        /* 偏移自己的width即可 */
        margin-left: -50px;
        background-color: lightgreen;
        /* 圣杯布局 */
        /* position: relative;
        right: -200px; */
    }
    .inner {
        /* 双飞翼 */
        margin: 0 50px 0 50px;
    }
</style>
<body>
    <div class="header"></div>
    <div class="container">
        <div class="center">
            <div class="inner"> 中间自适应 </div>
        </div>
        <div class="left">左列定宽</div>
        <div class="right">右列定宽</div>
    </div>
    <div class="footer"></div>
</body>

</html>