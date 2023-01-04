---
id: izq3iazv88er71m69djjgbl
title: '01-标准输入输出、格式化'
desc: ''
updated: 1672804792805
created: 1672803298117
---

## 输出

### 标准输出、格式化输出

> source [formatprint](https://doc.rust-lang.org/rust-by-example/hello/print.html)
>
> document [std::fmt - Rust (rust-lang.org)](https://doc.rust-lang.org/std/fmt/)

由一系列在`std::fmt`中的宏定义，包括：`format!`及由`format!`拓展的一系列宏，`format` 用于：**将文本格式化为`String`**，拓展的宏包括：`print!`和`println!`，两者都会将格式化后的文本打印到控制台，区别在于后者格式化后的文本跟一个`\n`（`io::stdout`); 

1. 有以下**指定位置**的方式：

> - 按下标
>
> 紧跟着格式化串的元素是`0`号元素
>
> ```rust
> // at 0 immediately after the format string
> println!("{0}, this is {1}. {1}, this is {0}", "Alice", "Bob");
> ```
>
> - 按名称
>
> ```rust
>     // As can named arguments.
>     println!("{subject} {verb} {object}",
>              object="the lazy dog",
>              subject="the quick brown fox",
>              verb="jumps over");
> ```
>

2. 有下列**格式化**的方式

>- 进制转换
>
>数字按照在`{}`处所指示的方式进行格式化，如`:b`是二进制
>
>
>```rust
>// Different formatting can be invoked by specifying the format character after a
>// `:`.
>println!("Base 10:               {}",   69420); //69420 十进制
>println!("Base 2 (binary):       {:b}", 69420); //10000111100101100 二进制
>println!("Base 8 (octal):        {:o}", 69420); //207454
>println!("Base 16 (hexadecimal): {:x}", 69420); //10f2c
>println!("Base 16 (hexadecimal): {:X}", 69420); //10F2C
>```
>
>- 显示位数
>
>显示5位的`5`，如：`"    5"` 而不是 `"5"`
>
>```rust
>// You can right-justify text with a specified width. This will
>// output "    1". (Four white spaces and a "1", for a total width of 5.)
>   println!("{number:>5}", number=1);
>```
>
>- 补充 `0` 
>
>其中补充的位数可以通过在格式化串中定义`变量名$`来指定，如下示例二：
>
>```rust
>// You can pad numbers with extra zeroes,
>//and left-adjust by flipping the sign. This will output "10000".
>   println!("{number:0<5}", number=1);
>// You can use named arguments in the format specifier by appending a `$`. This will output "00001".
>   println!("{number:0>width$}", number=1, width=5);
>```
>
>- 结构体？
>
>🤔看完下面的代码就会发现，其实`print!`宏调用的就是`fmt::Display`方法
>
>```rust
>    #[allow(dead_code)]
>    struct Structure(i32);
>
>    // This will not compile because `Structure` does not implement
>    // fmt::Display
>    //println!("This struct `{}` won't print...", Structure(3));
>    // TODO ^ Try uncommenting this line
>```
>
>这段代码不能通过编译时检查，因为Structure的`Display`方法没有实现，所以不能使用 `{}` 直接打印，下文将介绍打印结构体的两种方法：实现`Display`方法、使用`std`类型自动实现（使用`#[derive(Debug)]` + `{:?}`）；

- `eprint!` 和 `eprint!`，通过错误信息打印。(`io::stderr`)，使用方法同上。



### 调试信息

打印所有类型（包括结构体）时都需要实现打印方法从而把他打印出来。只有在`std`库中的类型才能自动实现，其他均需要手动实现。

所有`std`库中的类型都可以通过`{:?}`的串自动实现打印方法：

- `{:?}` 的使用方法

使用宏声明使用`std`库实现结构体的打印：

```rust
// Derive the `fmt::Debug` implementation for `Structure`. `Structure`
// is a structure which contains a single `i32`.
#[derive(Debug)]
struct Structure(i32);

// Put a `Structure` inside of the structure `Deep`. Make it printable
// also.
#[derive(Debug)]
struct Deep(Structure);

fn main() {
    // Printing with `{:?}` is similar to with `{}`.
    println!("{:?} months in a year.", 12);
    println!("{1:?} {0:?} is the {actor:?} name.",
             "Slater",
             "Christian",
             actor="actor's");

    // `Structure` is printable!
    println!("Now {:?} will print!", Structure(3));
    
    // The problem with `derive` is there is no control over how
    // the results look. What if I want this to just show a `7`?
    println!("Now {:?} will print!", Deep(Structure(7)));
}
```



- 使用`{:#?}`优雅地打印结构体

```rust
#[derive(Debug)]
struct Person<'a> {
    name: &'a str,
    age: u8
}

fn main() {
    let name = "Peter";
    let age = 27;
    let peter = Person { name, age };

    // Pretty print
    println!("{:#?}", peter);
}

/*output:
    Person {
        name: "Peter",
        age: 27,
    }
*/
```



### 显示

在上文说过，可以通过实现方法去定义输出的字符串格式。`fmt::Debug`格式固定，可以通过实现`fmt::Display`方法从而自定义格式化输出；

```rust
#![allow(unused)]
fn main() {
	// Import (via `use`) the `fmt` module to make it available.
    use std::fmt;

    // Define a structure for which `fmt::Display` will be implemented. This is
    // a tuple struct named `Structure` that contains an `i32`.
    struct Structure(i32);

    // To use the `{}` marker, the trait `fmt::Display` must be implemented
    // manually for the type.
    impl fmt::Display for Structure {
        // This trait requires `fmt` with this exact signature.
        fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
            // Write strictly the first element into the supplied output
            // stream: `f`. Returns `fmt::Result` which indicates whether the
            // operation succeeded or failed. Note that `write!` uses syntax which
            // is very similar to `println!`.
            write!(f, "{}", self.0)
        }
    }
}
```

> `write!` 方法：
>
> - 第一个参数`f`固定传入 `fmt::Formatter` ；
> - 从第二个参数开始，类似`format!`的格式化串的参数；
>
> 下面示例中主要看输出了什么，`impl` 的方法是如何写的；

```rust
use std::fmt; // Import `fmt`

// A structure holding two numbers. `Debug` will be derived so the results can
// be contrasted with `Display`.
#[derive(Debug)]
struct MinMax(i64, i64);

// Implement `Display` for `MinMax`.
impl fmt::Display for MinMax {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        // Use `self.number` to refer to each positional data point.
        write!(f, "({}, {})", self.0, self.1)
    }
}

// Define a structure where the fields are nameable for comparison.
#[derive(Debug)]
struct Point2D {
    x: f64,
    y: f64,
}

// Similarly, implement `Display` for `Point2D`
impl fmt::Display for Point2D {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        // Customize so only `x` and `y` are denoted.
        write!(f, "x: {}, y: {}", self.x, self.y)
    }
}

fn main() {
    let minmax = MinMax(0, 14);

    println!("Compare structures:");
    println!("Display: {}", minmax);
    println!("Debug: {:?}", minmax);

    let big_range =   MinMax(-300, 300);
    let small_range = MinMax(-3, 3);

    println!("The big range is {big} and the small is {small}",
             small = small_range,
             big = big_range);

    let point = Point2D { x: 3.3, y: 7.2 };

    println!("Compare points:");
    
    println!("Display: {}", point);
    //Display: x: 3.3, y: 7.2
    
    println!("Debug: {:?}", point);
    //Debug: Point2D { x: 3.3, y: 7.2 }

    // Error. Both `Debug` and `Display` were implemented, but `{:b}`
    // requires `fmt::Binary` to be implemented. This will not work.
    // println!("What does Point2D look like in binary: {:b}?", point);
}
```

**拓展**：整齐地打印一个数组（第一个元素前不加`，`）

```rust
use std::fmt; // Import the `fmt` module.

// Define a structure named `List` containing a `Vec`.
struct List(Vec<i32>);

impl fmt::Display for List {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        // Extract the value using tuple indexing,
        // and create a reference to `vec`.
        // .0 是因为结构体是元组
        let vec = &self.0;

        write!(f, "[")?;

        // Iterate over `v` in `vec` while enumerating the iteration
        // count in `count`.
        for (count, v) in vec.iter().enumerate() {
            // For every element except the first, add a comma.
            // Use the ? operator to return on errors.
            if count != 0 { write!(f, ", ")?; }
            write!(f, "{}", v)?;
        }

        // Close the opened bracket and return a fmt::Result value.
        write!(f, "]")
    }
}

fn main() {
    let v = List(vec![1, 2, 3]);
    println!("{}", v);
}
//[0: 1, 1: 2, 2: 3]
```



## 格式化

实现字符串的格式化方法

> 以下将使用一个格式化输出城市方向的案例展示格式化的实现

```rust
use std::fmt::{self, Formatter, Display};

struct City {
    name: &'static str,
    // Latitude
    lat: f32,
    // Longitude
    lon: f32,
}

```

实现打印方法：


```rust
impl Display for City {
    // `f` is a buffer, and this method must write the formatted string into it
    fn fmt(&self, f: &mut Formatter) -> fmt::Result {
        //判断方位
        let lat_c = if self.lat >= 0.0 { 'N' } else { 'S' };
        let lon_c = if self.lon >= 0.0 { 'E' } else { 'W' };

        // `write!` is like `format!`, but it will write the formatted string
        // into a buffer (the first argument)
        write!(f, "{}: {:.3}°{} {:.3}°{}",
               self.name, self.lat.abs(), lat_c, self.lon.abs(), lon_c)
    }
}

#[derive(Debug)]
struct Color {
    red: u8,
    green: u8,
    blue: u8,
}

fn main() {
    for city in [
        City { name: "Dublin", lat: 53.347778, lon: -6.259722 },
        City { name: "Oslo", lat: 59.95, lon: 10.75 },
        City { name: "Vancouver", lat: 49.25, lon: -123.1 },
    ].iter() {
        println!("{}", *city);//已经实现Display方法， 直接上 {} 即可
    }
}
```

如果没实现`Display` 方法，那打印的时候就不能用`{}` ，要用`{:?}` 

```rust
    for color in [
        Color { red: 128, green: 255, blue: 90 },
        Color { red: 0, green: 3, blue: 254 },
        Color { red: 0, green: 0, blue: 0 },
    ].iter() {
        // Switch this to use {} once you've added an implementation
        // for fmt::Display.
        println!("{:?}", *color);
    }
```

## 实验

### 1.2 Formatted Print

打印 `Pi` ，要求：

- 保留三位小数
- 最后一位进一

思路：

- 实现打印方法
- 将精度设置为 3 位

文档：[std::fmt - Rust (rust-lang.org)](https://doc.rust-lang.org/std/fmt/#precision)

```rust
use std::fmt;
struct Pi(f32);
impl fmt::Display for Pi{
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result{
        write!(f, "Pi is rougly {0:.prec$X?}", self.0, prec = 3)
    }
}

fn main() {
    println!("{}", Pi(3.141592));
}
/*
	Pi is rougly 3.142
*/
```




### 1.2.2 Display

添加一个结构体`Complex` ，打印示例如下：

```rust
Display: 3.3 + 7.2i
Debug: Complex { real: 3.3, imag: 7.2 }
```

**思路**：

- 输出1是实现`Display`方法的输出

```rust
use std::fmt;

#[derive(Debug)]
struct Complex{
    real: f32,
    imag: f32
}

impl fmt::Display for Complex {
   fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
       //TODO
       write!(f, "{} + {}i", self.real, self.imag)
   }
}

fn main(){
    let comp = Complex{real: 3.3, imag: 7.2};
    println!("Display: {}", comp);
    println!("Debug: {:?}", comp);
}
```

### 1.2.2.1 Testcase: List

尝试更改[Testcase: List](https://doc.rust-lang.org/rust-by-example/hello/print/print_display/testcase_list.html)中的代码，使得输出为：

```rust
[0: 1, 1: 2, 2: 3]
```

原来是：

```rust
[1, 2, 3]
```

**思路**：

- 更改 `Display` 中迭代器里面的`write!`宏即可

```rust
use std::fmt; // Import the `fmt` module.

// Define a structure named `List` containing a `Vec`.
struct List(Vec<i32>);

impl fmt::Display for List {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        // Extract the value using tuple indexing,
        // and create a reference to `vec`.
        let vec = &self.0;

        write!(f, "[")?;

        // Iterate over `v` in `vec` while enumerating the iteration
        // count in `count`.
        for (count, v) in vec.iter().enumerate() {
            // For every element except the first, add a comma.
            // Use the ? operator to return on errors.
            if count != 0 { write!(f, ", ")?; }
            write!(f, "{}: {}", count,v)?;
        }

        // Close the opened bracket and return a fmt::Result value.
        write!(f, "]")
    }
}

fn main() {
    let v = List(vec![1, 2, 3]);
    println!("{}", v);
}
```

### 1.2.3 Formatting

实现结构体 `Color` 的 `Display` 方法，使得其输出为：

```rust
RGB (128, 255, 90) 0x80FF5A
RGB (0, 3, 254) 0x0003FE
RGB (0, 0, 0) 0x000000
```

提示：

- [不足位补0](https://doc.rust-lang.org/std/fmt/#width)  `:0>2`.

**思路**：

输出格式为：`RGB (red$, green$, blue$) Hex$`， 其中 `Hex$` 需要按照 `red$, green$, blue$` 的顺序拼出来，

格式化串`{:0>2X}` ：

- `0>2` 不足两位的数补0；
- `X` 转化为大写字母的十六进制；

所以`write!` 宏为：

```rust
write!(f, 
    "RGB ({}, {}, {}) 0x{0:0>2X}{1:0>2X}{2:0>2X}",  	self.red, self.green, self.blue, 
)
```

完整：

```rust
use std::fmt;
#[derive(Debug)]
struct Color {
    red: u8,
    green: u8,
    blue: u8,
}

impl fmt::Display for Color{
   fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
       write!(f, "RGB ({}, {}, {}) 0x{0:0>2X}{1:0>2X}{2:0>2X}", self.red, self.green, self.blue, )
   } 
}

fn main() {
    for color in [
        Color { red: 128, green: 255, blue: 90 },
        Color { red: 0, green: 3, blue: 254 },
        Color { red: 0, green: 0, blue: 0 },
    ].iter() {
        // Switch this to use {} once you've added an implementation
        // for fmt::Display.
        println!("{}", *color);
    }
}
```

