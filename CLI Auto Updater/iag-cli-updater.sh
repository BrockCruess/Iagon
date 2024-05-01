# Don't forget to make this .sh file executable with "chmod +x iag-cli-updater.sh"
# Run this any time Iagon announces a new cli node update, or set up a cronjob to run it daily/weekly/monthly "crontab -e"
#!/bin/bash

UNAME=$(uname)

if test "$UNAME" = "FreeBSD"
then OS=freebsd
else
if test "$UNAME" = "Linux"
then OS=linux
else
if test "$UNAME" = "Darwin"
then OS=macos
fi
fi
fi

LATEST=$(curl https://api.github.com/repos/Iagonorg/mainnet-node-CLI/releases/latest | grep -o -P -m 1 'v.{0,5}') && \
CURRENT=v$(./iag-cli-$OS --version) && \
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )" && \
if test "$CURRENT" = "$LATEST"; then
echo "" && \
echo "***********************" && \
echo "No new update available" && \
echo "***********************" && \
echo ""
elif test "$CURRENT" = ""; then
echo "" && \
echo "An error occured when attempting to check Iagon Node version. Did you rename the node file? Is it executable?" && \
echo ""
else
cd $SCRIPTPATH && \
./iag-cli-$OS stop && \
mkdir -p version-backups && \
mv iag-cli-$OS version-backups/iag-cli-$OS.$CURRENT.bak && \
wget "https://github.com/Iagonorg/mainnet-node-CLI/releases/download/$LATEST/iag-cli-$OS" && \
chmod +x iag-cli-$OS && \
./iag-cli-$OS start && \
NEW=v$(./iag-cli-$OS --version) && \
TIME=$(date) && \
echo "" >> updates.log && \
echo "$TIME: Updated from $CURRENT --> $NEW" >> updates.log && \
echo "" && \
echo "******************" && \
echo "Iagon Node updated" && \
echo "******************" && \
echo "" && \
echo "Old version:" && \
echo $CURRENT && \
echo "" && \
echo "New version:" && \
echo $NEW && \
echo ""
fi
