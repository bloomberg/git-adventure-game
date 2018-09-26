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

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
GREEN='\033[0;32m'
RED='\033[0;31m'
NO_COLOR='\033[0m'

getNumberOfCorrectSteps() {

    if [ -e ".game_state/${CURRENT_BRANCH}/correct_steps_counter" ]; then
        echo $(wc -l .game_state/${CURRENT_BRANCH}/correct_steps_counter | cut -d ' ' -f 1)
    else
        echo 0
    fi

}

incrementNumberOfCorrectSteps() {
    mkdir -p .game_state/${CURRENT_BRANCH}
    echo "correct_step" >> .game_state/${CURRENT_BRANCH}/correct_steps_counter
}

resetStepsCounter() {
    : > .game_state/${CURRENT_BRANCH}/correct_steps_counter
}


commitAliasIsSetup(){
    LIST_ALL_ALIASES=$(git config --get-regexp '^alias\.')
    # Tolerate various formats, e.g.
    #
    # c=commit
    # c =commit
    # c = 'commit'
    # c = "commit"
    echo "${LIST_ALL_ALIASES}" |  grep -P "alias.c\s*[\"\']?commit[\"\']?" > /dev/null 2>&1 
}

stepZeroEval() {
    # Check if unicorn has been added
    DIFFERENCE=$(git diff --staged)
    echo ${DIFFERENCE} | grep '+++ b/unicorn' > /dev/null 2>&1 || exit 1
    
    printf "${GREEN}Perfect! Now, try to take a picture of the ghost in the dungeon${NO_COLOR}\n"
    incrementNumberOfCorrectSteps
    exit 2
}

stepOneEval() {
    # Check if ghost has been added
    DIFFERENCE=$(git diff --staged)
    echo ${DIFFERENCE} | grep '+++ b/dungeon/ghost' > /dev/null 2>&1 || exit 1
    
    # The ghost has been added - check if the alias is there
    commitAliasIsSetup
    STATUS=$?
    if [ ${STATUS} -eq 0 ]; then
        resetStepsCounter
        exit 0
    elif [ ${STATUS} -eq 1 ]; then
        printf "${RED}You were too slow - the ghost disappeared :( Try to setup an alias that allows you to do: 'git c' instead of 'git commit' ${NO_COLOR}\n"
        exit 1
    fi
    
}

if [ $(getNumberOfCorrectSteps) -eq 0 ]; then
    
    stepZeroEval

elif [ $(getNumberOfCorrectSteps) -eq 1 ]; then

    stepOneEval
fi
