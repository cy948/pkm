---
id: ppnr1duenm3ctz9dqhe1kl4
title: '表达式'
desc: ''
updated: 1672984799337
created: 1672984799338
---





## 表达式

一个Rust程序通常由一系列的表达式组成：

```rust
fn main() {
    // statement
    // statement
    // statement
}
```

表达式不多，通过由变量绑定和表达式组成：

```rust
fn main() {
    // variable binding
    // 变量绑定
    let x = 5;

    // expression;
   	// 表达式
    x;
    x + 1;
    15;
}
```

使用 `{}` 去圈出一个代码块用作赋值的操作，代码块的最后一个不带`;`的值就是改表达式的值，但如果最后一个值后面带有 `;` 则返回值为 `()`

```rust
fn main() {
    let x = 5u32;

    let y = {
        let x_squared = x * x;
        let x_cube = x_squared * x;

        // This expression will be assigned to `y`
        // 下面表达式的值将会赋值给 y
        x_cube + x_squared + x
    };

    let z = {
        // The semicolon suppresses this expression and `()` is assigned to `z`
        // 如果表达式后面有 ; 则返回 ()
        2 * x;
    };

    println!("x is {:?}", x);
    println!("y is {:?}", y);
    println!("z is {:?}", z);
    /*
	    x is 5
		y is 155
		z is ()
    */
}
```

