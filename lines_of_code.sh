#!/bin/bash

#declare echo LOC_$type=46
#  282  echo ${LOC_css}
types=$(find . -type f | rev | cut -f1 --delimiter='/' | cut -f1 --delimiter='.' | rev | sort | uniq)
readarray -t types <<<"$types"
for element in ${types[*]}
do
        echo -ne "lines of $element:\t"
        find . -type f -iname "*$element" -print0 | xargs -0 wc -l | awk 'END{print}' | sed 's/^ *//g' | cut -f1 --delimiter=' '
done
