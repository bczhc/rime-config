use rime_api::{create_session, DeployResult, full_deploy_and_wait, initialize, setup, Traits};

fn main() {
    let rime_data_dir = "/usr/share/rime-data";
    let user_data_dir = ".";

    let mut traits = Traits::new();
    traits.set_shared_data_dir(rime_data_dir);
    traits.set_user_data_dir(user_data_dir);
    traits.set_distribution_name("Rime");
    traits.set_distribution_code_name("Rime");
    traits.set_distribution_version("0.0.0");
    traits.set_app_name("rime-tester");
    traits.set_staging_dir("./ci-build");

    setup(&mut traits);
    initialize(&mut traits);

    let deploy_result = full_deploy_and_wait();
    assert!(deploy_result == DeployResult::Success);

    let session = create_session().unwrap();
    session.select_schema("092wubi").unwrap();

    session.simulate_key_sequence("v;").unwrap();
    assert_eq!(session.commit().unwrap().text(), "好");
}
