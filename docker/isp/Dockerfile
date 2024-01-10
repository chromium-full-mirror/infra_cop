# Copyright 2023 The ChromiumOS Authors
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

FROM debian:trixie-slim
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y libc6 # Temporary hack
#Install virtme-ng
RUN apt-get install -y virtme-ng virtme-ng qemu-system-x86 busybox-static \
                       udev kmod
RUN mkdir -p /lib/modules
#Kernel build
RUN apt-get install -y make gcc flex bison sparse autoconf libtool libelf-dev \
                       libssl-dev bc git
