#!/bin/bash
#
# Copyright 2018 Bloomberg Finance L.P.
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
#
die() {
    echo "ERROR: $1" > error.log
    exit 1
}

target_folder=$(cat .game_data/state/spare_folder)/water_land
if [[ -d "${target_folder}" ]]; then
    rm -r "${target_folder}"
fi
cp -r . "${target_folder}"

(
    cd "${target_folder}" || die "Could not change to target folder"

    rm .git/hooks/*
    git checkout -b rain_clouds origin/base_level

    echo 1 > talisman
    git add talisman
    git commit -m "Let it rain!"
)
