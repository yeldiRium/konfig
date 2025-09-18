#!/usr/bin/env bats

# Copyright 2019 Cornelius Weig
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# bats setup function
setup() {
  export KONFIG_TEST_DIR="$(mktemp -d)"
  export KUBECONFIG="${KONFIG_TEST_DIR}/config"
}

# bats teardown function
teardown() {
  rm -rf "$KONFIG_TEST_DIR"
}

use_config() {
  cp "$BATS_TEST_DIRNAME/testdata/$1" "$KUBECONFIG"
}

check_kubeconfig() {
  diff -U3 "${1}" "${KONFIG_TEST_DIR}/config" && echo 'same' || echo 'different'
}

check_fixture() {
  diff -U3 "${1}" <(echo "${2}") && echo 'same' || echo 'different'
}
