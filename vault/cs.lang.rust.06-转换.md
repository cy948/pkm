---
id: 7uvsnva4zyoavc5kwggz3pz
title: 06 转换
desc: ''
updated: 1672982589904
created: 1672982394725
---



> 基本类型可以通过转型[[cs.lang.rust.05-类型]]进行类型的转换，对于自定义类型，提供了一些 *traits* 进行转换。通常我们使用 *From* 和 *Into* 进行转换。

## From and Into

`From` 和 `Into` 两个 *trait* 是相关联的，如果能从类型 A 到 B，那也能从 B 到 A。

### From

`From` trait 定义了如何通过其他类型创建自己，`String` 类型的 `From` 提供了从基本类型和其他普通类型转化为自己的实现。

 `str` -> `String` ：

```rust
let my_str = "hello";
let my_string = String::from(my_str);
```

同样可以通过实现 `From` 方法去自定义转换

```rust
use std::convert::From;

#[derive(Debug)]
struct Number {
    value: i32,
}

impl From<i32> for Number {
    fn from(item: i32) -> Self {
        Number { value: item }
    }
}

fn main() {
    let num = Number::from(30);
    println!("My number is {:?}", num);
    /*
    	My number is Number { value: 30 }
    */
}
```



### Into

`Into` trait 是倒过来的 `From` 实现，但不是逆转。如下文中为自定义类型`struct Number`实现`From<i32>` trait ，则：

- 使用 `Number::from(12i32)` 可以使 `12i32` 转化为 `struct Number`；
- 对 `12i32` 使用 `.into()` 并且指定`struct Number` 类型可以使 `12i32` 转化为 `struct Number`；

```rust
use std::convert::From;

#[derive(Debug)]
struct Number {
    value: i32,
}

impl From<i32> for Number {
    fn from(item: i32) -> Self {
        Number { value: item }
    }
}

fn main() {
    let int = 5;
    // Try removing the type annotation
    // 移除掉 :Number 后将无法运行
    // 因为编译器不知道要调用哪个类型的 into()
    let num: Number = int.into();
    println!("My number is {:?}", num);
    // My number is Number { value: 5 }
}
```



## TryFrom and TryInto

与 `From` 和 `Into` 类似，`TryFrom` 和 `TryInto` 都是通用的 trait ，目的是为了类型转换。但不同于 `From` 和 `Into` ，`TryFrom` 和 `TryInto` 是用作容易出错的，需要`catch`的错误。

如下面的例子中将实现一个功能：将一个`i32`类型的转换为偶数，如果`i32`不是偶数，则抛出错误。

```rust
use std::convert::TryFrom;
use std::convert::TryInto;

#[derive(Debug, PartialEq)]
struct EvenNumber(i32);

impl TryFrom<i32> for EvenNumber {
    type Error = ();

    fn try_from(value: i32) -> Result<Self, Self::Error> {
        if value % 2 == 0 {
            Ok(EvenNumber(value))
        } else {
            Err(())
        }
    }
}

fn main() {
    // TryFrom
    assert_eq!(EvenNumber::try_from(8), Ok(EvenNumber(8)));
    assert_eq!(EvenNumber::try_from(5), Err(()));

    // TryInto
    let result: Result<EvenNumber, ()> = 8i32.try_into();
    assert_eq!(result, Ok(EvenNumber(8)));
    let result: Result<EvenNumber, ()> = 5i32.try_into();
    assert_eq!(result, Err(()));
}
```



## * To and From Strings

### -> String

将所有类型转换为 `String` 只需要实现该类型的 `ToString` 方法，但不是直接实现`ToString`方法，而是实现其`fmt::Display`方法即可（之前实现过）

```rust
use std::fmt;

struct Circle {
    radius: i32
}

impl fmt::Display for Circle {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "Circle of radius {}", self.radius)
    }
}

fn main() {
    let circle = Circle { radius: 6 };
    println!("{}", circle.to_string());
}
```



### String -> 

经常需要从一段`String`中解析出数字，下面将演示两种方法：

```rust
fn main() {
    // 由编译器推断类型
    let parsed: i32 = "5".parse().unwrap();
    // 指定类型
    let turbo_parsed = "10".parse::<i32>().unwrap();

    let sum = parsed + turbo_parsed;
    println!("Sum: {:?}", sum);
    // Sum: 15
}
```

