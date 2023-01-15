---
id: wpzw1zj1mcbh93dj2htr4yl
title: '08 控制流'
desc: ''
updated: 1672985410200
created: 1672985410200
---



> 控制流是每个语言的必备语法糖，下面讨论在rust中的`if/else for`

## if / else

不同于其他语言，布尔表达式不需要被`()`包裹，但表达式必须要被`{}`包裹

```rust
fn main() {
    let n = 5;

    if n < 0 {
        print!("{} is negative", n);
    } else if n > 0 {
        print!("{} is positive", n);
    } else {
        print!("{} is zero", n);
    }
    // 5 is positive

    let big_n =
        if n < 10 && n > -10 {
            println!(", and is a small number, increase ten-fold");
			// , and is a small number, increase ten-fold

            // This expression returns an `i32`.
            10 * n
        } else {
            println!(", and is a big number, halve the number");

            // This expression must return an `i32` as well.
            n / 2
            // TODO ^ Try suppressing this expression with a semicolon.
            //此处不能使用 ; ，使用 ; 意味着它就不是最后一个表达式了，就不能做返回值了
        };
    //   ^ Don't forget to put a semicolon here! All `let` bindings need it.
    // 此处的 ; 是赋值语句的结束
    

    println!("{} -> {}", n, big_n);
    // 5 -> 50
}
```



## 循环 loop

Rust 提供了 `loop` 关键字去实现循环功能，`break` 用于退出循环，`continue` 用于跳出当前，继续下一个循环。

```rust
fn main() {
    let mut count = 0u32;

    println!("Let's count until infinity!");

    // Infinite loop
    loop {
        count += 1;

        if count == 3 {
            println!("three");

            // Skip the rest of this iteration
            continue;
        }

        println!("{}", count);

        if count == 5 {
            println!("OK, that's enough");

            // Exit this loop
            break;
        }
    }
    
    /*
	    Let's count until infinity!
		1
		2
		three
		4
		5
		OK, that's enough
    */
}
```



## 循环嵌套和标签 Nesting and labels

当有多个循环嵌套时，必须使用标签去指定跳出的是哪个循环，如下：

- 进入外层循环
- 进入内层循环
  - 直接跳出外层循环，`Line 17` 不会被执行；
- 结束

```rust
#![allow(unreachable_code)]

fn main() {
    'outer: loop {
        println!("Entered the outer loop");

        'inner: loop {
            println!("Entered the inner loop");

            // This would break only the inner loop
            //break;

            // This breaks the outer loop
            break 'outer;
        }

        println!("This point will never be reached");
    }

    println!("Exited the outer loop");
}
/*
	Entered the outer loop
	Entered the inner loop
	Exited the outer loop
*/
```



## 从循环中带值返回 Returning from loops

在循环的过程中返回，`break 返回值;`

```rust
fn main() {
    let mut counter = 0;

    let result = loop {
        counter += 1;

        if counter == 10 {
            break counter * 2;
        }
    };

    assert_eq!(result, 20);
}
```



## while

