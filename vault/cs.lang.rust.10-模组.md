---
id: uyemzn3ugyxvg9rx69rx47l
title: '模组'
desc: ''
updated: 1673103722061
created: 1673103722061
---

❗默认的可见性都是`private`


## 模组可见性

在模组中默认的可见性是`private`，但这可以被`pub`标识符更改，只有`pub`的 *item* 才是可以被模组外面的访问。可以通过不同的标记实现不同的作用域。

模组`my_mod`：

```rust
// A module named `my_mod`
mod my_mod {
    // 不能访问
    // Items in modules default to private visibility.
    fn private_function() {
        println!("called `my_mod::private_function()`");
    }

    // Use the `pub` modifier to override default visibility.
    pub fn function() {
        println!("called `my_mod::function()`");
    }

    // Items can access other items in the same module,
    // even when private.
    pub fn indirect_access() {
        print!("called `my_mod::indirect_access()`, that\n> ");
        private_function();
    }

    // 模组中的模组 `nested`
    // Modules can also be nested
    pub mod nested {
        pub fn function() {
            println!("called `my_mod::nested::function()`");
        }

        // 此处并不能通过 `my_mod::nested::private_function()` 访问
        #[allow(dead_code)]
        fn private_function() {
            println!("called `my_mod::nested::private_function()`");
        }

        // 不能运行，因为 `pub(in crate::my_mod)` 指定只在 my_mod 
        // 中是 pub 的，超出了就不能访问
        // Functions declared using `pub(in path)` syntax are only visible
        // within the given path. `path` must be a parent or ancestor module
        pub(in crate::my_mod) fn public_function_in_my_mod() {
            print!("called `my_mod::nested::public_function_in_my_mod()`, that\n> ");
            public_function_in_nested();
        }

        // 只在本模组 `nested` 中是 pub 的
        // Functions declared using `pub(self)` syntax are only visible within
        // the current module, which is the same as leaving them private
        pub(self) fn public_function_in_nested() {
            println!("called `my_mod::nested::public_function_in_nested()`");
        }

        // 只在父亲 `my_mod` 中是 pub 的
        // Functions declared using `pub(super)` syntax are only visible within
        // the parent module
        pub(super) fn public_function_in_super_mod() {
            println!("called `my_mod::nested::public_function_in_super_mod()`");
        }
    }

    pub fn call_public_function_in_my_mod() {
        print!("called `my_mod::call_public_function_in_my_mod()`, that\n> ");
        nested::public_function_in_my_mod();
        print!("> ");
        nested::public_function_in_super_mod();
    }

    // pub(crate) makes functions visible only within the current crate
    pub(crate) fn public_function_in_crate() {
        println!("called `my_mod::public_function_in_crate()`");
    }

    // Nested modules follow the same rules for visibility
    mod private_nested {
        #[allow(dead_code)]
        pub fn function() {
            println!("called `my_mod::private_nested::function()`");
        }

        // Private parent items will still restrict the visibility of a child item,
        // even if it is declared as visible within a bigger scope.
        #[allow(dead_code)]
        pub(crate) fn restricted_function() {
            println!("called `my_mod::private_nested::restricted_function()`");
        }
    }
}
```

- 调用用例，被注释的就是不能运行的，原因如上

```rust
fn function() {
    println!("called `function()`");
}

fn main() {
    // Modules allow disambiguation between items that have the same name.
    function();
    my_mod::function();

    // Public items, including those inside nested modules, can be
    // accessed from outside the parent module.
    my_mod::indirect_access();
    my_mod::nested::function();
    my_mod::call_public_function_in_my_mod();

    // pub(crate) items can be called from anywhere in the same crate
    my_mod::public_function_in_crate();

    // pub(in path) items can only be called from within the module specified
    // Error! function `public_function_in_my_mod` is private
    //my_mod::nested::public_function_in_my_mod();
    // TODO ^ Try uncommenting this line

    // Private items of a module cannot be directly accessed, even if
    // nested in a public module:

    // Error! `private_function` is private
    //my_mod::private_function();
    // TODO ^ Try uncommenting this line

    // Error! `private_function` is private
    //my_mod::nested::private_function();
    // TODO ^ Try uncommenting this line

    // Error! `private_nested` is a private module
    //my_mod::private_nested::function();
    // TODO ^ Try uncommenting this line

    // Error! `private_nested` is a private module
    //my_mod::private_nested::restricted_function();
    // TODO ^ Try uncommenting this line
}

```

## 结构体

