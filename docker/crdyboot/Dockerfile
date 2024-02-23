# Copyright 2023 The ChromiumOS Authors
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y \
    bzip2 \
    clang \
    curl \
    efitools \
    gcc \
    gdisk \
    git \
    gnupg2 \
    libnss3-dev \
    libssl-dev \
    make \
    ovmf \
    ovmf-ia32 \
    pkg-config \
    qemu-system-x86 \
    sbsigntool \
    swtpm \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

# Install rustup in order to install Rust toolchains.
#
# We cannot use the version of rust that Debian ships as an apt package
# both because it is not new enough, and because crdyboot currently
# requires at least one nightly-only feature.
RUN mkdir --mode=a+rwx /cargo /rustup
ENV CARGO_HOME=/cargo
ENV RUSTUP_HOME=/rustup
RUN curl --fail --location --output /tmp/rustup-init \
    https://static.rust-lang.org/rustup/archive/1.26.0/x86_64-unknown-linux-gnu/rustup-init
ENV RUSTUP_HASH=0b2f6c8f85a3d02fde2efc0ced4657869d73fccfce59defb4e8d29233116e6db
RUN echo "${RUSTUP_HASH} /tmp/rustup-init" | sha256sum --check
RUN chmod +x /tmp/rustup-init
RUN /tmp/rustup-init -y --no-update-default-toolchain
ENV PATH="/cargo/bin:${PATH}"

# Install a pinned Rust toolchain, along with the necessary targets and
# components.
#
# This matches the version in crdyboot's rust-toolchain.toml.
ENV RUST_VERSION=nightly-2023-08-18
RUN rustup install "${RUST_VERSION}"
RUN rustup target add --toolchain "${RUST_VERSION}" \
    i686-unknown-uefi \
    x86_64-unknown-uefi
RUN rustup component add --toolchain "${RUST_VERSION}" miri rust-src

# Install cargo-deny into the cargo bin dir.
RUN curl --fail --location --output /tmp/cargo-deny.tar.gz \
    https://github.com/EmbarkStudios/cargo-deny/releases/download/0.14.2/cargo-deny-0.14.2-x86_64-unknown-linux-musl.tar.gz
ENV CDENY_HASH=5a4913ae3ce1298bd96d29b794ed245b0394f5ec0e2802f19d41fedc70bb5c3c
RUN echo "${CDENY_HASH} /tmp/cargo-deny.tar.gz" | sha256sum --check
RUN tar -C /usr/bin -xvf /tmp/cargo-deny.tar.gz \
    cargo-deny-0.14.2-x86_64-unknown-linux-musl/cargo-deny
