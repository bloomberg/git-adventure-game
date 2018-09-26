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

# Check that everything is in order
DIFFERENCE=$(git diff HEAD~3..HEAD~2)
echo ${DIFFERENCE} | grep '+++ b/cauldron/lacewing-flies' > /dev/null 2>&1 || exit 1

DIFFERENCE=$(git diff HEAD~4..HEAD~3)
echo ${DIFFERENCE} | grep '+++ b/cauldron/leeches' > /dev/null 2>&1 || exit 1

# And that the bad ingredient got filtered out.
DIFFERENCE=$(git diff HEAD~6..HEAD)
echo ${DIFFERENCE} | grep '+++ b/cauldron/crushed-lacewings'  > /dev/null 2>&1 && exit 1

# We made it here -> rebase happended as intended!
exit 0
