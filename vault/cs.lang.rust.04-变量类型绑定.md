---
id: vwj2hb5fawp6gnawzn8g6z9
title: '04 变量与类型'
desc: ''
updated: 1672909547231
created: 1672909547231
---



## 变量类型绑定

Rust提供了静态的类型绑定，当声明的时候就已经绑定了静态的类型。编译器也会根据变量去推断类型。

```rust
fn main() {
    let an_integer = 1u32;
    let a_boolean = true;
    let unit = ();

    // copy `an_integer` into `copied_integer`
    let copied_integer = an_integer;

    println!("An integer: {:?}", copied_integer);
    println!("A boolean: {:?}", a_boolean);
    println!("Meet the unit value: {:?}", unit);
```

编译器会提醒没使用过的变量，通过之前的宏定义或在变量前+下划线即可

```rust
    // The compiler warns about unused variable bindings; these warnings can
    // be silenced by prefixing the variable name with an underscore
    let _unused_variable = 3u32;
    let noisy_unused_variable = 2u32;
    // FIXME ^ Prefix with an underscore to suppress the warning
    // Please note that warnings may not be shown in a browser
}
```



## 可变性

变量绑定通常在默认情况下是不可变的，但可以通过 `mut` 修饰符改变。

```rust
fn main() {
    let _immutable_binding = 1;
    let mut mutable_binding = 1;

    println!("Before mutation: {}", mutable_binding);

    // Ok
    mutable_binding += 1;

    println!("After mutation: {}", mutable_binding);

    // Error!
    _immutable_binding += 1;
    // FIXME ^ Comment out this line
}
```

将 `Line:3` 改为：

```diff
-    let _immutable_binding = 1;
+    let mut _immutable_binding = 1;
```



## 作用域和覆盖

变量绑定有作用域，在本级代码块中`{}`。

```rust
fn main() {
    // This binding lives in the main function
    let long_lived_binding = 1;

    // This is a block, and has a smaller scope than the main function
    {
        // This binding only exists in this block
        let short_lived_binding = 2;

        println!("inner short: {}", short_lived_binding);
    }
    // End of the block

    // Error! `short_lived_binding` doesn't exist in this scope
    println!("outer short: {}", short_lived_binding);
    // FIXME ^ Comment out this line

    println!("outer long: {}", long_lived_binding);
}
```

同样，在一个作用域中覆盖变量也是允许的

```rust
fn main() {
    let shadowed_binding = 1;

    {
        println!("before being shadowed: {}", shadowed_binding);

        // This binding *shadows* the outer one
        let shadowed_binding = "abc";

        println!("shadowed in inner block: {}", shadowed_binding);
    }
    println!("outside inner block: {}", shadowed_binding);

    // This binding *shadows* the previous binding
    let shadowed_binding = 2;
    println!("shadowed in outer block: {}", shadowed_binding);
}
```



## 先声明后初始化？不推荐

先声明类型，后初始化是允许的，但也会造成使用未经初始化的变量。

```rust
fn main() {
    // Declare a variable binding
    let a_binding;

    {
        let x = 2;

        // Initialize the binding
        a_binding = x * x;
    }

    println!("a binding: {}", a_binding);

    let another_binding;

    // ❗问题出现，使用了未经初始化的变量
    // Error! Use of uninitialized binding
    println!("another binding: {}", another_binding);
    // FIXME ^ Comment out this line

    another_binding = 1;

    println!("another binding: {}", another_binding);
}
```

编译器禁止使用未经初始化的变量，因为这会产生未定义行为。

## 冻结

当值被声明为不可变的时候，就被冻结了。冻结的变量不可以被改变直至离开作用域。

When data is bound by the same name immutably, it also *freezes*. *Frozen* data can't be modified until the immutable binding goes out of scope:

```rust
fn main() {
    let mut _mutable_integer = 7i32;

    {
        // Shadowing by immutable `_mutable_integer`
        let _mutable_integer = _mutable_integer;

        // ❗上面已经冻结该变量，直至离开这一层的{}
       	// 前都不允许修改
        // Error! `_mutable_integer` is frozen in this scope
        _mutable_integer = 50;
        // FIXME ^ Comment out this line

        // `_mutable_integer` goes out of scope
    }

    // Ok! `_mutable_integer` is not frozen in this scope
    _mutable_integer = 3;
}
```

