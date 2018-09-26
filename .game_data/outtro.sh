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

##
## Outtro sequence for the git adventure game.  This requires a 256 color
## terminal.
##

tput init     # Setup the terminal
tput civis    # Hide the cursur

width() {
    # Returns the number of columns available in the terminal screen
    tput cols
}

height() {
    # Returns the number of rows available in the terminal screen
    tput lines
}

center_x() {
    local x=$(width)
    local mid=$(( x / 2 ))
    echo $mid
}

center_y() {
    local y=$(height)
    local mid=$(( y / 2 ))
    echo $mid
}

set_cursor_pos() {
    # Takes the cursor position as X and Y coordinate
    local x=$1
    local y=$2
    tput cup "$y" "$x"
}

color_from_rgb() {
    # Set the color from rgb values.  Values for r, g and b may be in the
    # range of 0..5
    local r="$1"
    local g="$2"
    local b="$3"

    printf '%d' "$(( (r * 36) + (g * 6) + b + 16 ))"
}

set_fg_rgb() {
    tput setaf "$(color_from_rgb "$1" "$2" "$3")"
}

set_bg_rgb() {
    tput setab "$(color_from_hex "$1")"
}

draw_circle() {
    # draw circle, with parameters:
    # x, y and r
    local x=$1
    local y=$2
    local c=$3
    local r=26

    declare -a arr=('                  ooo OOO OOO ooo                      '
                    '               oOOOOOOOOOOOOOOOOOOOOOo                 '
                    '           oOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo             '
                    '        oOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo          '
                    '      oOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo        '
                    '    oOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo      '
                    '   oOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo     '
                    '  oOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo    '
                    ' oOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo   '
                    ' oOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo   '
                    ' oOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo   '
                    ' oOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo   '
                    ' oOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo   '
                    '  oOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo    '
                    '   oOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo     '
                    '    oOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo      '
                    '      oOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo        '
                    '        oOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo          '
                    '           oOOOOOOOOOOOOOOOOOOOOOOOOOOOOOo             '
                    '               oOOOOOOOOOOOOOOOOOOOOOo                 '
                    '                   ooo OOO OOO ooo                     ')


    local cx=$(( x - r ))
    local cy=$(( y - r ))

    local i=0

    for line in "${arr[@]}"; do
         i=$(( i + 1 ))
         if (( i >= c )); then
             break
         fi

         set_cursor_pos "$cx" "$cy"
         printf '%s' "${line}"
         cy=$(( cy + 1 ))
    done
}

draw_tree() {
    local x=$1
    local y=$2
    local gs=$3

    declare -a arr=('^'
                    '//|\\'
                    '/W/W\W\'
                    '//W|\\\W\'
                    '//VW|\W\\'
                    '__////WW\\\\\__'
                    '///W\/V/\\VW\\\\\'
                    '\\//W/lWVW~W/WW/W\\')
    declare -a arn=( 11 9 8 6 7 4 3 2 )
    declare -a ars=('WWW'
                    'WWW')

    set_fg_rgb 1 "$gs" 0
    off=0
    for line in "${arr[@]}"; do
         set_cursor_pos $(( x + arn[off] )) "$y"
         off=$(( off + 1 ))
         printf '%s' "${line}"
         y=$(( y + 1 ))
    done
    set_fg_rgb 3 1 1
    for line in "${ars[@]}"; do
         set_cursor_pos $(( x + 9 )) "$y"
         printf '%s' "${line}"
         y=$(( y + 1 ))
    done
}

draw_grass() {
    local x=$1
    local y=$2
    local g=$3

    declare -a arr=('                              o                '
                    '                             //W               '
                    '                                               '
                    '                 o                             '
                    '                \//\                           '
                    '     o                               //\\\\    '
                    '   \\/              /\/\/\                     '
                    '                                               '
                    '                         //\\\/\/\             '
                    '                                               '
                    '     \\\\///\       o                          '
                    '                  \\\\          ///            ')

    set_fg_rgb 0 4 0
    for line in "${arr[@]}"; do
         set_cursor_pos "$x" "$y"
         printf '%s' "${line}"
         y=$(( y + 1 ))
    done
}

print_message() {
    local x=$1
    local y=$2
    local g=$3

    declare -a arr=('As the first rays of sun peered over the forest'
                    'your exhausted bones creak forward....                 '
                    ''
                    'You have done a great job traveler!  The ghosts'
                    'have been banished and peace has once again'
                    'returned to the forest.'
                    ''
                    'The quiet whisper blowing through the trees: The'
                    'birth of a Git master...')

    set_fg_rgb 0 "$g" "$g"
    for line in "${arr[@]}"; do
         set_cursor_pos "$x" "$y"
         printf '%s' "${line}"
         y=$(( y + 1 ))
    done

}

