use std::io::{stdin, Read};
use obfuscate_dict::decode;

fn main() {
    let mut text = String::new();
    stdin().read_to_string(&mut text).unwrap();
    println!("{}", decode(&text));
}
