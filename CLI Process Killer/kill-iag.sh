#!/bin/bash

UNAME=$(uname)
if test "$UNAME" = "FreeBSD"; then
    OS=freebsd
elif test "$UNAME" = "Linux"; then
    OS=linux
elif test "$UNAME" = "Darwin"; then
    OS=macos
fi

tmpfile=$(mktemp processes.tmp.XXXXXX)
ps -aux | sed -E 's/ +/,/g' > "$tmpfile"
pids=$(awk -F "\"*,\"*" '/iagon/{print $2}' "$tmpfile")
rm "$tmpfile"
if test "$pids" = ""; then
    echo "No Iagon processes found"
else
    echo "Active Iagon Process IDs:"
    echo "$pids"
    echo ""
    echo "Would you like to kill these processes?"
    echo "Please input 1 for Yes or 2 for No:"
    echo ""
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) echo "" && echo "Killing Iagon processes now..." && echo ""; break;;
            No ) echo "" && echo "Okay, bye!" && exit;;
        esac
    done
    for pid in $pids; do
        kill "$pid"
    done
    echo "Iagon processes killed"
fi
