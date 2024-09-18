use std::io::{stdin, Read};
use tools_rs::secret_dict::decode;

fn main() {
    let mut text = String::new();
    stdin().read_to_string(&mut text).unwrap();
    println!("{}", decode(&text));
}
