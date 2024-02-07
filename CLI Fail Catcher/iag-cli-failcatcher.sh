# Don't forget to make this .sh file executable with "chmod +x iag-cli-updater.sh"
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
else
if [[ $iagstatus == *"not"* ]]; then
echo "Iagon Node is not running, restarting it now..."
./iag-cli-$os stop && ./iag-cli-$os start
else
echo "An unknown error occured, please manually kill the Iagon Node process and restart it. Open a support ticket in Iagon's Discord for more help."
fi
fi
