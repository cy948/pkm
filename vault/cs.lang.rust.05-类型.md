---
id: bso70qsk9ubs09g0dvthkwx
title: 05 类型
desc: ''
updated: 1672910682848
created: 1672910682848
---

> Rust 提供了一系列定义和改变类型的机制

## 转型

Rust 在基本类型之间提供非隐性的类型转换，可以使用 `as` 进行显性的转换

整型的转换规则类似C的整型提升，除了那些产生未定义行为的。

- 上来先关掉编译器的整型溢出提示
```rust
// Suppress all warnings from casts which overflow.
#![allow(overflowing_literals)]
```

- 无隐性类型转换

> 无法将`f32`类型的`decimal`赋值给类型为`u8`的`integer`，因为编译器不执行隐性的转换。

```rust
fn main() {
    let decimal = 65.4321_f32;

    // Error! No implicit conversion
    let integer: u8 = decimal;
    // FIXME ^ Comment out this line

    // Explicit conversion
    let integer = decimal as u8;
    let character = integer as char;
```

- 浮点数无法直接转为`char`

> 先转 `u8`，再转`char`也是可以的
>
> ```rust
>     let character = decimal as u8 as char;
> ```

```rust
    // Error! There are limitations in conversion rules. 
    // A float cannot be directly converted to a char.
    let character = decimal as char;
    // FIXME ^ Comment out this line

    println!("Casting: {} -> {} -> {}", decimal, integer, character);
```

### -> 无符号整型

- 与C语言类似，将任何整型**转化为无符号**整型时，将会被加上或减去“新类型的最大值 + 1”
  - 一样长时不变：`1000` -> `u16` = `1000`；
  - 长度减少，减去 “新类型最大值+1” ：`1000` -> `u8` = `1000 - 256 - 256 - 256 = 232`；
  - 有符号**负数**转无符号数：`-1i8` -> `u8` = `-1 + 256 = 255`；
  - 有符号**正数**转无符号数：`1000` -> `u8` 相当于 `mod 256` -> `1000 % 256  = 232`  ；


```rust
    // when casting any value to an unsigned type, T,
    // T::MAX + 1 is added or subtracted until the value
    // fits into the new type

    // 1000 already fits in a u16
    println!("1000 as a u16 is: {}", 1000 as u16);
	// 1000 as a u16 is: 1000

    // 1000 - 256 - 256 - 256 = 232
    // Under the hood, the first 8 least significant bits (LSB) are kept,
    // while the rest towards the most significant bit (MSB) get truncated.
    println!("1000 as a u8 is : {}", 1000 as u8);
    // -1 + 256 = 255
    println!("  -1 as a u8 is : {}", (-1i8) as u8);

    // For positive numbers, this is the same as the modulus
    println!("1000 mod 256 is : {}", 1000 % 256);
```

### -> 有符号整型

如果长度已经符合，则没有变化

```rust
    // Unless it already fits, of course.
    println!(" 128 as a i16 is: {}", 128 as i16);
	// 128 as a i16 is: 128
```

不符合时，第一次转型将会截取成长度符合的无符号整型，此时：

```rust
    // When casting to a signed type, the (bitwise) result is the same as
    // first casting to the corresponding unsigned type. If the most significant
    // bit of that value is 1, then the value is negative.
    
    // 128 as u8 -> 128, whose value in 8-bit two's complement representation is:
    println!(" 128 as a i8 is : {}", 128 as i8);

    // repeating the example above
    // 1000 as u8 -> 232
    println!("1000 as a u8 is : {}", 1000 as u8);
    // and the value of 232 in 8-bit two's complement representation is -24
    println!(" 232 as a i8 is : {}", 232 as i8);
    
    // Since Rust 1.45, the `as` keyword performs a *saturating cast* 
    // when casting from float to int. If the floating point value exceeds 
    // the upper bound or is less than the lower bound, the returned value 
    // will be equal to the bound crossed.
    
    // 300.0 as u8 is 255
    println!(" 300.0 as u8 is : {}", 300.0_f32 as u8);
    // -100.0 as u8 is 0
    println!("-100.0 as u8 is : {}", -100.0_f32 as u8);
    // nan as u8 is 0
    println!("   nan as u8 is : {}", f32::NAN as u8);
    
    // This behavior incurs a small runtime cost and can be avoided 
    // with unsafe methods, however the results might overflow and 
    // return **unsound values**. Use these methods wisely:
    unsafe {
        // 300.0 as u8 is 44
        println!(" 300.0 as u8 is : {}", 300.0_f32.to_int_unchecked::<u8>());
        // -100.0 as u8 is 156
        println!("-100.0 as u8 is : {}", (-100.0_f32).to_int_unchecked::<u8>());
        // nan as u8 is 0
        println!("   nan as u8 is : {}", f32::NAN.to_int_unchecked::<u8>());
    }
}
````

 ### 总结

```rust
assert_eq!(  10_i8 as u16,    10_u16); 
// 正数值由少位数转入多位数

