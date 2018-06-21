#!/usr/bin/env bash

set -e

if [ $# -ne 1 ]; then
    >&2 echo "too many arguments. expected 1, got "$#
    exit 255
fi

if [ "$WILDCARD" = "1" ]; then
    SEARCH="$1-*"
else
    SEARCH="$1"
fi

PATH_LIST=$(echo $PATH | sed 's/:/ /g')
for p in $PATH_LIST; do
    found="$(find $p -name "$SEARCH")"
    if [ $? -ne 0 ]; then
        continue
    fi

    for t in $found; do
        if ls $t > /dev/null 2>&1; then
            echo $t
            exit 0
        fi
    done
done

>&2 echo "could not find "$1" tool in PATH"
exit 255
