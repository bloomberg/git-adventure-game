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

# Copy the two creatures that need to be captured out of the .res folder
# so that they show up as 'untracked'.
cp .res/unicorn .
mkdir -p dungeon
cp .res/dungeon/ghost dungeon/ghost

# Cleanup any previous state (in case the level has been played before)
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
rm -f ".game_state/${CURRENT_BRANCH}/correct_steps_counter"
touch ".game_state/${CURRENT_BRANCH}/correct_steps_counter"
