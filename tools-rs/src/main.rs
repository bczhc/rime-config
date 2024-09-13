use rime_api::{create_session, DeployResult, full_deploy_and_wait, initialize, setup, Traits};
use tools_rs::Args;
use clap::Parser;

fn main() {
    let args = Args::parse();

    let mut traits = Traits::new();
    traits.set_shared_data_dir(args.rime_data_dir.to_str().unwrap());
    traits.set_user_data_dir(args.user_data_dir.to_str().unwrap());
    traits.set_distribution_name("Rime");
    traits.set_distribution_code_name("Rime");
    traits.set_distribution_version("0.0.0");
    if let Some(d) = args.staging_dir {
        traits.set_staging_dir(d.to_str().unwrap());
    }

    setup(&mut traits);
    initialize(&mut traits);

    let deploy_result = full_deploy_and_wait();
    assert_eq!(deploy_result, DeployResult::Success);

    let session = create_session().unwrap();
    session.select_schema("092wubi").unwrap();

    session.simulate_key_sequence("v;").unwrap();
    assert_eq!(session.commit().unwrap().text(), "好");
}
