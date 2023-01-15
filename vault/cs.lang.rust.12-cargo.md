---
id: 9mqpfs9zn5orgizx0w784xj
title: 12 Cargo
desc: ''
updated: 1673242122416
created: 1673242122416
---

`Cargo` 是一个官方的依赖包管理工具，包含三个功能：

- 基于官方仓库[crates.io](https://crates.io/) 的依赖管理
- 单元测试
- 性能测试

完整的文档[Introduction - The Cargo Book (rust-lang.org)](https://doc.rust-lang.org/cargo/)


## 依赖 Dependence

1. 创建

```bash
# 二进制程序
cargo new foo

# 库
cargo new --lib bar
```

在接下来的章节中会假设你创建的是二进制程序。在上面的创建后会看到这样的目录：

```
.
├── bar
│   ├── Cargo.toml
│   └── src
│       └── lib.rs
└── foo
    ├── Cargo.toml
    └── src
        └── main.rs
```

`Cargo.toml`是`Cargo`的配置文件，初始配置：

```toml
[package]
name = "foo"
version = "0.1.0"
authors = ["mark"]

[dependencies]
```

- `name` 是项目名称；
- `version` 是版本，格式[Semantic Versioning](http://semver.org/)；
- `authors` 是作者

`[dependencies]`标签可以添加依赖，主要三个来源：

> source [Specifying Dependencies - The Cargo Book (rust-lang.org)](https://doc.rust-lang.org/cargo/reference/specifying-dependencies.html)

- [crates.io](crates.io) 
```toml
clap = "2.27.1" # from crates.io
```

- 在线仓库 
```toml
rand = { git = "https://github.com/rust-lang-nursery/rand" } # from online repo
```

- 本地
```toml
bar = { path = "../bar" } # from a path in the local filesystem
```

2. 运行

```bash
cargo build # 构建
cargo run # 构建并运行
```



## 约定 Convention

假设我们想要在一个项目中编译两个二进制文件：默认情况下，会将`src/main.rs`编译为二进制文件，现在我们想将`bin/my_other_bin.rs`也编译成二进制文件。

```
foo
├── Cargo.toml
└── src
    ├── main.rs
    └── bin
        └── my_other_bin.rs
```

只需在`cargo`命令的基础上增加`--bin my_other_bin`即可。

## Tests

单元测试放在`tests`下，如：

```
foo
├── Cargo.toml
├── src
│   └── main.rs
│   └── lib.rs
└── tests
    ├── my_test.rs
    └── my_other_test.rs
```

在`tests`文件夹下，每一个文件都是一个分离的集成测试，类似`jest`。运行测试只需：

```bash
cargo test
```

输出：

```bash
$ cargo test
   Compiling blah v0.1.0 (file:///nobackup/blah)
    Finished dev [unoptimized + debuginfo] target(s) in 0.89 secs
     Running target/debug/deps/blah-d3b32b97275ec472

running 3 tests
test test_bar ... ok
test test_baz ... ok
test test_foo_bar ... ok
test test_foo ... ok

test result: ok. 3 passed; 0 failed; 0 ignored; 0 measured; 0 filtered out
```

可以单独运行一个测试：

```bash
$ cargo test test_foo

   Compiling blah v0.1.0 (file:///nobackup/blah)
    Finished dev [unoptimized + debuginfo] target(s) in 0.35 secs
     Running target/debug/deps/blah-d3b32b97275ec472

running 2 tests
test test_foo ... ok
test test_foo_bar ... ok

test result: ok. 2 passed; 0 failed; 0 ignored; 0 measured; 2 filtered out
```

需要注意的是，`Cargo`会同时运行这些测试，所以需要人工确保他们不会存在竞争同一资源问题。以下两个测试会同时写入`ferris.txt`

```rust
#[cfg(test)]
mod tests {
    // Import the necessary modules
    use std::fs::OpenOptions;
    use std::io::Write;

    // This test writes to a file
    #[test]
    fn test_file() {
        // Opens the file ferris.txt or creates one if it doesn't exist.
        let mut file = OpenOptions::new()
            .append(true)
            .create(true)
            .open("ferris.txt")
            .expect("Failed to open ferris.txt");

        // Print "Ferris" 5 times.
        for _ in 0..5 {
            file.write_all("Ferris\n".as_bytes())
                .expect("Could not write to ferris.txt");
        }
    }

    // This test tries to write to the same file
    #[test]
    fn test_file_also() {
        // Opens the file ferris.txt or creates one if it doesn't exist.
        let mut file = OpenOptions::new()
            .append(true)
            .create(true)
            .open("ferris.txt")
            .expect("Failed to open ferris.txt");

        // Print "Corro" 5 times.
        for _ in 0..5 {
            file.write_all("Corro\n".as_bytes())
                .expect("Could not write to ferris.txt");
        }
    }
}
```

如果非同时运行，这个文本应该是这样的：

```bash
$ cargo test test_foo
Corro
Ferris
Corro
Ferris
Corro
Ferris
Corro
Ferris
Corro
Ferris

```

实际上是这样的：

```bash
$ cat ferris.txt
Ferris
Ferris
Ferris
Ferris
Ferris
Corro
Corro
Corro
Corro
Corro
```



## 构建指令 Build Scripts

默认下会寻找项目目录中的`build.rs`，也可以在`Cargo.toml`中指定

```toml
[package]
...
build = "build.rs"
```

