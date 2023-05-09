# Copyright 2023 The ChromiumOS Authors
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

FROM debian:bookworm-slim
#checkpatch
RUN apt-get update && apt-get install -y perl-modules git && apt-get clean
#seanbot
COPY kickstart-git.patch /tmp/
RUN apt-get install -y python3 python3-requests python3-fuzzywuzzy wget && \
    apt-get clean
RUN cd /usr/share/ && \
    git clone https://github.com/atseanpaul/review-o-matic.git && \
    cd review-o-matic && patch -p1 < /tmp/kickstart-git.patch
