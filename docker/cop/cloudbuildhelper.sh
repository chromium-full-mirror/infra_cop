#!/bin/bash
# Copyright 2023 The ChromiumOS Authors
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

set -ev

#Install cloudbuildhelper
apt-get -y install git golang
cd /tmp && git clone https://chromium.googlesource.com/infra/infra
cd /tmp/infra/go/src/infra || exit
go mod edit -dropreplace=go.chromium.org/chromiumos/config/go -dropreplace=go.chromium.org/chromiumos/infra/proto/go -dropreplace=go.chromium.org/luci && go get infra/cmd/cloudbuildhelper
go build infra/cmd/cloudbuildhelper
cp cloudbuildhelper /usr/bin

#Cleanup
cd /
rm -rf /tmp/infra "${HOME}"/go
apt-get remove -y golang && apt-get autoremove -y --purge
