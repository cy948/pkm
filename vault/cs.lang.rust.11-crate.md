---
id: 6f1uchihw2ggetmwq83mmhj
title: '11 Crates'
desc: ''
updated: 1673164073420
created: 1673164073420
---

> crate 是一个编译单元，当运行：
>
> ```bash
> rustc file.rs
> ```
>
> 时，`file.rs` 将会被视为一个编译单元(*a crate file*)，如果`file.rs`含有`mod`声明，那么这些模组将会插入`file.rs`中，换句话说，模组不会单独被编译，当一个编译单元编译时，模组才会被编译。



## 创建库

### 静态链接

创建一个库，将库链接到另一个构建产物

- `rary.rs`

```rust
pub fn public_function() {
    println!("called rary's `public_function()`");
}

fn private_function() {
    println!("called rary's `private_function()`");
}

pub fn indirect_access() {
    print!("called rary's `indirect_access()`, that\n> ");

    private_function();
}
```

在`rustc`选项中指定`--crate-type=lib`创建库，或者通过`--crate-name`选项指定库名称。

```bash
$ rustc --crate-type=lib rary.rs
$ ls lib*
library.rlib
```

然后就可以使用库了：

```rust
// extern crate rary; // May be required for Rust 2015 edition or earlier

fn main() {
    rary::public_function();

    // Error! `private_function` is private
    //rary::private_function();

    rary::indirect_access();
}
```

此处编译器会报错，但直接编译就行

```bash
rustc main.rs --extern rary=library.rlib --edition=2018 && ./main
```

