// https://doc.rust-lang.org/std/process/struct.Command.html
// spaced-repetition date: may 2, 2020

use std::process::Command;

let output = Command::new("cmd")
            .args(&["/C", "echo hello"])
            .output()
            .expect("cmd failed to execute process")
let hello = output.stdout;
let str_hello = String::from_utf8_lossy(hello).to_string();
println!("{}",str_hello);
// ============================================================================

