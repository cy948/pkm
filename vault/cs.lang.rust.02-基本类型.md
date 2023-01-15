---
id: 0jtfzc3tgbq8dhwhbfg9ysp
title: 02 基本lei'x
desc: ''
updated: 1672820379837
created: 1672820379837
---



## 类型

### 数字类型([Scalar Types](https://doc.rust-lang.org/rust-by-example/primitives.html#scalar-types))

- 带符号整数(signed integers): `i8`, `i16`, `i32`, `i64`, `i128` and `isize` (pointer size)
- 无符号整数(unsigned integers): `u8`, `u16`, `u32`, `u64`, `u128` and `usize` (pointer size)
- 浮点数(floating point): `f32`, `f64`
- 单字符(char): `char` Unicode scalar values like `'a'`, `'α'` and `'∞'` (4 bytes each)
- 布尔(bool):`bool` either `true` or `false`
- and the unit type `()`, whose only possible value is an empty tuple: `()`

### 复合类型([Compound Types](https://doc.rust-lang.org/rust-by-example/primitives.html#compound-types))

- 数组(arrays) like `[1, 2, 3]`
- 元组(tuples) like `(1, true)`

### 指定类型示例

- 直接指定变量类型：

```rust
    // Variables can be type annotated.
    let logical: bool = true;
    let a_float: f64 = 1.0;  // Regular annotation
```

- 由后缀指定：

```rust
    let an_integer   = 5i32; // Suffix annotation
```

- 由编译器推断：

```rust
    // Or a default will be used.
    let default_float   = 3.0; // `f64`
    let default_integer = 7;   // `i32`
    
    // A type can also be inferred from context 
    let mut inferred_type = 12; // Type i64 is inferred from another line
    inferred_type = 4294967296i64;
```

- 可变变量(mutable variable)

```rust
    // A mutable variable's value can be changed.
    let mut mutable = 12; // Mutable `i32`
    mutable = 21;
    
    // Error! The type of a variable can't be changed.
    mutable = true;
    
    // Variables can be overwritten with shadowing.
    let mutable = true;
```



## 字面量和操作符

>  同类 C 语言

- 加减：

```rust
    // Integer addition
    println!("1 + 2 = {}", 1u32 + 2);

    // Integer subtraction
    println!("1 - 2 = {}", 1i32 - 2);
    // TODO ^ Try changing `1i32` to `1u32` to see why the type is important
```

- 布尔操作 `&&` or `||` and `!`

```rust
    // Short-circuiting boolean logic
    println!("true AND false is {}", true && false);
    println!("true OR false is {}", true || false);
    println!("NOT true is {}", !true);

```

- 位操作符

```rust
    // Bitwise operations
    println!("0011 AND 0101 is {:04b}", 0b0011u32 & 0b0101);
    println!("0011 OR 0101 is {:04b}", 0b0011u32 | 0b0101);
    println!("0011 XOR 0101 is {:04b}", 0b0011u32 ^ 0b0101);
    println!("1 << 5 is {}", 1u32 << 5);
    println!("0x80 >> 2 is 0x{:x}", 0x80u32 >> 2);
```

- 下划线（数不变，增加可读性）

```rust
    // Use underscores to improve readability!
    println!("One million is written as {}", 1_000_000u32);
```



## 元组（[Tuples](https://doc.rust-lang.org/rust-by-example/primitives/tuples.html#tuples)）

元组`tuple(T1,T2)`是一个包含多个不同类型值的集合，如：`tuple(0)`的值是`T1` 

- 反转一个二元`tuple`

```rust
// Tuples can be used as function arguments and as return values
fn reverse(pair: (i32, bool)) -> (bool, i32) {
    // `let` can be used to bind the members of a tuple to variables
    let (int_param, bool_param) = pair;

    (bool_param, int_param)
}

println!("the reversed pair is {:?}", reverse(pair));
/*
	the reversed pair is (true, 1)
*/
```

