# Don't forget to make this .sh file executable with "chmod +x iag-cli-failcatcher.sh"
# Set up a cronjob to run this script regularly with "crontab -e"
#!/bin/bash
# Detect OS for the correct binary file name:
UNAME=$(uname)
if test "$UNAME" = "FreeBSD"; then
    OS=freebsd
elif test "$UNAME" = "Linux"; then
    OS=linux
elif test "$UNAME" = "Darwin"; then
    OS=macos
fi
# Call the directory and check Iagon node status:
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd $SCRIPTPATH
IAGSTATUS=$(./iag-cli-$OS get:status 2>&1)
# If status check reported the node is up, all is fine:
if [[ $IAGSTATUS == *"up"* ]]; then
    echo "Iagon Storage Node is running normally!"
# If status check reported the node is not up, stop and start the node:
elif [[ $IAGSTATUS == *"not"* ]]; then
    echo "Iagon Storage Node is not running, restarting it now..."
    ./iag-cli-$OS stop >/dev/null 2>&1 && \
    RETURN=$(./iag-cli-$OS start 2>&1)
    # If restarting the node reported an issue, kill the process and try again:
    if [[ $RETURN == *"check"* ]]; then
        echo "The Iagon Storage Node process is frozen, killing and restarting it now..."
        tmpfile=$(mktemp processes.tmp.XXXXXX)
        ps -aux | sed -E 's/ +/,/g' > $tmpfile
        pids=$(awk -F "\"*,\"*" '/iagon/{print $2}' "$tmpfile")
        rm "$tmpfile"
        for pid in $pids; do
            kill "$pid"
        done
        ./iag-cli-$OS start >/dev/null 2>&1
        TIME=$(date)
        echo "" >> failures.log
        echo "$TIME: Iagon Storage Node processes were frozen, so they were killed and the node was restarted." >> failures.log
#        /usr/bin/python3 /path/to/your/discord-notification.py >/dev/null 2>&1 # Update this with the correct full path to your Python file (run "which python3" to find it) and the full path to your discord-notification.py file
        echo "Iagon Storage Node processes were frozen, so they were killed and the node was restarted."
    # If restarting the node was successful, problem solved, log the event:
    elif [[ $RETURN == *"started"* ]]; then
        TIME=$(date)
        echo "" >> failures.log
        echo "$TIME: Iagon Storage Node was not running, so it was restarted." >> failures.log
#        /usr/bin/python3 /path/to/your/discord-notification.py >/dev/null 2>&1 # Update this with the correct full path to your Python file (run "which python3" to find it) and the full path to your discord-notification.py file
        echo "Iagon Storage Node was not running, so it was restarted."
    fi
else
   # If none of that worked, open a support ticket:
   echo "An unknown error occurred, please manually kill the Iagon Node process and restart it. Open a support ticket in Iagon's Discord for more help."
fi
