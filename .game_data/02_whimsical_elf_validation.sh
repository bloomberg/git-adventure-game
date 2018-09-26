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

MD5=/usr/bin/md5sum
if [[ ! -f "${MD5}" ]] && [[ -f /sbin/md5 ]]; then
    MD5=/sbin/md5
fi

compute_hash() {
    hash=$(${MD5} < "$1" | cut -d ' ' -f 1)
    return 0
}

get_branch_name() {
    current_branch=$(git rev-parse --abbrev-ref HEAD)
}

#
# Read in the answer string from 'castle'
#
hash=""
compute_hash "castle"

current_branch=""
get_branch_name current_branch

rst=$(cat ".game_data/${current_branch}_check.txt")
if [[ $rst == $hash ]];
then
    exit 0
else
    exit 1
fi