- 定义一个tuple结构体

```rust
// The following struct is for the activity.
#[derive(Debug)]
struct Matrix(f32, f32, f32, f32);

let matrix = Matrix(1.1, 1.2, 2.1, 2.2);

println!("{:?}", matrix);
/*
	Matrix(1.1, 1.2, 2.1, 2.2)
*/
```

- 通过初始化器直接创建`tuple`

```rust
    // A tuple with a bunch of different types
let long_tuple = (1u8, 2u16, 3u32, 4u64,
				  -1i8, -2i16, -3i32, -4i64,
                  0.1f32, 0.2f64,
                  'a', true);

// Values can be extracted from the tuple using tuple indexing
println!("long tuple first value: {}", long_tuple.0);
println!("long tuple second value: {}", long_tuple.1);

/*
    long tuple first value: 1
    long tuple second value: 2
*/
```

- 元组套娃

```rust
    // Tuples can be tuple members
    let tuple_of_tuples = ((1u8, 2u16, 2u32), (4u64, -1i8), -2i16);

    // Tuples are printable
    println!("tuple of tuples: {:?}", tuple_of_tuples);
```
> ❗但超过12个元素时将无法打印
> ```rust
>     // But long Tuples (more than 12 elements) cannot be printed
>     let too_long_tuple = (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13);
>     println!("too long tuple: {:?}", too_long_tuple);
>    /*
> 32 |  println!("too long tuple: {:?}", too_long_tuple);
> |                                      ^^^^^^^^^^^^^^ `({integer}*13)` cannot be formatted using `{:?}` because it doesn't implement `Debug`
>    */
> ```

- 创建元组时，`,` 是必要的，缺少 `,` 将会识别为`()`表达式：

```rust
// To create one element tuples, the comma is required to tell them apart
// from a literal surrounded by parentheses
println!("one element tuple: {:?}", (5u32,));
println!("just an integer: {:?}", (5u32));
/*
    one element tuple: (5,)
    just an integer: 5
*/
```

- 使用时为元组各个位置指定名称

> 很像es6的写法
> ```js
> let {first, second} = tuple;
> ```

```rust
//tuples can be destructured to create bindings
let tuple = (1, "hello", 4.5, true);
    let (a, b, c, d) = tuple;
    println!("{:?}, {:?}, {:?}, {:?}", a, b, c, d);
}
```

#

### 实验2.2 Tuples

1. 实现 `Matrix` 的`Display`方法，使输出如下：

```rust
( 1.1 1.2 )
( 2.1 2.2 )
```

**思路**：

实现`Display`方法即可

```rust
use std::fmt;
// The following struct is for the activity.
#[derive(Debug)]
struct Matrix(f32, f32, f32, f32);

impl fmt::Display for Matrix {
   fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "( {} {} )\n( {} {} )", self.0, self.1, self.2, self.3)
   }
}

fn main(){
    let matrix = Matrix(1.1, 1.2, 2.1, 2.2);
    println!("{}", matrix);
}
```



2. 反转元组

```rust
Matrix:
( 1.1 1.2 )
( 2.1 2.2 )

//目标
Transpose:
( 1.1 2.1 )
( 1.2 2.2 )
```

**思路**：

```rust
use std::fmt;
// The following struct is for the activity.
#[derive(Debug)]
struct Matrix(f32, f32, f32, f32);

impl fmt::Display for Matrix {
   fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "( {} {} )\n( {} {} )", self.0, self.1, self.2, self.3)
   }
}

fn transpose(matrix: Matrix) -> Matrix {
    Matrix(matrix.0, matrix.2, 
        matrix.1, matrix.3)
}

fn main(){
    let matrix = Matrix(1.1, 1.2, 2.1, 2.2);
    println!("Matrix:\n{}", matrix);
    println!("Transpose:\n{}", transpose(matrix));
}
```



## 数组和切片[Arrays and Slices](https://doc.rust-lang.org/rust-by-example/primitives/array.html#arrays-and-slices)

