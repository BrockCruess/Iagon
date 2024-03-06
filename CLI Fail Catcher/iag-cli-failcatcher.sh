# Don't forget to make this .sh file executable with "chmod +x iag-cli-failcatcher.sh"
# Set up a cronjob to run this script regularly with "crontab -e"
#!/bin/bash

uname=$(uname)

if test "$uname" = "FreeBSD"
then os=freebsd
else
if test "$uname" = "Linux"
then os=linux
else
if test "$uname" = "Darwin"
then os=macos
fi
fi
fi

cd "$(dirname "$0")"
iagstatus=$(./iag-cli-$os get:status 2>&1)

if [[ $iagstatus == *"up"* ]]; then
echo "Iagon Node is running normally!"
elif [[ $iagstatus == *"not"* ]]; then
echo "Iagon Node is not running, restarting it now..."
./iag-cli-$os stop && ./iag-cli-$os start
time=$(date)
echo "$time: Iagon Storage Node was not running, so it was restarted." >> failures.log && \
echo " " >> failures.log
elif [[ $iagstatus == *"check"* ]]; then
echo "The Iagon Node process is frozen, killing and restarting it now..."
tmpfile=$(mktemp processes.tmp.XXXXXX)
ps -aux | sed -E 's/ +/,/g' > $tmpfile
pid1=$(cat $tmpfile | awk '/iagon/' | sed -n 1p | awk -F "\"*,\"*" '{print $2}')
pid2=$(cat $tmpfile | awk '/iagon/' | sed -n 2p | awk -F "\"*,\"*" '{print $2}')
pid3=$(cat $tmpfile | awk '/iagon/' | sed -n 3p | awk -F "\"*,\"*" '{print $2}')
pid4=$(cat $tmpfile | awk '/iagon/' | sed -n 4p | awk -F "\"*,\"*" '{print $2}')
rm "$tmpfile"
kill $pid1
kill $pid2
kill $pid3
kill $pid4
./iag-cli-$os start
else
echo "An unknown error occured, please manually kill the Iagon Node process and restart it. Open a support ticket in Iagon's Discord for more help."
fi