assert_eq!( 2525_u16 as i16, 2525_i16); 
// 正数值同位数转换

assert_eq!(  -1_i16 as i32,    -1_i32); 
// 负数少位转多位执行符号位扩展

assert_eq!(65535_u16 as i32, 65535_i32); 
// 正数少位转多位执行0位扩展（也可以理解为符号位扩展）

assert_eq!( 1000_i16 as u8, 232_u8); 
//由多位数转少位数，会截掉多位数的高位，相当于多位数除以2^N的取模，其中N是少位数的位数
//1000的二进制是0000 0011 1110 1000，截掉左侧8位，留下右侧8位，是232

assert_eq!(65535_u32 as i16, -1_i16); 
//65535的二进制,16个0和16个1，截掉高位的16个0，剩下的全是1，全1的有符号补码是-1
//同位数的带符号和无符号相互转化，存储的数字并不动，只是解释的方法不一样//无符号数，就是这个值；而有符号数，需要用补码来翻译

assert_eq!(-1_i8  as u8, 255_u8);  
//有符号转无符号 
assert_eq!(255_u8 as i8, -1_i8);  
//无符号转有符号
```



## 字面量

数值型字面量可以通过添加类型的后缀指定其类型，如果无后缀，将会为整数标记为 `i32` ，小数标记为 `f64` 

```rust
fn main() {
    // Suffixed literals, their types are known at initialization
    let x = 1u8;
    let y = 2u32;
    let z = 3f32;

    // Unsuffixed literals, their types depend on how they are used
    let i = 1; // i32
    let f = 1.0; // f64

    // `size_of_val` returns the size of a variable in bytes
    println!("size of `x` in bytes: {}", std::mem::size_of_val(&x));
    println!("size of `y` in bytes: {}", std::mem::size_of_val(&y));
    println!("size of `z` in bytes: {}", std::mem::size_of_val(&z));
    println!("size of `i` in bytes: {}", std::mem::size_of_val(&i));
    println!("size of `f` in bytes: {}", std::mem::size_of_val(&f));
    /*
    	size of `x` in bytes: 1
		size of `y` in bytes: 4
		size of `z` in bytes: 4
		size of `i` in bytes: 4
		size of `f` in bytes: 8
    */
}
```

## 类型推断

不仅仅会看初始化时变量的类型，还会根据使用情况去推断类型，如下例子中根据 `push` 方法推断`Vec<T>`的类型`T`：

```rust
fn main() {
    // Because of the annotation, the compiler knows that `elem` has type u8.
    let elem = 5u8;

    // Create an empty vector (a growable array).
    let mut vec = Vec::new();
    // At this point the compiler doesn't know the exact type of `vec`, it
    // just knows that it's a vector of something (`Vec<_>`).

    // Insert `elem` in the vector.
    vec.push(elem);
    // Aha! Now the compiler knows that `vec` is a vector of `u8`s (`Vec<u8>`)
    // TODO ^ Try commenting out the `vec.push(elem)` line

    println!("{:?}", vec);
    /* [5] */
}
```

## 别名

与 C 语言类似，rust 中的类型也可以起别名，但语法有差别：

```rust
// `NanoSecond`, `Inch`, and `U64` are new names for `u64`.
type NanoSecond = u64;
type Inch = u64;
type U64 = u64;

fn main() {
    // `NanoSecond` = `Inch` = `U64` = `u64`.
    let nanoseconds: NanoSecond = 5 as U64;
    let inches: Inch = 2 as U64;

    // Note that type aliases *don't* provide any extra type safety, because
    // aliases are *not* new types
    println!("{} nanoseconds + {} inches = {} unit?",
             nanoseconds,
             inches,
             nanoseconds + inches);
    /* 
	    5 nanoseconds + 2 inches = 7 unit?
    */
}
```

主要用途是减少公式化的应用，如将 `Result<T, IoError>`  的别名设置为`IoResult<T>` ；