### 数组

```rust
use std::mem; //引入mem库以查看数组在方法栈中占用的空间
```

单一类型的集合，使用`[]` 创建，在编译器已知长度；

- 初始化时定义长度

```rust
    // Fixed-size array (type signature is superfluous)
    let xs: [i32; 5] = [1, 2, 3, 4, 5];
```

- 初始化为同一值的数组

```rust
    // All elements can be initialized to the same value
    let ys: [i32; 500] = [0; 500];

```

- 取一个位置的值

```rust
    // Indexing starts at 0
    println!("first element of the array: {}", xs[0]);
    println!("second element of the array: {}", xs[1]);
```

- 获取长度

```rust
    // `len` returns the count of elements in the array
    println!("number of elements in array: {}", xs.len());
```

- 查看数组在方法栈中占的空间

> 和 C 语言类似，使用取引用符号后，是一个指针，不同的是，`&array` 并不指向第一个元素，相同的是，取引用之后都不知道长度，详细的在下面 **Slice** 中介绍

```rust
// 数组的空间分配在方法栈中
println!("array occupies {} bytes", mem::size_of_val(&xs));

// Arrays can be automatically borrowed as slices
println!("borrow the whole array as a slice");
analyze_slice(&xs);
```

### 切片

> 与 `Array` 相同，都可以通过 `[]` 取值，调用 `.len()` 方法获取长度

- 指向数组的其中一部分

```rust
// This function borrows a slice
fn analyze_slice(slice: &[i32]) {
    println!("first element of the slice: {}", slice[0]);
    println!("the slice has {} elements", slice.len());
}

// Slices can point to a section of an array
// They are of the form [starting_index..ending_index]
// starting_index is the first position in the slice
// ending_index is one more than the last position in the slice
println!("borrow a section of the array as a slice");
// 取数组：`ys:[i32; 500]` 下标为 1-4 的元素
analyze_slice(&ys[1 .. 4]);

/*
borrow a section of the array as a slice
first element of the slice: 0
the slice has 3 elements
*/

```

- 空数组

```rust
// Example of empty slice `&[]`
let empty_array: [u32; 0] = [];
assert_eq!(&empty_array, &[]);
assert_eq!(&empty_array, &[][..]); // same but more verbose
```

- 遍历数组

`match` 功能类似 `switch` 语句，往后会介绍

```rust
// Arrays can be safely accessed using `.get`, which returns an
// `Option`. This can be matched as shown below, or used with
// `.expect()` if you would like the program to exit with a nice
// message instead of happily continue.
    for i in 0..xs.len() + 1 { // OOPS, one element too far
        match xs.get(i) {
            Some(xval) => println!("{}: {}", i, xval),
            None => println!("Slow down! {} is too far!", i),
        }
    }
```

- 数组越界将会引起运行时错误

```rust
    // Out of bound indexing causes runtime error
    //println!("{}", xs[5]);
```



## 自定义类型

### 结构体

> ```rust
> // An attribute to hide warnings for unused code.
> // 关闭编译器对未使用变量的警示
> #![allow(dead_code)]
> ```

使用 `struct` 关键字定义结构体

- 定义、创建实例并初始化和打印

```rust
#[derive(Debug)]
struct Person {
    name: String,
    age: u8,
}

// Create struct with field init shorthand
let name = String::from("Peter");
let age = 27;
let peter = Person { name, age };

// Print debug struct
println!("{:?}", peter);
/*
	Person { name: "Peter", age: 27 }
*/
```

- 指定变量进行初始化

```rust
// A struct with two fields
struct Point {
    x: f32,
    y: f32,
}

// Instantiate a `Point`
let point: Point = Point { x: 10.3, y: 0.4 };

// Access the fields of the point
println!("point coordinates: ({}, {})", point.x, point.y);

```

- 展开操作符`..`

