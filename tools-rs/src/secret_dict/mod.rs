use once_cell::sync::Lazy;
use std::collections::{HashMap, HashSet};
use std::iter::Iterator;
use std::path::Path;

pub static RIME_ROOT: Lazy<&Path> =
    Lazy::new(|| Path::new(env!("CARGO_MANIFEST_DIR")).parent().unwrap());

pub const PUA_START: u32 = 0x10abcd;
pub static PINYIN_INITIAL_TABLE: Lazy<[char; 26]> = Lazy::new(|| {
    "ⒶⒷⒸⒹⒺⒻⒼⒽⒾⒿⓀⓁⓂⓃⓄⓅⓆⓇⓈⓉⓊⓋⓌⓍⓎⓏ"
        .chars()
        .collect::<Vec<_>>()
        .try_into()
        .unwrap()
});

pub static PINYIN_INITIAL_SET: Lazy<HashSet<char>> =
    Lazy::new(|| PINYIN_INITIAL_TABLE.iter().copied().collect());

pub static CHARS_TABLE_TXT: &str = include_str!("table.txt");

pub static CHARS_ARR: Lazy<Vec<char>> = Lazy::new(|| {
    CHARS_TABLE_TXT
        .lines()
        .map(|x| x.chars().next().unwrap())
        .collect()
});

pub static CHARS_MAP: Lazy<HashMap<char, u16>> = Lazy::new(|| {
    CHARS_ARR
        .iter()
        .enumerate()
        .map(|(i, &c)| (c, i as u16))
        .collect()
});

pub fn encode_pua(c: char) -> Option<char> {
    let &index = CHARS_MAP.get(&c)?;
    char::from_u32(PUA_START + index as u32)
}

pub fn decode_pua(pua: char) -> Option<char> {
    Some(*CHARS_ARR.get((pua as u32 - PUA_START) as usize)?)
}

pub fn decode(text: &str) -> String {
    let mut decoded = String::new();
    let mut escape_mode = false;
    for c in text.chars() {
        if PINYIN_INITIAL_SET.contains(&c) {
            escape_mode = true;
            continue;
        } else if escape_mode {
            let decoded_char = decode_pua(c).expect("failed to decode");
            decoded.push(decoded_char);
            escape_mode = false;
            continue;
        } else {
            decoded.push(c);
        }
    }
    decoded
}
