---
id: 8q1eijl2nu40qpzl9uu3eyx
title: '字符串'
desc: ''
updated: 1672237747729
created: 1672237747729
---



## 百变string

[Rust Solutions for Remove First and Last Character | Codewars](https://www.codewars.com/kata/56bc28ad5bdaeb48760009b0/solutions/rust)

```rust
fn string_slice(arg: &str) {
    println!("{}", arg);
    arg.len();
}
fn string(arg: String) {
    println!("{}", arg);
}

fn main() {
    string_slice("blue");
    string("red".to_string());
    string(String::from("hi"));
    string("rust is fun!".to_owned());
    string("nice weather".into());
    string(format!("Interpolation {}", "Station"));
    string_slice(&String::from("abc")[0..1]);
    string_slice("  hello there ".trim());
    string("Happy Monday!".to_string().replace("Mon", "Tues"));
    string("mY sHiFt KeY iS sTiCkY".to_lowercase());
}
```

