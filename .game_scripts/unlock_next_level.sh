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
GREEN='\033[0;32m'
NO_COLOR='\033[0m'

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
CURRENT_LINE=$(grep -n "${CURRENT_BRANCH}" .game_info/branches.txt | cut -d : -f 1)
NEXT_BRANCH=$(head -$((1 + CURRENT_LINE)) .game_info/branches.txt | tail -1)
END=$(tail -1 .game_info/branches.txt)

git branch "${NEXT_BRANCH}" "origin/${NEXT_BRANCH}" >/dev/null 2>&1


if [[ "${NEXT_BRANCH}" = "${END}" ]]; then
    if [[ "${OSTYPE}" == "msys" ]]; then
        # mintty does not start a new window from Git CMD.  Not sure why yet.
        /usr/bin/mintty -w full -o TERM=xterm-256color -o Scrollbar=None -e /bin/bash -c ./.game_data/outtro.sh
    else
        ./.game_data/outtro.sh
    fi
    printf "${GREEN}Congratulations! You completed the git adventure game!${NO_COLOR}\n"
else
    if [[ "$1" == "skiplevel" ]]; then
        printf "${GREEN}Alright then traveler.  A new level has been unlocked: ${NEXT_BRANCH} ${NO_COLOR}\n"
        printf "${GREEN}Use 'git checkout ${NEXT_BRANCH}' to enter the next level. ${NO_COLOR}\n"
    else
        printf "${GREEN}Well done.  A new level has been unlocked: ${NEXT_BRANCH} ${NO_COLOR}\n"
        printf "${GREEN}Use 'git checkout ${NEXT_BRANCH}' to enter the next level. ${NO_COLOR}\n"
    fi
fi

