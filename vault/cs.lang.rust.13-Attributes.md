---
id: vwcw4bnke7ij6ik00x6nivd
title: 13-Attributes
desc: ''
updated: 1673248165651
created: 1673248165651
---

Attribute 是一种应用于`module`,`crate` or `item`的元数据，可以用来：

- 条件编译 [conditional compilation of code](https://doc.rust-lang.org/rust-by-example/attribute/cfg.html)

- 设置产物的名称、版本、类型（二进制文件、库） [set crate name, version and type (binary or library)](https://doc.rust-lang.org/rust-by-example/attribute/crate.html)
- 关闭编译器的提示 disable [lints](https://en.wikipedia.org/wiki/Lint_(software)) (warnings)
- 启用编译器特性 enable compiler features (macros, glob imports, etc.)
- 链接外部库 link to a foreign library
- 将函数标记为单元测试 mark functions as unit tests
- 将函数标记为性能测试的一部分 mark functions that will be part of a benchmark
- [attribute like macros](https://doc.rust-lang.org/book/ch19-06-macros.html#attribute-like-macros)

**范围**(scope)：

- 应用于整个产物 ：`#![crate_attribute]`
- 应用到`module` or `item` ：`#[crate_attribute]`

**参数**(arguments)：

```rust
#[attribute = "value"]
#[attribute(key = "value")]
#[attribute(value)]
```

也可以传递多个参数：

```rust
#[attribute(value1, value2)]

#[attribute(value1, value2, value3,
    value4,value5)]
```



## dead_code

编译器会提醒有未使用(unused)的代码，可以通过指定参数进行关闭：

```rust
fn used_function() {}

// `#[allow(dead_code)]` is an attribute that disables the `dead_code` lint
#[allow(dead_code)]
fn unused_function() {}

fn noisy_unused_function() {}
// FIXME ^ Add an attribute to suppress the warning

fn main() {
    used_function();
}
```



## cfg

### 通过`cfg`实现条件编译：

- 参数形式： `#[cfg(...)]`；
- 宏形式： `cfg!(...)`；

当指定了条件编译后，将会在运行时检查条件并进行编译。两者区别在于是否移除代码，前者移除。

`cfg!` ，不像 `#[cfg]`，不需要移除代码，只需要判断条件是否符合然后执行。

```rust
// This function only gets compiled if the target OS is linux
#[cfg(target_os = "linux")]
fn are_you_on_linux() {
    println!("You are running linux!");
}

// And this function only gets compiled if the target OS is *not* linux
#[cfg(not(target_os = "linux"))]
fn are_you_on_linux() {
    println!("You are *not* running linux!");
}

fn main() {
    are_you_on_linux();

    println!("Are you sure?");
    if cfg!(target_os = "linux") {
        println!("Yes. It's definitely linux!");
    } else {
        println!("Yes. It's definitely *not* linux!");
    }
}
```

### 自定义`cfg`

可以在编译时通过`--cfg`标志实现自定义`cfg`

```rust
#[cfg(some_condition)]
fn conditional_function() {
    println!("condition met!");
}

fn main() {
    conditional_function();
}
```

运行：

```rust
$ rustc --cfg some_condition custom.rs && ./custom
condition met!
```