```rust
// Make a new point by using struct update syntax to use the fields of our
// 利用旧的point的值创建一个新的 point ，并且更新 x 的值
// other one
let bottom_right = Point { x: 5.2, ..point };
    
// `bottom_right.y` will be the same as `point.y` because we used that field
// from `point`
println!("second point: ({}, {})", bottom_right.x, bottom_right.y);

// Destructure the point using a `let` binding
let Point { x: left_edge, y: top_edge } = point;    
```

- 结构体中包含结构体的初始化

```rust
// Structs can be reused as fields of another struct
struct Rectangle {
    // A rectangle can be specified by where the top left and bottom right
    // 该三角形必经过(0,0)
    // corners are in space.
    top_left: Point,
    bottom_right: Point,
}

let _rectangle = Rectangle {
	// struct instantiation is an expression too
    top_left: Point { x: left_edge, y: top_edge },
    bottom_right: bottom_right,
};
```

- 元组结构体和单元结构体

```rust
// A unit struct
struct Unit;

// A tuple struct
struct Pair(i32, f32);

fn main() {

    // Instantiate a unit struct
    let _unit = Unit;

    // Instantiate a tuple struct
    let pair = Pair(1, 0.1);

    // Access the fields of a tuple struct
    println!("pair contains {:?} and {:?}", pair.0, pair.1);

```

- 元组结构体的解构

```rust
// Destructure a tuple struct
let Pair(integer, decimal) = pair;
println!("pair contains {:?} and {:?}", integer, decimal);
/*
	pair contains 1 and 0.1
*/
```

### 实验3.1

1. 写一个函数`rect_area`，计算 `Rectangle` 的面积，要求使用结构：`let (x, y) = area;`

固定一条边，然后底 * 高

```rust
fn rect_area(rect: Rectangle) -> f32 {
    let Point{x:brX, y:brY} = rect.bottom_right;
    let Point{x:tlX, y:tlY} = rect.top_left;
    if brY != 0.0 {!panic!("需在y轴上");}
    ((tlY * brX) / 2.0)
}
fn main(){
    let topLeft = Point{x : 0.0, y : 3.0};
    let bottomRight = Point{x : 3.0, y :0.0};
    println!("{}", rect_area(Rectangle { top_left: topLeft, bottom_right: bottomRight }));
}
```

## 枚举类型

使用 `enum` 关键字创建枚举类型

- 创建枚举类型 `WebEvent` 

创建一个枚举类型去把一个web事件归类，包括：

- `PageLoad` 页面加载
- `PageUnload` 页面卸载
- `KeyPress` 按键点击次数
- `Paste` 粘贴
- `Click` 点击位置

```rust
// Create an `enum` to classify a web event. Note how both
// names and type information together specify the variant:
// `PageLoad != PageUnload` and `KeyPress(char) != Paste(String)`.
// Each is different and independent.
enum WebEvent {
    // An `enum` may either be `unit-like`,
    PageLoad,
    PageUnload,
    // like tuple structs,
    KeyPress(char),
    Paste(String),
    // or c-like structures.
    Click { x: i64, y: i64 },
}

```

- 使用 `match` 语句匹配事件

```rust
// A function which takes a `WebEvent` enum as an argument and
// returns nothing.
fn inspect(event: WebEvent) {
    match event {
        WebEvent::PageLoad => println!("page loaded"),
        WebEvent::PageUnload => println!("page unloaded"),
        // Destructure `c` from inside the `enum`.
        WebEvent::KeyPress(c) => println!("pressed '{}'.", c),
        WebEvent::Paste(s) => println!("pasted \"{}\".", s),
        // Destructure `Click` into `x` and `y`.
        WebEvent::Click { x, y } => {
            println!("clicked at x={}, y={}.", x, y);
        },
    }
}

```

调用

