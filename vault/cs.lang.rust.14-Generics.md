---
id: euals30xdr5os2aeklsyll5
title: 14-Generics
desc: ''
updated: 1673250881979
created: 1673250881979
---


泛型是一种使类型和函数更通用的方法，是减少代码复杂度的方法。以下是一些通用的方法：

一个类型变量通常以[驼峰式命名](https://en.wikipedia.org/wiki/CamelCase): `<Aaa, Bbb, ...>`，一个泛型的类型指示符通常以 `<T>` 命名，以下是一个以泛型变量`arg: T`为参数的函数：

```rust
fn foo<T>(arg: T) { ... }
```

因为 `T` 已经被指定为泛型变量，以下是将 `T` 定义为`struct`的案例：

```rust
// A concrete type `A`.
struct A;

// In defining the type `Single`, the first use of `A` is not preceded by `<A>`.
// Therefore, `Single` is a concrete type, and `A` is defined as above.
// 定义一个元组 Single 第一个变量类型为 A
struct Single(A);
//            ^ Here is `Single`s first use of the type `A`.

// Here, `<T>` precedes the first use of `T`, so `SingleGen` is a generic type.
// Because the type parameter `T` is generic, it could be anything, including
// the concrete type `A` defined at the top.
// 元组 SingleGen 接受一个泛型 T，然后将 T 作为其第一个元素
struct SingleGen<T>(T);

fn main() {
    // `Single` is concrete and explicitly takes `A`.
    // `Single` 类型显式接受变量类型 A 
    let _s = Single(A);
    
    // Create a variable `_char` of type `SingleGen<char>`
    // and give it the value `SingleGen('a')`.
    // Here, `SingleGen` has a type parameter explicitly specified.
    // `SingleGen` 通过 `<char>` 指定第一个元素类型为 `char`
    let _char: SingleGen<char> = SingleGen('a');

    // `SingleGen` can also have a type parameter implicitly specified:
    let _t    = SingleGen(A); // Uses `A` defined at the top.
    let _i32  = SingleGen(6); // Uses `i32`.
    let _char = SingleGen('a'); // Uses `char`.
}
```

## 函数 function

同样可以为函数加上`<T>`去指定一个泛型`T`。使用泛型的函数如果返回一个泛型的值，则返回值类型参数也需要包含在内`<T,R>`：

```rust
fn generic<T,R>(arg: T, to: R) -> R{
   to 
}
```

以下是一些使用示例；

```rust
struct A;          // Concrete type `A`.
struct S(A);       // Concrete type `S`.
struct SGen<T>(T); // Generic type `SGen`.

// The following functions all take ownership of the variable passed into
// them and immediately go out of scope, freeing the variable.
// 以下的函数会移动所有权，离开函数后会被释放

// Define a function `reg_fn` that takes an argument `_s` of type `S`.
// This has no `<T>` so this is not a generic function.
fn reg_fn(_s: S) {}

// Define a function `gen_spec_t` that takes an argument `_s` of type `SGen<T>`.
// It has been explicitly given the type parameter `A`, but because `A` has not 
// been specified as a generic type parameter for `gen_spec_t`, it is not generic.
// 以下的函数在定义时已确定参数的泛型的实际类型，所以不是泛型
fn gen_spec_t(_s: SGen<A>) {}

// Define a function `gen_spec_i32` that takes an argument `_s` of type `SGen<i32>`.
// It has been explicitly given the type parameter `i32`, which is a specific type.
// Because `i32` is not a generic type, this function is also not generic.
fn gen_spec_i32(_s: SGen<i32>) {}

// Define a function `generic` that takes an argument `_s` of type `SGen<T>`.
// Because `SGen<T>` is preceded by `<T>`, this function is generic over `T`.
// 定义函数时，参数的类型为 泛型T，使用`<T>`接受类型
// 这个才是泛型
fn generic<T>(_s: SGen<T>) {}

fn main() {
    // Using the non-generic functions
    reg_fn(S(A));          // Concrete type.
    gen_spec_t(SGen(A));   // Implicitly specified type parameter `A`.
    gen_spec_i32(SGen(6)); // Implicitly specified type parameter `i32`.

    // Explicitly specified type parameter `char` to `generic()`.
    generic::<char>(SGen('a'));

    // Implicitly specified type parameter `char` to `generic()`.
    generic(SGen('c'));
}

```

## 实现 implementation

类似方法，`impl`实现需要保留泛型：`impl<T>`

```rust
struct S; // Concrete type `S`
struct GenericVal<T>(T); // Generic type `GenericVal`

// impl of GenericVal where we explicitly specify type parameters:
impl GenericVal<f32> {} // Specify `f32`
impl GenericVal<S> {} // Specify `S` as defined above

// `<T>` Must precede the type to remain generic
impl<T> GenericVal<T> {}
```



```rust
struct Val {
    val: f64,
}

struct GenVal<T> {
    gen_val: T,
}

// impl of Val
impl Val {
    fn value(&self) -> &f64 {
        &self.val
    }
}

// impl of GenVal for a generic type `T`
impl<T> GenVal<T> {
    fn value(&self) -> &T {
        &self.gen_val
    }
}

fn main() {
    let x = Val { val: 3.0 };
    let y = GenVal { gen_val: 3i32 };

    println!("{}, {}", x.value(), y.value());
}
```

## Traits

`trait`s 也可以泛化，以下是一些实现`Drop trait`的示例：

```rust
// Non-copyable types.
// 不可复制的类型，只能move
struct Empty;
struct Null;

// A trait generic over `T`.
trait DoubleDrop<T> {
    // Define a method on the caller type which takes an
    // additional single parameter `T` and does nothing with it.
    fn double_drop(self, _: T);
}

// Implement `DoubleDrop<T>` for any generic parameter `T` and
// caller `U`.
impl<T, U> DoubleDrop<T> for U {
    // This method takes ownership of both passed arguments,
    // deallocating both.
    fn double_drop(self, _: T) {}
}

fn main() {
    let empty = Empty;
    let null  = Null;

    // Deallocate `empty` and `null`.
    empty.double_drop(null);

    //empty;
    //null;
    // ^ TODO: Try uncommenting these lines.
}

```

## Bounds 边界

1. 泛型使用的作用边界：

- 同一方法内可用

```rust
// Define a function `printer` that takes a generic type `T` which
// must implement trait `Display`.
fn printer<T: Display>(t: T) {
    println!("{}", t);
}
```

- 超出边界无法使用

```rust
struct S<T: Display>(T);

// Error! `Vec<T>` does not implement `Display`. This
// specialization will fail.
let s = S(vec![1]);
```

2. 使用泛型边界，指定泛型

以下案例中，为了实现计算面积的方法`area`，规定所有传入`area`方法的参数都可以使用`HasArea`这个`trait`

```rust
// A trait which implements the print marker: `{:?}`.
use std::fmt::Debug;

// 为 area 方法定义了一个特征，该特征是
// 有一个方法 fn area(&self) -> f64
trait HasArea {
    fn area(&self) -> f64;
}

// 为结构体 Rectangle 实现特征 HasArea
impl HasArea for Rectangle {
    fn area(&self) -> f64 { self.length * self.height }
}

#[derive(Debug)]
struct Rectangle { length: f64, height: f64 }
#[allow(dead_code)]
struct Triangle  { length: f64, height: f64 }

// The generic `T` must implement `Debug`. Regardless
// of the type, this will work properly.
fn print_debug<T: Debug>(t: &T) {
    println!("{:?}", t);
}

// `T` must implement `HasArea`. Any type which meets
// the bound can access `HasArea`'s function `area`.
// 定义方法 area ，规定参数必须实现 HasArea，然后该方法内就能
// 调用所实现的 .area() 方法
fn area<T: HasArea>(t: &T) -> f64 { t.area() }

fn main() {
    let rectangle = Rectangle { length: 3.0, height: 4.0 };
    let _triangle = Triangle  { length: 3.0, height: 4.0 };

    print_debug(&rectangle);
    println!("Area: {}", rectangle.area());

    //print_debug(&_triangle);
    //println!("Area: {}", _triangle.area());
    // ^ TODO: Try uncommenting these.
    // | Error: Does not implement either `Debug` or `HasArea`. 
}
```

OOP 特性：[面向对象语言的特征](https://rustwiki.org/zh-CN/book/ch17-01-what-is-oo.html#面向对象语言的特征)

### Testcase empty bounds

```rust
struct Cardinal;
struct BlueJay;
struct Turkey;

trait Red {}
trait Blue {}

impl Red for Cardinal {}
impl Blue for BlueJay {}

// These functions are only valid for types which implement these
// traits. The fact that the traits are empty is irrelevant.
fn red<T: Red>(_: &T)   -> &'static str { "red" }
fn blue<T: Blue>(_: &T) -> &'static str { "blue" }

fn main() {
    let cardinal = Cardinal;
    let blue_jay = BlueJay;
    let _turkey   = Turkey;

    // `red()` won't work on a blue jay nor vice versa
    // because of the bounds.
    println!("A cardinal is {}", red(&cardinal));
    println!("A blue jay is {}", blue(&blue_jay));
    //println!("A turkey is {}", red(&_turkey));
    // ^ TODO: Try uncommenting this line.
}
```

### [See also:](https://doc.rust-lang.org/rust-by-example/generics/bounds/testcase_empty.html#see-also)

[`std::cmp::Eq`](https://doc.rust-lang.org/std/cmp/trait.Eq.html), [`std::marker::Copy`](https://doc.rust-lang.org/std/marker/trait.Copy.html), and [`trait`s](https://doc.rust-lang.org/rust-by-example/trait.html)



## [Multiple bounds](https://doc.rust-lang.org/rust-by-example/generics/multi_bounds.html#multiple-bounds)

可以为方法指定多重泛型边界，同一类型的边界用 `+` 连接，不同用 `,` 

```rust
use std::fmt::{Debug, Display};

fn compare_prints<T: Debug + Display>(t: &T) {
    println!("Debug: `{:?}`", t);
    println!("Display: `{}`", t);
}

fn compare_types<T: Debug, U: Debug>(t: &T, u: &U) {
    println!("t: `{:?}`", t);
    println!("u: `{:?}`", u);
}

fn main() {
    let string = "words";
    let array = [1, 2, 3];
    let vec = vec![1, 2, 3];

    compare_prints(&string);
    //compare_prints(&array);
    // TODO ^ Try uncommenting this.

    compare_types(&array, &vec);
}
```



## [Where clauses](https://doc.rust-lang.org/rust-by-example/generics/where.html#where-clauses)

边界条件可以被关键字`where`约束，不同的是，`where`关键字的应用更清晰，以下是两种表示方式的同义对比：

```rust
impl<A: TraitB + TraitC, D: TraitE + TraitF> MyTrait<A, D> for YourType {}

// Expressing bounds with a `where` clause
impl<A, D> MyTrait<A, D> for YourType where
    A: TraitB + TraitC,
    D: TraitE + TraitF {}
```

当应用`where`后，不需要再用`<A: TraitB + Trait, D>`修饰`impl`了：

```rust
use std::fmt::Debug;

trait PrintInOption {
    fn print_in_option(self);
}

// Because we would otherwise have to express this as `T: Debug` or 
// use another method of indirect approach, this requires a `where` clause:
impl<T> PrintInOption for T where
    Option<T>: Debug {
    // We want `Option<T>: Debug` as our bound because that is what's
    // being printed. Doing otherwise would be using the wrong bound.
    fn print_in_option(self) {
        println!("{:?}", Some(self));
    }
}

fn main() {
    let vec = vec![1, 2, 3];

    vec.print_in_option();
}
```



## [New Type Idiom](https://doc.rust-lang.org/rust-by-example/generics/new_types.html#new-type-idiom)

`newtype` 习惯保证了编译器接受的类型是正确的。例如，一个年龄的验证方法会检查按年表示的年龄，类型必须为`Years`

```rust
struct Years(i64);
struct Days(i64);

impl Years {
    pub fn to_days(&self) -> Days {
        Days(self.0 * 365)
    }
}


impl Days {
    /// truncates partial years
    pub fn to_years(&self) -> Years {
        Years(self.0 / 365)
    }
}

fn old_enough(age: &Years) -> bool {
    age.0 >= 18
}

fn main() {
    let age = Years(5);
    let age_days = age.to_days();
    println!("Old enough {}", old_enough(&age));
    println!("Old enough {}", old_enough(&age_days.to_years()));
    // println!("Old enough {}", old_enough(&age_days));
}
/*
Old enough false
Old enough false
*/
```

为了获取这个`newtype`的值，需要用到解构语法：

```rust
struct Years(i64);

fn main() {
    let years = Years(42);
    let years_as_primitive_1: i64 = years.0; // Tuple
    let Years(years_as_primitive_2) = years; // Destructuring
}
```



## [Associated items](https://doc.rust-lang.org/rust-by-example/generics/assoc_items.html#associated-items)

### [The Problem](https://doc.rust-lang.org/rust-by-example/generics/assoc_items/the_problem.html#the-problem)

> `trait` 定义行为，类似interface，需要impl后才有功能

关联`item`s指向一系列关于`item`s的类型，也是`trait`泛型的拓展，使`trait`s在内部定义新的`item`s。

- 定义结构体`Container`和特征`Contains`

```rust
struct Container(i32, i32);

// A trait which checks if 2 items are stored inside of container.
// Also retrieves first or last value.
trait Contains<A, B> {
    fn contains(&self, _: &A, _: &B) -> bool; // Explicitly requires `A` and `B`.
    fn first(&self) -> i32; // Doesn't explicitly require `A` or `B`.
    fn last(&self) -> i32;  // Doesn't explicitly require `A` or `B`.
}
```

- 为结构体`Container`实现特征`Contains`

```rust
impl Contains<i32, i32> for Container {
    // True if the numbers stored are equal.
    fn contains(&self, number_1: &i32, number_2: &i32) -> bool {
        (&self.0 == number_1) && (&self.1 == number_2)
    }

    // Grab the first number.
    fn first(&self) -> i32 { self.0 }

    // Grab the last number.
    fn last(&self) -> i32 { self.1 }
}
```

- 在方法`difference`中，使用`where`关键字限定了`C`的类型为具有`Contains<A,B>`特征的`Container`实现

```rust
// `C` contains `A` and `B`. In light of that, having to express `A` and
// `B` again is a nuisance.
fn difference<A, B, C>(container: &C) -> i32 where
    C: Contains<A, B> {
    container.last() - container.first()
}

fn main() {
    let number_1 = 3;
    let number_2 = 10;

    let container = Container(number_1, number_2);

    println!("Does container contain {} and {}: {}",
        &number_1, &number_2,
        container.contains(&number_1, &number_2));
    println!("First number: {}", container.first());
    println!("Last number: {}", container.last());

    println!("The difference is: {}", difference(&container));
}
```

### [Associated types](https://doc.rust-lang.org/rust-by-example/generics/assoc_items/types.html#associated-types)

在上面的例子中，`Contains trait` 允许泛型`A`和`B`的使用，特征`Contains`为类型`Container`实现。在`difference`方法中指定了`A`和`B`为`i32`。

因为`Contains`是泛化的，我们需要为`fn difference()`明确指定类型。在实践中想要`A`和`B`取决于输入参数`C`，做法如下：

- 定义类型及特征

```rust
struct Container(i32, i32);

// A trait which checks if 2 items are stored inside of container.
// Also retrieves first or last value.
trait Contains<A, B> {
    fn contains(&self, _: &A, _: &B) -> bool; // Explicitly requires `A` and `B`.
    fn first(&self) -> i32; // Doesn't explicitly require `A` or `B`.
    fn last(&self) -> i32;  // Doesn't explicitly require `A` or `B`.
}
```

- 与上面不同，实现特征`Contains`时指定了泛型`A`和`B`的类型`<i32,i32>`

```rust
impl Contains<i32, i32> for Container {
    // True if the numbers stored are equal.
    fn contains(&self, number_1: &i32, number_2: &i32) -> bool {
        (&self.0 == number_1) && (&self.1 == number_2)
    }

    // Grab the first number.
    fn first(&self) -> i32 { self.0 }

    // Grab the last number.
    fn last(&self) -> i32 { self.1 }
}

// `C` contains `A` and `B`. In light of that, having to express `A` and
// `B` again is a nuisance.
fn difference<A, B, C>(container: &C) -> i32 where
    C: Contains<A, B> {
    container.last() - container.first()
}

fn main() {
    let number_1 = 3;
    let number_2 = 10;

    let container = Container(number_1, number_2);

    println!("Does container contain {} and {}: {}",
        &number_1, &number_2,
        container.contains(&number_1, &number_2));
    println!("First number: {}", container.first());
    println!("Last number: {}", container.last());

    println!("The difference is: {}", difference(&container));
}
```

