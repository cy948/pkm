---
id: 3k8ihdv8dta69yejj8kehzb
title: 09 函数
desc: ''
updated: 1673006698186
created: 1673006698186
---





## 函数

语法是：

```rust
fn 函数名(参数:类型,) -> 返回值类型 {
    // 函数体
    返回值
}
```

如果是`void`函数，可返回`()`

```rust
// When a function returns `()`, the return type can be omitted from the
// signature
fn fizzbuzz_to(n: u32) {
    for n in 1..=n {
        fizzbuzz(n);
    }
}
```



## 关联函数和方法

一些方法和特定的类型相关联，有两种方式：

- 类型自身的方法，一般使用 `::` 调用；
- 类型实例化的方法，一般使用 `.` 调用；

### 类型自身的方法

```rust
struct Point {
    x: f64,
    y: f64,
}

// 在类型Point上实现的方法，所有 `Point`类型都会有该方法
// Implementation block, all `Point` associated functions & methods go in here
impl Point {
    // This is an "associated function" because this function is associated with
    // a particular type, that is, Point.
    //
    // Associated functions don't need to be called with an instance.
    // 
    // These functions are generally used like constructors.
    fn origin() -> Point {
        Point { x: 0.0, y: 0.0 }
    }

    // Another associated function, taking two arguments:
    fn new(x: f64, y: f64) -> Point {
        Point { x: x, y: y }
    }
}
```

### 实例化后才能使用的方法

> 首参为 `&self, &mut self`。
>
> `&self` 是 `self: &Self` 的语法糖


```rust
struct Rectangle {
    p1: Point,
    p2: Point,
}

impl Rectangle {
    // This is a method
    // `&self` is sugar for `self: &Self`, where `Self` is the type of the
    // caller object. In this case `Self` = `Rectangle`
    fn area(&self) -> f64 {
        // `self` gives access to the struct fields via the dot operator
        let Point { x: x1, y: y1 } = self.p1;
        let Point { x: x2, y: y2 } = self.p2;

        // `abs` is a `f64` method that returns the absolute value of the
        // caller
        ((x1 - x2) * (y1 - y2)).abs()
    }

    fn perimeter(&self) -> f64 {
        let Point { x: x1, y: y1 } = self.p1;
        let Point { x: x2, y: y2 } = self.p2;

        2.0 * ((x1 - x2).abs() + (y1 - y2).abs())
    }

    // This method requires the caller object to be mutable
    // `&mut self` desugars to `self: &mut Self`
    fn translate(&mut self, x: f64, y: f64) {
        self.p1.x += x;
        self.p2.x += x;

        self.p1.y += y;
        self.p2.y += y;
    }
}

```

### 利用作用域机制回收内存

> 此处不再取引用`&self`，直接取到自身，进行解构

```rust
// `Pair` owns resources: two heap allocated integers
struct Pair(Box<i32>, Box<i32>);

impl Pair {
    // This method "consumes" the resources of the caller object
    // `self` desugars to `self: Self`
    fn destroy(self) {
        // Destructure `self`
        let Pair(first, second) = self;

        println!("Destroying Pair({}, {})", first, second);

        // `first` and `second` go out of scope and get freed
    }
}

```

### 调用示例

```rust
fn main() {
    let rectangle = Rectangle {
        // Associated functions are called using double colons
        p1: Point::origin(),
        p2: Point::new(3.0, 4.0),
    };

    // Methods are called using the dot operator
    // Note that the first argument `&self` is implicitly passed, i.e.
    // `rectangle.perimeter()` === `Rectangle::perimeter(&rectangle)`
    println!("Rectangle perimeter: {}", rectangle.perimeter());
    println!("Rectangle area: {}", rectangle.area());

    let mut square = Rectangle {
        p1: Point::origin(),
        p2: Point::new(1.0, 1.0),
    };

    // Error! `rectangle` is immutable, but this method requires a mutable
    // object
    //rectangle.translate(1.0, 0.0);
    // TODO ^ Try uncommenting this line

    // Okay! Mutable objects can call mutable methods
    square.translate(1.0, 1.0);

    let pair = Pair(Box::new(1), Box::new(2));

    pair.destroy();

    // Error! Previous `destroy` call "consumed" `pair`
    //pair.destroy();
    // TODO ^ Try uncommenting this line
}
```

## 闭包 [Closures](https://doc.rust-lang.org/rust-by-example/fn/closures.html#closures)

闭包：