```rust
fn main() {
    let pressed = WebEvent::KeyPress('x');
    // `to_owned()` creates an owned `String` from a string slice.
    let pasted  = WebEvent::Paste("my text".to_owned());
    let click   = WebEvent::Click { x: 20, y: 80 };
    let load    = WebEvent::PageLoad;
    let unload  = WebEvent::PageUnload;

    inspect(pressed);
    inspect(pasted);
    inspect(click);
    inspect(load);
    inspect(unload);
}
/*
    pressed 'x'.
    pasted "my text".
    clicked at x=20, y=80.
    page loaded
    page unloaded
*/
```



### 类型别名

类似 `C or Typescript` 那样，为类型起个别名

```rust
enum VeryVerboseEnumOfThingsToDoWithNumbers {
    Add,
    Subtract,
}

// Creates a type alias
type Operations = VeryVerboseEnumOfThingsToDoWithNumbers;

fn main() {
    // We can refer to each variant via its alias, not its long and inconvenient
    // name.
    let x = Operations::Add;
}
```

比较常用的是在实现`enum`的方法时使用 `self`作为别名

```rust
enum VeryVerboseEnumOfThingsToDoWithNumbers {
    Add,
    Subtract,
}

impl VeryVerboseEnumOfThingsToDoWithNumbers {
    fn run(&self, x: i32, y: i32) -> i32 {
        match self {
            Self::Add => x + y,
            Self::Subtract => x - y,
        }
    }
}
```

### use

>  定义两个结构体
>  ```rust
>  enum Status {
>      Rich,
>      Poor,
>  }
>  enum Work {
>      Civilian,
>      Soldier,
>  }
>  ```

- 使用 `use` 引用结构体，然后就不需要在手动指定作用域

```rust
// Explicitly `use` each name so they are available without
// manual scoping.
    use crate::Status::{Poor, Rich};

// Automatically `use` each name inside `Work`.
    use crate::Work::*;
```

- 


```rust
fn main() {
    // Equivalent to `Status::Poor`.
    let status = Poor;
    // Equivalent to `Work::Civilian`.
    let work = Civilian;

    match status {
	// Note the lack of scoping because of the explicit `use` above.
        Rich => println!("The rich have lots of money!"),
        Poor => println!("The poor have no money..."),
    }

    match work {
        // Note again the lack of scoping.
        Civilian => println!("Civilians work!"),
        Soldier  => println!("Soldiers fight!"),
    }
}
/*
	The poor have no money...
	Civilians work!
*/
```

### C风格的使用 (C-like)

- `enum` 中的字符可以被转为隐性值，按下标

```rust
// enum with implicit discriminator (starts at 0)
enum Number {
    Zero,
    One,
    Two,
}

// `enums` can be cast as integers.
println!("zero is {}", Number::Zero as i32);
println!("one is {}", Number::One as i32);

```

- 将值转化为整型

```rust
// enum with explicit discriminator
#[derive(Debug)]
enum Color {
    Red = 0xff0000,
    Green = 0x00ff00,
    Blue = 0x0000ff,
}

fn main() {
    println!("[b4]roses are #{:?}", Color::Red);
    println!("[b4]violets are #{:?}", Color::Blue);

    println!("roses are #{:06x}", Color::Red as i32);
    println!("violets are #{:06x}", Color::Blue as i32);
}

/*
    [b4]roses are #Red
    [b4]violets are #Blue
    roses are #ff0000
    violets are #0000ff
*/
```

### 实验3.2.3 链表

通过 `enum` 去实现一个链表

1. 使用 `use` 引入，并声明结构体

枚举类型 `List` 里面只能有两种值：

-  `Cons(u32, Box<List>)`，`u32` 是值， `Box<List>` 是下一个结点的引用；
- `Nil` 表示空，是尾结点；

```rust
use crate::List::*;

enum List {
    // Cons: Tuple struct that wraps an element and a pointer to the next node
    // Cons 是一个元组类型，Box会在下文介绍
    Cons(u32, Box<List>),
    // Nil: A node that signifies the end of the linked list
    Nil,
}

```

