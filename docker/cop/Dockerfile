# Copyright 2023 The ChromiumOS Authors
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

FROM debian:bookworm-slim
RUN apt-get update

#Install cloudbuildhelper
COPY cloudbuildhelper.sh /tmp/
RUN bash /tmp/cloudbuildhelper.sh

#Install running dependencies
RUN apt-get install -y docker.io
