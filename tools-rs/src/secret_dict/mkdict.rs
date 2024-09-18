use once_cell::sync::Lazy;
use std::collections::HashMap;
use std::fs::File;
use std::io::{BufRead, BufReader, Seek, SeekFrom, Write};
use std::sync::Mutex;
use anyhow::anyhow;
use tools_rs::secret_dict::{encode_pua, CHARS_MAP, PINYIN_INITIAL_TABLE, RIME_ROOT};
use unicode_normalization::UnicodeNormalization;

fn main() -> anyhow::Result<()> {
    let out_dict_path = RIME_ROOT.join("out");
    let mut out_dict = File::options()
        .write(true)
        .read(true)
        .truncate(true)
        .create(true)
        .open(out_dict_path)?;

    let mut file = File::open(RIME_ROOT.join("092wubi.dict.yaml"))?;
    let reader = BufReader::new(file.try_clone()?);
    let header = reader
        .lines()
        .map(|x| x.unwrap())
        .take_while(|x| x != "...")
        .collect::<Vec<_>>()
        .join("\n")
        + "\n...\n";

    out_dict.write_all(header.as_bytes())?;

    file.seek(SeekFrom::Start(0))?;
    let reader = BufReader::new(file);
    for x in reader
        .lines()
        .skip_while(|x| x.as_ref().unwrap() != "...")
        .skip(1)
    {
        let line = x?;
        let split = line.split('\t').collect::<Vec<_>>();
        if split.len() != 2 {
            continue;
        }
        let word = split[0];
        let code = split[1];

        let mut new_entry_buf = String::new();
        for c in word.chars() {
            if CHARS_MAP.contains_key(&c) {
                let Some(pinyin_initial) = char_pinyin_initial(c) else {
                    continue
                };
                new_entry_buf.push(pinyin_initial);
                new_entry_buf.push(encode_pua(c).unwrap());
            } else {
                new_entry_buf.push(c);
            }
        }
        writeln!(&mut out_dict, "{}\t{}", new_entry_buf, code)?;
    }
    Ok(())
}

// paste from some old code
pub fn han_char_range(codepoint: u32) -> bool {
    if (0x4e00..=0x9fff).contains(&codepoint) {
        return true;
    }
    if (0x3400..=0x4dbf).contains(&codepoint) {
        return true;
    }
    if (0x20000..=0x2a6df).contains(&codepoint) {
        return true;
    }
    if (0x2a700..=0x2b73f).contains(&codepoint) {
        return true;
    }
    if (0x2b740..=0x2b81f).contains(&codepoint) {
        return true;
    }
    if (0x2b820..=0x2ceaf).contains(&codepoint) {
        return true;
    }
    if (0xf900..=0xfaff).contains(&codepoint) {
        return true;
    }
    if (0x2f800..=0x2fa1f).contains(&codepoint) {
        return true;
    }
    false
}

static PINYIN_OPENCC_MAP: Lazy<Mutex<HashMap<char, char>>> = Lazy::new(|| {
    let file = File::open(RIME_ROOT.join("opencc/PYCharacters.txt")).unwrap();
    let reader = BufReader::new(file);
    let mut map = HashMap::new();
    for line in reader.lines().map(|x| x.unwrap()) {
        let split = line.split('\t').collect::<Vec<_>>();
        if split.len() < 2 {
            continue;
        }
        map.insert(
            split[0].chars().next().unwrap(),
            PINYIN_INITIAL_TABLE[(split[1]
                .chars()
                .nth(1)
                .unwrap()
                .nfd()
                .next()
                .unwrap()
                .to_ascii_lowercase() as u32
                - 'a' as u32) as usize],
        );
    }
    Mutex::new(map)
});

fn char_pinyin_initial(c: char) -> Option<char> {
    let guard = PINYIN_OPENCC_MAP.lock().unwrap();
    guard.get(&c).copied()
}