2. 然后开始添加方法

```rust
// Methods can be attached to an enum
impl List {
	/*一堆方法*/
}
```

- 创建一个新的链表

```rust
    // Create an empty list
    // 创建一个空链表
    fn new() -> List {
        // `Nil` has type `List`
        Nil
    }
```

- 入队方法

> `Box` 用于在“堆”中分配内存，当离开作用域时会自动释放
>
> `Box<T>` 类型： 在堆中的引用类型；
>
> `Box::new(:Box<T>)` 为 `Box<T>` 类型的值在堆中分配空间

```rust
    // Consume a list, and return the same list with a new element at its front
    // 在链表头部入队
    fn prepend(self, elem: u32) -> List {
        // `Cons` also has type List
        Cons(elem, Box::new(self))
    }

```
- 计算长度

>  涉及所有权，看不懂可以先了解功能：

匹配到不为空就 + 1，递归计算下一个结点

```rust
    // Return the length of the list
    fn len(&self) -> u32 {
        // `self` has to be matched, because the behavior of this method
        // depends on the variant of `self`
        // `self` has type `&List`, and `*self` has type `List`, matching on a
        // concrete type `T` is preferred over a match on a reference `&T`
        // after Rust 2018 you can use self here and tail (with no ref) below as well,
        // rust will infer &s and ref tail. 
        // See https://doc.rust-lang.org/edition-guide/rust-2018/ownership-and-lifetimes/default-match-bindings.html
        match *self {
            // Can't take ownership of the tail, because `self` is borrowed;
            // instead take a reference to the tail
            Cons(_, ref tail) => 1 + tail.len(),
            // Base Case: An empty list has zero length
            Nil => 0
        }
    }
```

- 序列化输出

```rust
    // Return representation of the list as a (heap allocated) string
    fn stringify(&self) -> String {
        match *self {
            Cons(head, ref tail) => {
                // `format!` is similar to `print!`, but returns a heap
                // allocated string instead of printing to the console
                format!("{}, {}", head, tail.stringify())
            },
            Nil => {
                format!("Nil")
            },
        }
    }
```

调用示例：


```rust
fn main() {
    // Create an empty linked list
    let mut list = List::new();

    // Prepend some elements
    list = list.prepend(1);
    list = list.prepend(2);
    list = list.prepend(3);

    // Show the final state of the list
    println!("linked list has length: {}", list.len());
    println!("{}", list.stringify());
}
/*
	linked list has length: 3
	3, 2, 1, Nil
*/
```



## 常量

rust有两种可以定义在任何域中的变量，这些都要求明确的类型定义：

- `const` 无法改变的常量
- `static` 在 `'static`  生命周期中是可变的，但变更变量是不安全的

```rust
// Globals are declared outside all other scopes.
static LANGUAGE: &str = "Rust";
const THRESHOLD: i32 = 10;


// Access constant in the main thread
println!("This is {}", LANGUAGE);
println!("The threshold is {}", THRESHOLD);
/*
This is Rust
The threshold is 10
*/
```

- 在方法中使用`const` 常量

```rust
fn is_big(n: i32) -> bool {
    // Access constant in some function
    n > THRESHOLD
}
println!("{} is {}", n, if is_big(n) { "big" } else { "small" });
```

- `const` 修饰的常量不能被改变

```rust
fn main() {
    let n = 16;
    // Error! Cannot modify a `const`.
    THRESHOLD = 5;
    // FIXME ^ Comment out this line
}
```

### 用法

