# Copyright 2023 The ChromiumOS Authors
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

FROM archlinux AS base
RUN mkdir /paccache \
  && pacman-key --init \
  && pacman -Sy archlinux-keyring --noconfirm --cachedir=/paccache \
  && pacman -Su --needed --noconfirm --cachedir=/paccache \
  base-devel \
  docker \
  git \
  go \
  vim \
  alsa-lib \
  sbc \
  speexdsp \
  clang \
  gtest \
  rust \
  python \
  lld \
  llvm \
  protobuf \
  rsync \
  && rm -rf /paccache
RUN curl -L https://github.com/bazelbuild/bazelisk/releases/download/v1.19.0/bazelisk-linux-amd64 -o /usr/bin/bazel \
  && echo 'd28b588ac0916abd6bf02defb5433f6eddf7cba35ffa808eabb65a44aab226f7 /usr/bin/bazel' | sha256sum -c - \
  && chmod 755 /usr/bin/bazel

FROM archlinux AS kythe
RUN \
  mkdir -p /opt/kythe \
  && curl -OL https://github.com/kythe/kythe/releases/download/v0.0.76/kythe-v0.0.76.tar.gz \
  && echo 'eea430f7563db805c99e4d1a427ca60d7aef01cec7669986529cfe2c26296356	kythe-v0.0.76.tar.gz' | sha256sum -c - \
  && tar --strip-components=1 --no-same-owner --directory=/opt/kythe -xzf kythe-v0.0.76.tar.gz

FROM base AS builder

COPY bazelrc /etc/bazel.bazelrc
COPY --from=kythe /opt/kythe /opt/kythe
RUN echo 'export PATH=/root/.cargo/bin:$PATH' >> /root/.bashrc