- 使用 `||` 包围参数
- 选择性地使用`{}`添加方法体
- 可以使用上一层作用域的变量

```rust
    // Increment via closures and functions.
    fn function(i: i32) -> i32 { i + 1 }

    // Closures are anonymous, here we are binding them to references
    // Annotation is identical to function annotation but is optional
    // as are the `{}` wrapping the body. These nameless functions
    // are assigned to appropriately named variables.
    let closure_annotated = |i: i32| -> i32 { i + 1 };
    let closure_inferred  = |i     |          i + 1  ;
```

调用：

```rust
    let i = 1;
    // Call the function and closures.
    println!("function: {}", function(i));
    println!("closure_annotated: {}", closure_annotated(i));
    println!("closure_inferred: {}", closure_inferred(i));
    // Once closure's type has been inferred, it cannot be inferred again with another type.
    // println!("cannot reuse closure_inferred with another type: {}", closure_inferred(42i64));
	// 一旦输入类型被定义，这里就不能输入别的类型的值了
/*
18 |   closure_inferred(42i64));
   |   ---------------- ^^^^^ expected `i32`, found `i64`
   | arguments to this function are incorrect
*/
    // A closure taking no arguments which returns an `i32`.
    // The return type is inferred.
    let one = || 1;
    println!("closure returning one: {}", one());
```

### 捕获调用者作用域中的变量 Capturinig

