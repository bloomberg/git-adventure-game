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

# Two elves are working on the castle.  The work of the first elf is
# contained in the level branch itself whereas the work of the second
# elf is contained in a branch that has the same name as the level
# branch plus the "_bushy" suffix.
# Create a local reference so that the user see the additional branch
# when running 'git branch'
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
git branch -D "${CURRENT_BRANCH}_bushy" >/dev/null 2>&1
git branch "${CURRENT_BRANCH}_bushy" "origin/${CURRENT_BRANCH}_bushy" >/dev/null 2>&1
