use std::path::PathBuf;

#[derive(clap::Parser, Debug)]
pub struct Args {
    pub user_data_dir: PathBuf,
    pub rime_data_dir: PathBuf,
    pub staging_dir: Option<PathBuf>,
}