>  source [rust-rfcs](https://github.com/rust-lang/rfcs/blob/master/text/0246-const-vs-static.md)

把全局变量的声明分成两类

- `constant` 声明常量，仅仅表示一个值，不占用内存且编译期可知。
- `statics` 声明全局变量，占用内存空间，全局共享。用于全局锁，原子操作和调用CLib。

### 动机

1. 使用全局变量时会遇到的问题（难点在于 `static` ）：

- *显性地址和行内变量*。出于优化目的，编译时行内变量直接优化为数值是很有效的。同时，因为这些变量没有显性地址，所以编译器可以随意复制。更进一步地，如果一个常量在下游的编译产物中，如果发生改变，那将需要重新编译。

```rust
const num = 1;
let num2 = num;
// 编译时将行内变量转化为数值
let num2 = 1;
```

- *只读内存空间*。我们喜欢把一些较大的常量放在只读内存中，但这意味着数据必须是不可变的，变更时会引起段错误。
- *全局原子计数器*。我们喜欢使开发者在不使用不安全代码的前提下创建全局锁和原子计数器成为可能。

- *与C代码交互*。 一些C的库需要全局的使用空间，可变数据域；
- *初始化常量*。能被初始化创建，但不能被更改的常量。

2. 何时通过何种方法变更 `static` 修饰的变量才是`safe`的？

>  当前的设计是，`static` 修饰一个全局变量，默认不会有显性的地址（意味着是只读的）。通过宏`#[inline(never)]`修饰后才能获得显性地址。更进一步地，可以通过`static mut`定义“可变的静态变量”，但所有改变该变量的操作是 `unsafe` 的。
>
> 

🤔修改这个变量的步骤是否过于复杂？从上面我们得到的方法是：

- 只有使用 `Sync` 同步方法去修改 `static mut` 才是安全的；
- 同时必须要配合上宏`#[inline(never)]`把地址设为显性，但这个方法不够直觉，很绕；
- 这样一来，就没有普通的常量了；

还有一些担忧是：

- 虽然 `static` 和 `let` 看上去差不多，但实际上大有区别。通常，`static` 不修饰变量，修饰值，可以在行内使用且没有对齐的地址。是不可变的，但`let` 可以做到，准确的说是` let mut` 。同时不能重复声明`static`修饰的变量，虽然在`let`上是可以的。

### 细节设计const

1. 重新介绍 `const` ：

```rust
const name: type = value;
```

常量可以被定义在任何域且不能被同名覆盖。常量被设计为只读变量。然后，获取常量的引用实际上是获取方法栈中的地址，默认下，常量被定义的时候是没有显性地址的。常量被设计为像空枚举变量那样的。

2. 使用通用变量（`<T>`）

一个拓展，变量可以使用不同类型的值。

```rust
struct WrappedOption<T> { value: Option<T> }
const NONE<T> = WrappedOption { value: None }
```

这就让`static`变得没意义了，这已经表示需要各一个内存地址，并且T必须要有确定的类型。

3. 常量方法

It is possible to imagine constant functions as well. This could help to address the problem of encapsulating initialization. To avoid the need to specify what kinds of code can execute in a constant function, we can limit them syntactically to a single constant expression that can be expanded at compilation time (no recursion).

设定一个方法作为常量也是可行的。这能有效解决封装的问题，提高可读性和模块化程度。为了避免指定在常量方法中执行的代码，我们限制了在单个常量方法中只能同步运行，且必须是非递归的。

```rust
struct LockedData<T:Send> { lock: Lock, value: T }

const LOCKED<T:Send>(t: T) -> LockedData<T> {
    LockedData { lock: INIT_LOCK, value: t }
}
```

### 细节设计static

只使用`static`修饰静态变量：

- 静态变量通常只有静态的地址，选择性地用`static`'；
- 在`static`变量修饰的声明周期中，都是`'static`的，不允许移动；

非`mut`修饰的静态变量需要`Sync`和确定的类型并且访问他们是安全的。如果没有确定的类型，则会放在只读内存。

`mut`修饰的静态变量有任一类型，所有访问都是不安全的，他们可能不会被放在只读的内存中。

[rfcs/0246-const-vs-static.md at master · rust-lang/rfcs (github.com)](https://github.com/rust-lang/rfcs/blob/master/text/0246-const-vs-static.md#globals-referencing-globals)
