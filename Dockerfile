## Image built from https://github.com/rime/librime
#FROM librime:latest
#RUN ninja install

FROM debian:12.1

COPY / /rime-config
WORKDIR /rime-config

RUN apt update && \
    apt install -y curl librime-dev && \
    # Rust bindgen requires libclang
    apt install -y clang

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > install && \
    chmod +x install && \
    ./install --profile minimal --default-toolchain nightly-2023-10-02 -y

# Build and run tests
RUN . ~/.cargo/env && \
    RIME_LIB_DIR=/usr/lib/x86_64-linux-gnu \
    cargo build -r --manifest-path=/rime-config/tools-rs/Cargo.toml && \
    tools-rs/target/release/tools-rs . shared-minimal ci-build
