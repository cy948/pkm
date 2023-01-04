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

## 实验

### 2.2 Tuples

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

- 

```rust



fn main() {


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

    // Out of bound indexing causes runtime error
    //println!("{}", xs[5]);
}

```



- 