draw_bird() {
    local x=$1
    local y=$2
    set_fg_rgb 1 1 1
    set_cursor_pos "$x" "$y"
    printf '**'
    set_cursor_pos $(( x - 1 )) $(( y + 1 ))
    printf '*'
    set_cursor_pos $(( x + 2 )) $(( y + 1 ))
    printf '*'
    set_cursor_pos $(( x + 4 )) $(( y ))
    printf '**'
    set_cursor_pos $(( x + 5 )) $(( y + 1 ))
    printf '**'
    set_cursor_pos $(( x + 6 )) $(( y + 2 ))
    printf '**'
}

draw_rays() {
    local x=$1
    local y=$2
    set_fg_rgb 4 2 0
    set_cursor_pos "$x" "$y"
    printf '**'
    set_cursor_pos $(( x + 1 )) $(( y + 1 ))
    printf '**'
    set_cursor_pos $(( x + 2 )) $(( y + 2 ))
    printf '**'
    set_cursor_pos $(( x + 3 )) $(( y + 3 ))
    printf '**'
    set_cursor_pos $(( x + 4 )) $(( y + 4 ))
    printf '**'
    set_cursor_pos $(( x + 5 )) $(( y + 5 ))
    printf '**'

    set_cursor_pos $(( x + 21 )) $(( y + 1 ))
    printf '**'
    set_cursor_pos $(( x + 20 )) $(( y + 2 ))
    printf '**'
    set_cursor_pos $(( x + 19 )) $(( y + 3 ))
    printf '**'
    set_cursor_pos $(( x + 18 )) $(( y + 4 ))
    printf '**'
    set_cursor_pos $(( x + 17 )) $(( y + 5 ))
    printf '**'

    set_cursor_pos $(( x - 15 )) $(( y + 5 ))
    printf '***'
    set_cursor_pos $(( x - 13 )) $(( y + 6 ))
    printf '***'
    set_cursor_pos $(( x - 11 )) $(( y + 7 ))
    printf '***'
    set_cursor_pos $(( x - 9 )) $(( y + 8 ))
    printf '***'
    set_cursor_pos $(( x - 7 )) $(( y + 9 ))
    printf '***'

    set_cursor_pos $(( x + 43 )) $(( y + 5 ))
    printf '***'
    set_cursor_pos $(( x + 41 )) $(( y + 6 ))
    printf '***'
    set_cursor_pos $(( x + 39 )) $(( y + 7 ))
    printf '***'
    set_cursor_pos $(( x + 37 )) $(( y + 8 ))
    printf '***'
    set_cursor_pos $(( x + 35 )) $(( y + 9 ))
    printf '***'

}

set_fb_rgb 0 0 0       # Clear background to black
clear                  # blank the screen

cx=$(center_x)
cy=$(center_y)

r=0
g=0
b=0

for i in $(seq 1 3); do
    set_fg_rgb "$r" "$g" "$b"
    set_cursor_pos $(( cx - 23 )) $(( cy - 1 ))
    printf '_______________________________________________'
    sleep 0.2
    r=$((r + 1))
    if (( r > 5 )); then
        r=5
    fi
done

r=3
g=0
b=0
total=15

for i in $(seq 1 4); do
    set_fg_rgb "$r" "$g" "$b"
    draw_circle cx $(( cy + total + 11 - i )) "$i"
    set_cursor_pos $(( cx - 23 )) $(( cy - 1 ))
    printf '_______________________________________________'
    sleep 0.4
    r=$((r + 1))
    if (( r > 5 )); then
        r=5
    fi

    g=$((g + 1))
    if (( g > 5 )); then
        g=5
    fi
done

r=4
g=4
b=0
for l in $(seq 5 $(( total - 5 )) ); do
    if (( l > 10 )); then
        r=5
        g=5
    fi
    set_fg_rgb "$r" "$g" "$b"
    draw_circle cx $(( cy + total + 11 - l )) "$l"
    set_cursor_pos $(( cx - 23 )) $(( cy - 1 ))
    printf '_______________________________________________'
    sleep 0.2
done

draw_grass $(( cx - 23 )) $(( cy ))

draw_tree $(( cx - 45 )) $(( cy - 8 )) 2
draw_tree $(( cx - 38 )) $(( cy - 3 )) 4
draw_tree $(( cx + 28 )) $(( cy - 13 )) 1
draw_tree $(( cx + 32 )) $(( cy - 8 )) 3
draw_tree $(( cx + 25 )) $(( cy - 1 )) 5

for l in $(seq 10 "$total"); do
    if (( l > 10 )); then
        r=5
        g=5
    fi
    set_fg_rgb "$r" "$g" "$b"
    draw_circle cx $(( cy + total + 11 - l )) "$l"
    set_cursor_pos $(( cx - 23 )) $(( cy - 1 ))
    printf '_______________________________________________'
    print_message $(( cx - 23 )) $(( cy )) $(( l - 10 ))
    sleep 0.05
done

draw_bird $(( cx - 9 )) $(( cy - 12 ))
draw_bird $(( cx - 13 )) $(( cy - 9 ))

draw_rays $(( cx - 16 )) $(( cy - 22 ))

read -r -n 1  # Wait for a keypress
tput reset    # Reset the terminal