> 此处涉及所有权概念，先看：[什么是所有权(https://rustwiki.org/zh-CN/book/ch04-01-what-is-ownership.html#栈stack与堆heap)

闭包可以捕获环境中的变量，如：

- 引用 `&T` 
- 可变引用 `&mut T`
- 值 `T` 

下面是使用例子：

> ```rust
> use std::mem;
> let color = String::from("green");
> ```

- 借用环境中的**不可变变量**`color`

```rust
// A closure to print `color` which immediately borrows (`&`) `color` and
// stores the borrow and closure in the `print` variable. It will remain
// borrowed until `print` is used the last time. 
//
// `println!` only requires arguments by immutable reference so it doesn't
// impose anything more restrictive.
let print = || println!("`color`: {}", color);

// Call the closure using the borrow.
print();

// `color` can be borrowed immutably again, because the closure only holds
// an immutable reference to `color`. 
// 借用过后还可以借用
let _reborrow = &color;
print();
```

- 借用一个**可变变量**`count`

```rust
// A move or reborrow is allowed after the final use of `print`
// 借用之后，移动或再次借用都是允许的
let _color_moved = color;

let mut count = 0;
// A closure to increment `count` could take either `&mut count` or `count`
// but `&mut count` is less restrictive so it takes that. Immediately
// borrows `count`.
//
// A `mut` is required on `inc` because a `&mut` is stored inside. Thus,
// calling the closure mutates the closure which requires a `mut`.
// 借用时修改变量需要变量使用 mut 修饰
let mut inc = || {
	count += 1;
    println!("`count`: {}", count);
};

// Call the closure using a mutable borrow.
// 借用时修改变量
inc();

// The closure still mutably borrows `count` because it is called later.
// An attempt to reborrow will lead to an error.
// 非只读的count已经被借走了，如果再次借用将会引发异常
// let _reborrow = &count; 
// ^ TODO: try uncommenting this line.
// cannot borrow `count` as immutable because it is also borrowed as mutable
inc();

// The closure no longer needs to borrow `&mut count`. Therefore, it is
// possible to reborrow without an error
// 要想重新借用，需要使用 &mut 修饰
let _count_reborrowed = &mut count; 
```

- 捕获不可复制的对象，复制or移动？

> 如基本变量这些占用空间小，都是可以直接复制多份的，但在堆空间创建的对象就不可以像这些基本变量一样被复制，借走。

```rust
// A non-copy type.
// 在堆中新建一个不像数字一样可复制的对象
let movable = Box::new(3);

// `mem::drop` requires `T` so this must take by value. 
// `mem::drop` 释放一个内存对象，类似C中的`free`

// A copy type would copy into the closure leaving the original untouched.
// 一个可复制的对象将会被复制到闭包中
// A non-copy must move and so `movable` immediately moves into the closure.
// 一个不可复制的对象将会移动到闭包中
let consume = || {
	println!("`movable`: {:?}", movable);
    mem::drop(movable);
};

// `consume` consumes the variable so this can only be called once.
// 因为移动到闭包中的对象被复制了，所以只能调用一次
consume();
// consume();
// ^ TODO: Try uncommenting this line.
```



### 行参 [As input parameters](https://doc.rust-lang.org/rust-by-example/fn/closures/input_parameters.html#as-input-parameters)

上面讲到，Rust中闭包的方法体中捕获变量通常不带类型，但描述形参时，需要带上变量类型。通过以下方式指定：

- `Fn` 入参时使用引用；
- `FnMut` 入参是使用可变的引用 `&mut T` ；
- `FnOnce` 复制参数；

> 会优先考虑捕获最小限制的参数

对于实例，考虑将参数标记为`FnOnce`。令闭包可以捕获`&T, &mut T, T` ，但最终编译器会参考在闭包里面的使用情况决定类型。

因为如果可以移动，那肯定可以借用，注意这个是充分不必要条件。如果标记为 `Fn` ，则不允许 `&mut T, T` 。

> 在

```rust
// A function which takes a closure as an argument and calls it.
// <F> denotes that F is a "Generic type parameter"
// 使用一个闭包函数作为入参，然后调用这个闭包
// fn 函数名<类型>(f: 类型) where 闭包: FnOnce()
fn apply<F>(f: F) where
    // The closure takes no input and returns nothing.
    F: FnOnce() {
    // ^ TODO: Try changing this to `Fn` or `FnMut`.

    f();
}

// 调用一个以 i32 为参数的闭包，然后返回 i32
// A function which takes a closure and returns an `i32`.
fn apply_to_3<F>(f: F) -> i32 where
    // The closure takes an `i32` and returns an `i32`.
    F: Fn(i32) -> i32 {
    f(3)
}
```

- `Fn`, `FnMut`, and `FnOnce` 调用示例：

> - `Fn`
>
> ```rust
> 29 |     let diary = || {
>    |                 ^^ this closure implements `FnOnce`, not `Fn`
>     
> 45 |     apply(diary);
>    |     ----- ----- the requirement to implement `Fn` derives from here
>    |     |
>    |     required by a bound introduced by this call
> ```
>
> - `FnMut`
>
> ```rust
> 29 |     let diary = || {
>    |                 ^^ this closure implements `FnOnce`, not `FnMut`
> 
> 45 |     apply(diary);
>    |     ----- ----- the requirement to implement `FnMut` derives from here
>    |     |
>    |     required by a bound introduced by this call
>     
> ```

闭包需要一个函数调用

```rust
use std::mem;

let greeting = "hello";
// A non-copy type.
// `to_owned` creates owned data from borrowed one
let mut farewell = "goodbye".to_owned();

// Capture 2 variables: `greeting` by reference and
// `farewell` by value.
let diary = || {
// `greeting` is by reference: requires `Fn`.
    println!("I said {}.", greeting);

// Mutation forces `farewell` to be captured by
// mutable reference. Now requires `FnMut`.
    farewell.push_str("!!!");
    println!("Then I screamed {}.", farewell);
    println!("Now I can sleep. zzzzz");

// Manually calling drop forces `farewell` to
// be captured by value. Now requires `FnOnce`.
        mem::drop(farewell);
    };

// Call the function which applies the closure.
    apply(diary);

// `double` satisfies `apply_to_3`'s trait bound
    let double = |x| 2 * x;

    println!("3 doubled: {}", apply_to_3(double));
}
```

### 作为参数传入

```rust
// Define a function which takes a generic `F` argument
// 定义参数类型为闭包函数
// bounded by `Fn`, and calls it
fn call_me<F: Fn()>(f: F) {
    f();
}

// Define a wrapper function satisfying the `Fn` bound
fn function() {
    println!("I'm a function!");
}

fn main() {
    // Define a closure satisfying the `Fn` bound
    let closure = || println!("I'm a closure!");

    call_me(closure);
    call_me(function);
}
```

### 作为返回值

```rust
fn create_fn() -> impl Fn() {
    let text = "Fn".to_owned();

    move || println!("This is a: {}", text)
}

fn create_fnmut() -> impl FnMut() {
    let text = "FnMut".to_owned();

    move || println!("This is a: {}", text)
}

fn create_fnonce() -> impl FnOnce() {
    let text = "FnOnce".to_owned();

    move || println!("This is a: {}", text)
}

fn main() {
    let fn_plain = create_fn();
    let mut fn_mut = create_fnmut();
    let fn_once = create_fnonce();

    fn_plain();
    fn_mut();
    fn_once();
}
```
