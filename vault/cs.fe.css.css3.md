---
id: mmay6qtqh7segs81gw8zntl
title: Css3
desc: ''
updated: 1659005978480
created: 1659001173294
---

# CSS3

> Source [个人总结（css3新特性） - SegmentFault 思否](https://segmentfault.com/a/1190000010780991)

## 新动画特性

### 按钮例子

实际就是css3的新动画特性

```css
    .btn:hover {
        background-color: aquamarine;
        /* transition-property: width;
        transition-delay: 1s;
        transition-timing-function: linear;
        transition-duration: 2s; */
        /* 以上的属性可以简写为 */
        transition: all, 0.5s;
    }
```


<style>
    a {
        text-decoration: none;
        color: black;
    }

    .container {
        display: flex;
        justify-content: center;
        align-items: center;
        width: 100%;
    }
    
    .inner {}
    
    .btn {
        background-color: white;
        border: solid lightgray 1px;
        border-radius: 5%;
        width: 80px;
        height: 30px;
    }
    
    .btn:hover {
        background-color: aquamarine;
        /* transition-property: width;
        transition-delay: 1s;
        transition-timing-function: linear;
        transition-duration: 2s; */
        transition: all, 0.5s;
    }
</style>
<body>
    <div class="container">
        <div class="inner">
            <button class="btn">btn</button>
        </div>
    </div>
</body>


### 下拉菜单

布局思路：将Navbar的 `<li/>` 转化为行内元素，然后调整位置，使用css3的动画


<style>
    nav :first-child li {
        display: inline-block;
        width: 30px;
        height: 25px;
        line-height: 25px;
        background-color: orange;
        text-align: center;
    }

    nav :first-child li ul {
        transform: scaleY(0);
        overflow: hidden;
        padding: 0;
    }
    
    nav :first-child li ul {
        transform-origin: 0 0;
        transition: all, .5s;
    }
    
    nav :first-child li ul li {
        display: block;
    }
    
    nav :first-child li:hover ul {
        transform: scaleY(1);
    }
</style>

<body>
    <nav>
        <ul>
            <li>
                <a href="#">
                    html
                </a>
                <ul>
                    <li>1</li>
                    <li>2</li>
                    <li>3</li>
                </ul>
            </li>
            <li>
                <a href="#">
                    css
                </a>
                <ul>
                    <li>4</li>
                    <li>5</li>
                    <li>6</li>
                </ul>
            </li>
            <li>
                <a href="#">
                    js
                </a>
                <ul>
                    <li>7</li>
                    <li>8</li>
                    <li>9</li>
                </ul>
            </li>
        </ul>
    </nav>
</body>

```css
    nav :first-child li {
        display: inline-block;
        width: 50px;
        height: 25px;
        line-height: 25px;
        background-color: orange;
        text-align: center;
    }
    
    nav :first-child li ul {
        /* background-color: aqua; */
        transform: scaleY(0);
        overflow: hidden;
        padding: 0;
    }
    
    nav :first-child li ul {
        transform-origin: 0 0;
        transition: all, .5s;
    }
    
    nav :first-child li ul li {
        display: block;
    }
    
    nav :first-child li:hover ul {
        transform: scaleY(1);
    }
```



## 新选择器

[MDN Attribute selectors](https://developer.mozilla.org/en-US/docs/Web/CSS/Attribute_selectors)

[W3C School css_selectors](https://www.w3school.com.cn/cssref/css_selectors.asp)


## 形状转换

### 2D

`transform` :适用于2D或3D转换的元素
`transform-origin`：转换元素的位置（围绕那个点进行转换）。默认(x,y,z)：(50%,50%,0)

<style>
    .lightBlueBox {
        background-color: lightblue;
        margin-top: 20px;
        width: 100px;
        height: 40px;
    }
</style>

`Rotate` 旋转

```css
    transform:rotate(30deg);
```

![](https://image-static.segmentfault.com/243/676/2436767704-5996c4b861ddd_fix732)
<!-- <div class="lightBlueBox" style="transform:rotate(30deg);" /> -->


`translate` 位移

```css
 transform:translate(30px,30px);
```

<!-- <div class="lightBlueBox" style="transform:translate(30px,30px);" /> -->

`scale` 缩放

```css
transform:scale(.8);
```

![](https://image-static.segmentfault.com/126/220/1262207161-5996c6b7a978a_fix732)
<!-- <div class="lightBlueBox" style="transform:scale(.8);" /> -->

`skew` 三维变换

```css
transform: skew(10deg,10deg);
```

![](https://image-static.segmentfault.com/149/748/149748881-5996c772d2961_fix732)

<!-- <div class="lightBlueBox" style="transform: skew(10deg,10deg);" /> -->

`rotateX` 三维翻转

```css
    transform:rotateX(180deg);
```
![](https://image-static.segmentfault.com/159/205/1592052558-5996d13f78d93)

### 3D

`rotate3d` 立体翻转

```css
transform:rotate3d(10,10,10,90deg);
```

![](https://image-static.segmentfault.com/120/941/1209419084-5996d1fbb80fd)



## 阴影

```html
<style>
    div{
        width:300px;
        height:100px;
        background:#09f;
        box-shadow: 10px 10px 5px #888888;
    }
</style>
<body>
	<div></div>
</body>
```



![](https://segmentfault.com/img/bVTd9F?w=364&h=151)

## 边框

### 边框图片

#### 语法

border-image: 图片url 图像边界向内偏移 图像边界的宽度(默认为边框的宽度) 用于指定在边框外部绘制偏移的量（默认0） 铺满方式--重复（repeat）、拉伸（stretch）或铺满（round）（默认：拉伸（stretch））;

#### 栗子

边框图片（来自菜鸟教程）

![clipboard.png](https://segmentfault.com/img/bVTefk?w=81&h=81)

代码

```html
<style>
.demo {
    border: 15px solid transparent;
    padding: 15px;   
    border-image: url(border.png);
    border-image-slice: 30;
    border-image-repeat: round;
    border-image-outset: 0;
}
</style>

<body>
    <div class="demo"></div>
</body>
```

效果

![clipboard.png](https://segmentfault.com/img/bVTeeg?w=601&h=91)

有趣变化

![clipboard.png](https://segmentfault.com/img/bVTefm?w=617&h=444)

![clipboard.png](https://segmentfault.com/img/bVTefl?w=617&h=444)

那个更好看，大家看着办

### 边框圆角

#### 语法

```gcode
border-radius: n1,n2,n3,n4;
border-radius: n1,n2,n3,n4/n1,n2,n3,n4;
/*n1-n4四个值的顺序是：左上角，右上角，右下角，左下角。*/
```

#### 栗子

```html
<style> 
div
{
    border:2px solid #a1a1a1;
    padding:10px 40px; 
    background:#dddddd;
    text-align:center;
    width:300px;
    border-radius:25px 0 25px 0;
}
</style>
</head>
<body>
<div>border-radius</div>
</body>
```

运行结果

![clipboard.png](https://segmentfault.com/img/bVTegF?w=486&h=82)