`while` 语句用于在根据语句退出循环的场景中，以下是实现一个[Fizz buzz](https://en.wikipedia.org/wiki/Fizz_buzz)游戏的程序。

```rust
fn main() {
    // A counter variable
    let mut n = 1;

    // Loop while `n` is less than 101
    while n < 101 {
        if n % 15 == 0 {
            println!("fizzbuzz");
        } else if n % 3 == 0 {
            println!("fizz");
        } else if n % 5 == 0 {
            println!("buzz");
        } else {
            println!("{}", n);
        }

        // Increment counter
        n += 1;
    }
}
```

 

## 范围循环 for i in 1..20

使用`for`重新实现上面[Fizz buzz](https://en.wikipedia.org/wiki/Fizz_buzz)游戏的程序。❗`for i in 1..101`的范围是`1,2,...,100`，以下两个判断是等价的，都是`1,2,...100`

```rust
for n in 1..101
for n in 1..=100
```

实现：

```rust
fn main() {
    // `n` will take the values: 1, 2, ..., 100 in each iteration
    // 此处循环是从 1 到 100
    for n in 1..101 { // 等价于 for n in 1..=100{
        if n % 15 == 0 {
            println!("fizzbuzz");
        } else if n % 3 == 0 {
            println!("fizz");
        } else if n % 5 == 0 {
            println!("buzz");
        } else {
            println!("{}", n);
        }
        if n > 100 {println!("end{}", n)};
    }
}
```



## 使用迭代器遍历 for and iterators

`for` 可以使用迭代器进行遍历，默认情况下会调用集合中的`into_iter`方法进行迭代，但这并不是唯一方法。`into_ter` , `iter` 和 `iter_mut` 都承担集合到迭代器的过程，但各有不同，分别是：只读、阅后即焚和返回可修改的引用。

- `iter` 为每次迭代提供元素，仅提供引用。

> ❗ `match` 语句里面的是 `&str` 不是 `str` 

```rust
fn main() {
    let names = vec!["Bob", "Frank", "Ferris"];

    for name in names.iter() {
        match name {
            &"Ferris" => println!("There is a rustacean among us!"),
            // TODO ^ Try deleting the & and matching just "Ferris"
            // expected `&str`
            _ => println!("Hello {}", name),
        }
    }
    
    println!("names: {:?}", names);
}

```

- `into_iter` 提供元素的同时移除元素

> ❗与上相反， `match` 语句里面的是 `str` 不是 `&str` 

```rust
fn main() {
    let names = vec!["Bob", "Frank", "Ferris"];
    println!("names: {:?}", names);
    // names: ["Bob", "Frank", "Ferris"]
    
    for name in names.into_iter() {
        match name {
            "Ferris" => println!("There is a rustacean among us!"),
            // expected `str`
            _ => println!("Hello {}", name),
        }
    }
    
    println!("names: {:?}", names);
    // FIXME ^ Comment out this line
    // 此处不能被打印，因为迭代后被全部移除
}
```

- `iter_mut` 每次遍历时，都会返回一个可修改的引用

```rust
fn main() {
    let mut names = vec!["Bob", "Frank", "Ferris"];

    for name in names.iter_mut() {
        *name = match name {
            &mut "Ferris" => "There is a rustacean among us!",
            _ => "Hello",
        }
    }

    println!("names: {:?}", names);
    // names: ["Hello", "Hello", "There is a rustacean among us!"]
}
```

## 多分支选择语句 match

像C的`switch`。

```rust
    match number {
        // Match a single value
        // 匹配单个值
        1 => println!("One!"),
        // Match several values
        // 匹配多个值
        2 | 3 | 5 | 7 | 11 => println!("This is a prime"),
        // TODO ^ Try adding 13 to the list of prime values
        // Match an inclusive range
        // 范围从 13,14,...,19
        13..=19 => println!("A teen"),
        // Handle the rest of cases
        // 剩下从的用 _ 标记即可
        _ => println!("Ain't special"),
        // TODO ^ Try commenting out this catch-all arm
    }
```

- 如果末尾不加 `_ => ;` 

```rust
    let boolean = true;
    // Match is an expression too
    let binary = match boolean {
        // The arms of a match must cover all the possible values
        false => 0,
        true => 1,
        // TODO ^ Try commenting out one of these arms
        // 注释后编译器会提示未覆盖所有可能值
        // ensure that all possible cases are being handled by adding a match arm with a wildcard pattern or an explicit pattern as shown
        // 添加 _ => {} 可以解决问题
    };

    println!("{} -> {}", boolean, binary);
```

## 使用 match 进行解构

❗需要注意解构时映射的长度和实际长度、元素名和实际的名是否一致

### Tuples

> ```rust
> let triple = (0, -2, 3);
>     // TODO ^ Try different values for `triple`
>     println!("Tell me about {:?}", triple);
>     // Match can be used to destructure a tuple
> ```


使用`match`进行匹配：
```rust
    match triple {
        // Destructure the second and third elements
        (0, y, z) => println!("First is `0`, `y` is {:?}, and `z` is {:?}", y, z),

        (1, ..)  => println!("First is `1` and the rest doesn't matter"),
		// 只匹配第一个
        
        (.., 2)  => println!("last is `2` and the rest doesn't matter"),
        // 只匹配最后一个
        
        (3, .., 4)  => println!("First is `3`, last is `4`, and the rest doesn't matter"),
        // `..` can be used to ignore the rest of the tuple
        // 只匹配第一个和最后一个
        
        _      => println!("It doesn't matter what they are"),
        // `_` means don't bind the value to a variable
    }
```

### Array/slices

> ```rust
>     // Try changing the values in the array, or make it a slice!
>     let array = [1, -2, 6];
> ```

类似`tuple` ，`Array` 也可以被解构

```rust
    match array {
        // Binds the second and the third elements to the respective variables
        // 将第二第三个元素的值绑定到指定变量名
        [0, second, third] =>
            println!("array[0] = 0, array[1] = {}, array[2] = {}", second, third),

        // Single values can be ignored with _
        [1, _, third] => println!(
            "array[0] = 1, array[2] = {} and array[1] was ignored",
            third
        ),
        // 忽略一个元素，忽略了 array[1]

        // You can also bind some and ignore the rest
        [-1, second, ..] => println!(
            "array[0] = -1, array[1] = {} and all the other ones were ignored",
            second
        ),
        // 忽略第二个以后的元素
        // 如果数组长度是3，以下的代码将不能被编译
        // 因为映射长度与实际长度不一致
        // The code below would not compile
        // [-1, second] => ...

        // Or store them in another array/slice (the type depends on
        // that of the value that is being matched against)
        [3, second, tail @ ..] => println!(
            "array[0] = 3, array[1] = {} and the other elements were {:?}",
            second, tail
        ),
        // tail @.. 是指将剩下的都存为 tail 数组

        // Combining these patterns, we can, for example, bind the first and
        // last values, and store the rest of them in a single array
        [first, middle @ .., last] => println!(
            "array[0] = {}, middle = {:?}, array[2] = {}",
            first, middle, last
        ),
        // middle @.. 是将剩下的都存为 middle 数组
        // array[0] = 2, middle = [-2], array[2] = 6
    }
```

### enums

> ```rust
> // `allow` required to silence warnings because only
> // one variant is used.
> #[allow(dead_code)]
> enum Color {
>     // These 3 are specified solely by their name.
>     Red,
>     Blue,
>     Green,
>     // These likewise tie `u32` tuples to different names: color models.
>     RGB(u32, u32, u32),
>     HSV(u32, u32, u32),
>     HSL(u32, u32, u32),
>     CMY(u32, u32, u32),
>     CMYK(u32, u32, u32, u32),
> }
> ```

开始匹配

```rust
fn main() {
    let color = Color::RGB(122, 17, 40);
    // TODO ^ Try different variants for `color`

    println!("What color is it?");
    // An `enum` can be destructured using a `match`.
    match color {
        Color::Red   => println!("The color is Red!"),
        Color::Blue  => println!("The color is Blue!"),
        Color::Green => println!("The color is Green!"),
        Color::RGB(r, g, b) =>
            println!("Red: {}, green: {}, and blue: {}!", r, g, b),
        Color::HSV(h, s, v) =>
            println!("Hue: {}, saturation: {}, value: {}!", h, s, v),
        Color::HSL(h, s, l) =>
            println!("Hue: {}, saturation: {}, lightness: {}!", h, s, l),
        Color::CMY(c, m, y) =>
            println!("Cyan: {}, magenta: {}, yellow: {}!", c, m, y),
        Color::CMYK(c, m, y, k) =>
            println!("Cyan: {}, magenta: {}, yellow: {}, key (black): {}!",
                c, m, y, k),
        // Don't need another arm because all variants have been examined
        // 此处不需要 _ => 的原因是所有可能的值已经被覆盖
    }
}
```

### pointers/ref

在 C / C++ 中使用 `*` 解引用，但在Rust中使用方法不同：

- 使用 `*` 解引用
- 使用 `&, ref, ref mut` 解构

```rust
    // Assign a reference of type `i32`. The `&` signifies there
    // is a reference being assigned.
    let reference = &4;

    match reference {
        // If `reference` is pattern matched against `&val`, it results
        // in a comparison like:
        // `&i32`
        // `&val`
        // ^ We see that if the matching `&`s are dropped, then the `i32`
        // should be assigned to `val`.
        &val => println!("Got a value via destructuring: {:?}", val),
    }

    // To avoid the `&`, you dereference before matching.
    match *reference {
        val => println!("Got a value via dereferencing: {:?}", val),
    }

    // What if you don't start with a reference? `reference` was a `&`
    // because the right side was already a reference. This is not
    // a reference because the right side is not one.
    let _not_a_reference = 3;

    // Rust provides `ref` for exactly this purpose. It modifies the
    // assignment so that a reference is created for the element; this
    // reference is assigned.
    let ref _is_a_reference = 3;

    // Accordingly, by defining 2 values without references, references
    // can be retrieved via `ref` and `ref mut`.
    let value = 5;
    let mut mut_value = 6;

    // Use `ref` keyword to create a reference.
    match value {
        ref r => println!("Got a reference to a value: {:?}", r),
    }

    // Use `ref mut` similarly.
    match mut_value {
        ref mut m => {
            // Got a reference. Gotta dereference it before we can
            // add anything to it.
            *m += 10;
            println!("We added 10. `mut_value`: {:?}", m);
        },
    }
```



### struct

```rust
fn main() {
    struct Foo {
        x: (u32, u32),
        y: u32,
    }

    // Try changing the values in the struct to see what happens
    let foo = Foo { x: (1, 2), y: 3 };

    match foo {
        Foo { x: (1, b), y } => println!("First of x is 1, b = {},  y = {} ", b, y),

        // you can destructure structs and rename the variables,
        // the order is not important
        Foo { y: 2, x: i } => println!("y is 2, i = {:?}", i),

        // and you can also ignore some variables:
        Foo { y, .. } => println!("y = {}, we don't care about x", y),
        // 下面语句报错的原因是没有映射 x 
        // this will give an error: pattern does not mention field `x`
        //Foo { y } => println!("y = {}", y),
    }
    // First of x is 1, b = 2,  y = 3 
}
```

## 使用 match 守卫 Guards

> 匹配的守卫条件。
>
> ```rust
> enum Temperature {
>     Celsius(i32),
>     Fahrenheit(i32),
> }
> ```

如果你指向匹配`enum Tmperature`中的一个值：

```rust
fn main() {
    let temperature = Temperature::Celsius(35);
    // ^ TODO try different values for `temperature`

    match temperature {
        // 只匹配 Celsius 
        Temperature::Celsius(t) if t > 30 => println!("{}C is above 30 Celsius", t),
        // The `if condition` part ^ is a guard
        // if 条件 部分是一个守卫
        Temperature::Celsius(t) => println!("{}C is below 30 Celsius", t),

        Temperature::Fahrenheit(t) if t > 86 => println!("{}F is above 86 Fahrenheit", t),
        Temperature::Fahrenheit(t) => println!("{}F is below 86 Fahrenheit", t),
    }
}

```

## 使用 match 对匹配到的变量进行绑定 bind

> ❗赋值和绑定的区别：赋值是将一个值赋给一个新的变量，最后得到两个变量，但绑定只是为一个值增加一个把手，到头来变量没有增加。

使用 `变量名 @` 的方式绑定所匹配的遍历

```rust
// A function `age` which returns a `u32`.
fn age() -> u32 {
    15
}

fn main() {
    println!("Tell me what type of person you are");

    match age() {
        0             => println!("I haven't celebrated my first birthday yet"),
        // Could `match` 1 ..= 12 directly but then what age
        // would the child be? Instead, bind to `n` for the
        // sequence of 1 ..= 12. Now the age can be reported.
        n @ 1  ..= 12 => println!("I'm a child of age {:?}", n),
        // 使用 n 绑定匹配到的 1..=12 的数字
        n @ 13 ..= 19 => println!("I'm a teen of age {:?}", n),
        // Nothing bound. Return the result.
        n             => println!("I'm an old person of age {:?}", n),
    }
}
```

也可以使用解构的 `enum` 变量，如：`Option` ：

> `Option` 会在后面 `std` 中介绍，或者直接看[Option - Rust By Example (rust-lang.org)](https://doc.rust-lang.org/rust-by-example/std/option.html)

```rust
fn some_number() -> Option<u32> {
    Some(42)
}

fn main() {
    match some_number() {
        // Got `Some` variant, match if its value, bound to `n`,
        // is equal to 42.
        Some(n @ 42) => println!("The Answer: {}!", n),
        // Match any other number.
        Some(n)      => println!("Not interesting... {}", n),
        // Match anything else (`None` variant).
        _            => (),
    }
}
```

> `Option` 是用来catch错误而不调用`panic!` 
>
> `Option<T>` 有两种调用方法
>
> - `None` 指示空变量
> - `Some(value)` 使用元组包装`value:T` 

## 条件绑定 if / let

一些情况下，匹配枚举类时，`match` 会和尴尬，例如：

```rust
// Make `optional` of type `Option<i32>`
let optional = Some(7);

match optional {
    Some(i) => {
        println!("This is a really long string and `{:?}`", i);
        // ^ Needed 2 indentations just so we could destructure
        // `i` from the option.
    },
    _ => {},
    // ^ Required because `match` is exhaustive. Doesn't it seem
    // like wasted space?
};
// This is a really long string and `7`
```

使用 `if let` 进行匹配之后，将会变得更清晰易懂：

> ```rust
>     // All have type `Option<i32>`
>     let number = Some(7);
>     let letter: Option<i32> = None;
>     let emoticon: Option<i32> = None;
> ```

```rust
	// 如果 Some(7) == number，则令 i = 7
	// The `if let` construct reads: "if `let` destructures `number` into
    // `Some(i)`, evaluate the block (`{}`).
    if let Some(i) = number {
        println!("Matched {:?}!", i);
    }

    // If you need to specify a failure, use an else:
    if let Some(i) = letter {
        println!("Matched {:?}!", i);
    } else {
        // Destructure failed. Change to the failure case.
        println!("Didn't match a number. Let's go with a letter!");
    }

    // Provide an altered failing condition.
    let i_like_letters = false;

    if let Some(i) = emoticon {
        println!("Matched {:?}!", i);
    // Destructure failed. Evaluate an `else if` condition to see if the
    // alternate failure branch should be taken:
    } else if i_like_letters {
        println!("Didn't match a number. Let's go with a letter!");
    } else {
        // The condition evaluated false. This branch is the default:
        println!("I don't like letters. Let's go with an emoticon :)!");
    }
```

同样，`if let` 也可以用作解构枚举类

> ```rust
> // Our example enum
> enum Foo {
>     Bar,
>     Baz,
>     Qux(u32)
> }
> // Create example variables
> let a = Foo::Bar;
> let b = Foo::Baz;
> let c = Foo::Qux(100);
> ```

示例：

```rust

    
    // Variable a matches Foo::Bar
    if let Foo::Bar = a {
        println!("a is foobar");
    }
    
    // Variable b does not match Foo::Bar
    // So this will print nothing
    if let Foo::Bar = b {
        println!("b is foobar");
    }
    
    // Variable c matches Foo::Qux which has a value
    // Similar to Some() in the previous example
    if let Foo::Qux(value) = c {
        println!("c is {}", value);
    }

    // Binding also works with `if let`
    if let Foo::Qux(value @ 100) = c {
        println!("c is one hundred");
    }
```

另一个使用`if let`的好处是它让我们匹配非参数化的枚举类型，如下直接编译是不通过的：

```rust
// This enum purposely neither implements nor derives PartialEq.
// That is why comparing Foo::Bar == a fails below.
enum Foo {Bar}

fn main() {
    let a = Foo::Bar;

    // Variable a matches Foo::Bar
    if let Foo::Bar == a {
    // ^-- this causes a compile-time error. Use `if let` instead.
        println!("a is foobar");
    }
}
/* 错误提示：
3 | enum Foo {Bar}
  | ^^^^^^^^ must implement `PartialEq<_>`
*/
```

使用 `if let` 就可以：

```diff
-    if Foo::Bar == a {
+    if let Foo::Bar = a {
```

## 循环绑定 while let

类似 `if let` ，`while let` 可以使尴尬的`match`结果更加可接受。

```rust
// Make `optional` of type `Option<i32>`
let mut optional = Some(0);

// Repeatedly try this test.
loop {
    match optional {
        // If `optional` destructures, evaluate the block.
        Some(i) => {
            if i > 9 {
                println!("Greater than 9, quit!");
                optional = None;
            } else {
                println!("`i` is `{:?}`. Try again.", i);
                optional = Some(i + 1);
            }
            // ^ Requires 3 indentations!
        },
        // Quit the loop when the destructure fails:
        _ => { break; }
        // ^ Why should this be required? There must be a better way!
    }
}
```

使用`while let`后：

```rust
    // Make `optional` of type `Option<i32>`
    let mut optional = Some(0);

    // This reads: "while `let` destructures `optional` into
    // `Some(i)`, evaluate the block (`{}`). Else `break`.
    while let Some(i) = optional {
        if i > 9 {
            println!("Greater than 9, quit!");
            optional = None;
        } else {
            println!("`i` is `{:?}`. Try again.", i);
            optional = Some(i + 1);
        }
        // ^ Less rightward drift and doesn't require
        // explicitly handling the failing case.
    }
    // ^ `if let` had additional optional `else`/`else if`
    // clauses. `while let` does not have these.
```

