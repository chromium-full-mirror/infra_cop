# Copyright 2023 The ChromiumOS Authors
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

FROM archlinux as base
RUN pacman -Sy archlinux-keyring --noconfirm --cachedir=/paccache \
  && pacman -Su --needed --noconfirm --cachedir=/paccache \
  base-devel \
  bazel \
  git \
  go \
  vim \
  alsa-lib \
  sbc \
  speexdsp \
  clang \
  ladspa \
  gtest \
  rust \
  python \
  lld \
  llvm \
  protobuf \
  rsync \
  && rm -rf /paccache

FROM archlinux as kythe
RUN \
  mkdir -p /opt/kythe \
  && curl -OL https://github.com/kythe/kythe/releases/download/v0.0.60/kythe-v0.0.60.tar.gz \
  && echo '8fe1aeb8f514306f26e233077e1156dbe353ef2afa72c37866bebb680b52a10d	kythe-v0.0.60.tar.gz' | sha256sum -c - \
  && tar --strip-components=1 --no-same-owner --directory=/opt/kythe -xzf kythe-v0.0.60.tar.gz

FROM base as bazel-cache
RUN git clone https://chromium.googlesource.com/chromiumos/third_party/adhd
RUN cd adhd && bazel build --nobuild --config=local-clang //...

FROM base as builder

# TODO(b/277140711): Use build_kzip.bash from within the adhd git repository.
COPY build_kzip.bash compdb_fixup.py /

COPY bazelrc /etc/bazel.bazelrc
COPY --from=kythe /opt/kythe /opt/kythe
RUN echo 'export PATH=/root/.cargo/bin:$PATH' >> /root/.bashrc
COPY --from=bazel-cache /root/.cache/bazel /root/.cache/bazel