```rust
mod my {
    // A public struct with a public field of generic type `T`
    pub struct OpenBox<T> {
        pub contents: T,
    }

    // A public struct with a private field of generic type `T`
    pub struct ClosedBox<T> {
        contents: T,
    }

    impl<T> ClosedBox<T> {
        // A public constructor method
        pub fn new(contents: T) -> ClosedBox<T> {
            ClosedBox {
                contents: contents,
            }
        }
    }
}

fn main() {
    // Public structs with public fields can be constructed as usual
    let open_box = my::OpenBox { contents: "public information" };

    // and their fields can be normally accessed.
    println!("The open box contains: {}", open_box.contents);

    // Public structs with private fields cannot be constructed using field names.
    // Error! `ClosedBox` has private fields
    //let closed_box = my::ClosedBox { contents: "classified information" };
    // TODO ^ Try uncommenting this line

    // However, structs with private fields can be created using
    // public constructors
    let _closed_box = my::ClosedBox::new("classified information");

    // and the private fields of a public struct cannot be accessed.
    // Error! The `contents` field is private
    //println!("The closed box contains: {}", _closed_box.contents);
    // TODO ^ Try uncommenting this line
}

```

## use

`use` 用作绑定`path`到一个变量。如：

```rust
use crate::deeply::nested::{
    my_first_function,
    my_second_function,
    AndATraitType
};

fn main() {
    my_first_function();
}
```

也可以为import绑定一个不同的名字

```rust
// Bind the `deeply::nested::function` path to `other_function`.
use deeply::nested::function as other_function;

fn function() {
    println!("called `function()`");
}

mod deeply {
    pub mod nested {
        pub fn function() {
            println!("called `deeply::nested::function()`");
        }
    }
}

fn main() {
    // Easier access to `deeply::nested::function`
    other_function();

    println!("Entering block");
    {
        // This is equivalent to `use deeply::nested::function as function`.
        // This `function()` will shadow the outer one.
        use crate::deeply::nested::function;

        // `use` bindings have a local scope. In this case, the
        // shadowing of `function()` is only in this block.
        function();

        println!("Leaving block");
    }

    function();
}
```

## super and self

用于访问路径的操作。

```rust
fn function() {
    println!("called `function()`");
}

mod cool {
    pub fn function() {
        println!("called `cool::function()`");
    }
}

mod my {
    fn function() {
        println!("called `my::function()`");
    }
    
    mod cool {
        pub fn function() {
            println!("called `my::cool::function()`");
        }
    }
    
    pub fn indirect_call() {
        // Let's access all the functions named `function` from this scope!
        print!("called `my::indirect_call()`, that\n> ");
        
        // The `self` keyword refers to the current module scope - in this case `my`.
        // Calling `self::function()` and calling `function()` directly both give
        // the same result, because they refer to the same function.
        self::function();
        function();
        
        // We can also use `self` to access another module inside `my`:
        self::cool::function();
        
        // The `super` keyword refers to the parent scope (outside the `my` module).
        super::function();
        
        // This will bind to the `cool::function` in the *crate* scope.
        // In this case the crate scope is the outermost scope.
        {
            use crate::cool::function as root_function;
            root_function();
        }
    }
}

fn main() {
    my::indirect_call();
}
```

## 模组文件目录映射

假设有这样的目录：

```bash
$ tree .
.
├── my
│   ├── inaccessible.rs
│   └── nested.rs
├── my.rs
└── split.rs
```

我们的目标是在`split.rs`中使用`my.rs`中定义的`my`模组：

- 在`split.rs`：

```rust
// This declaration will look for a file named `my.rs` and will
// insert its contents inside a module named `my` under this scope
// 这个声明会在当前目录中寻找 my.rs 并且将其中
// 的内容插入以 my 命名的模组中
mod my;

fn function() {
    println!("called `function()`");
}

fn main() {
    my::function();

    function();

    my::indirect_access();

    my::nested::function();
}
```

- `my.rs`

```rust
// Similarly `mod inaccessible` and `mod nested` will locate the `nested.rs`
// and `inaccessible.rs` files and insert them here under their respective
// modules
// 导入 inaccessible 和 nested 其中对外
// 暴露 nested
mod inaccessible;
pub mod nested;

pub fn function() {
    println!("called `my::function()`");
}

fn private_function() {
    println!("called `my::private_function()`");
}

pub fn indirect_access() {
    print!("called `my::indirect_access()`, that\n> ");

    private_function();
}
```

- `my/nested.rs`

```rust
pub fn function() {
    println!("called `my::nested::function()`");
}

#[allow(dead_code)]
fn private_function() {
    println!("called `my::nested::private_function()`");
}
```

- `my/inaccessible.rs`

```rust
#[allow(dead_code)]
pub fn public_function() {
    println!("called `my::inaccessible::public_function()`");
}
```

