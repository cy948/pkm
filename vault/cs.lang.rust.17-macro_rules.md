---
id: auoib97fyb3vuvz4zzoi4z9
title: 17 Macro_rules
desc: ''
updated: 1674114859668
created: 1674114859668
---



## macro_rules!

通过`macro_rules!`定义一个宏

```rust
macro_rules! my_macro {
    () => {
        println!("Check out my macro!");
    };
}

fn main() {
    my_macro!();
}
```

使用`mod`里面的宏：`#[macro_use]`

```rust
#[macro_use]
mod macros {
    macro_rules! my_macro {
        () => {
            println!("Check out my macro!");
        };
    }
}

fn main() {
    my_macro!();
}
```

## [Designators](https://doc.rust-lang.org/rust-by-example/macros/designators.html#designators)

- 在匹配器中，`$`*名称*`:`*匹配段选择器* 这种句法格式匹配符合指定句法类型的 Rust 句法段，并将其绑定到元变量 `$`*名称* 上。有效的匹配段选择器包括：
  - `item`: [*程序项*](https://rustwiki.org/zh-CN/reference/items.html)
  - `block`: [*块表达式*](https://rustwiki.org/zh-CN/reference/expressions/block-expr.html)
  - `stmt`: [*语句*](https://rustwiki.org/zh-CN/reference/statements.html)，注意此选择器不匹配句尾的分号（如果匹配器中提供了分号，会被当做分隔符），但碰到分号是自身的一部分的程序项语句的情况又会匹配。
  - `pat`: [*模式*](https://rustwiki.org/zh-CN/reference/patterns.html)
  - `expr`: [*表达式*](https://rustwiki.org/zh-CN/reference/expressions.html)
  - `ty`: [*类型*](https://rustwiki.org/zh-CN/reference/types.html#type-expressions)
  - `ident`: [标识符或关键字](https://rustwiki.org/zh-CN/reference/identifiers.html)
  - `path`: [*类型表达式*](https://rustwiki.org/zh-CN/reference/paths.html#paths-in-types) 形式的路径
  - `tt`: [*token树*](https://rustwiki.org/zh-CN/reference/macros.html#macro-invocation) (单个 [token](https://rustwiki.org/zh-CN/reference/tokens.html) 或宏匹配定界符 `()`、`[]` 或`{}` 中的标记)
  - `meta`: [*属性*](https://rustwiki.org/zh-CN/reference/attributes.html)，属性中的内容
  - `lifetime`: [生存期token](https://rustwiki.org/zh-CN/reference/tokens.html#lifetimes-and-loop-labels)
  - `vis`: 可能为空的[*可见性*](https://rustwiki.org/zh-CN/reference/visibility-and-privacy.html)限定符
  - `literal`: 匹配 `-`?[*字面量表达式*](https://rustwiki.org/zh-CN/reference/expressions/literal-expr.html)

> macro中的每个arm写完记得加上`;`

```rust
macro_rules! my_macro {
    () => {
        println!("Check out my macro!");
    };
    ($val:expr) => {
        println!("Look at this other macro: {}", $val);
    };
}

fn main() {
    my_macro!();
    my_macro!(7777);
}
```

