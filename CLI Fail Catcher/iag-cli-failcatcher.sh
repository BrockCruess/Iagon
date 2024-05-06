# Don't forget to make this .sh file executable with "chmod +x iag-cli-failcatcher.sh"
# Set up a cronjob to run this script regularly with "crontab -e"
#!/bin/bash

uname=$(uname)
if test "$uname" = "FreeBSD"; then
    os=freebsd
elif test "$uname" = "Linux"; then
    os=linux
elif test "$uname" = "Darwin"; then
    os=macos
fi

cd "$(dirname "$0")"
iagstatus=$(./iag-cli-$os get:status 2>&1)

if [[ $iagstatus == *"up"* ]]; then
    echo "Iagon Storage Node is running normally!"
elif [[ $iagstatus == *"not"* ]]; then
    echo "Iagon Storage Node is not running, restarting it now..."
    ./iag-cli-$os stop && \
    return=$(./iag-cli-$os start 2>&1)
    if [[ $return == *"check"* ]]; then
        echo "The Iagon Storage Node process is frozen, killing and restarting it now..."
        tmpfile=$(mktemp processes.tmp.XXXXXX)
        ps -aux | sed -E 's/ +/,/g' > $tmpfile
        pids=$(awk -F "\"*,\"*" '/iagon/{print $2}' "$tmpfile")
        rm "$tmpfile"
        for pid in $pids; do
            kill "$pid"
        done
        ./iag-cli-$os start
        time=$(date)
        echo " " >> failures.log
        echo "$time: Iagon Storage Node processes were frozen, so they were killed and the node was restarted." >> failures.log
#        python3 discord-notification.py
        echo "Iagon Storage Node processes were frozen, so they were killed and the node was restarted."
    elif [[ $return == *"up"* ]]; then
        time=$(date)
        echo " " >> failures.log
        echo "$time: Iagon Storage Node was not running, so it was restarted." >> failures.log
#        python3 discord-notification.py
        echo "Iagon Storage Node was not running, so it was restarted."
    fi
else
   echo "An unknown error occurred, please manually kill the Iagon Node process and restart it. Open a support ticket in Iagon's Discord for more help."
fi
