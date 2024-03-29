# Don't forget to make this .sh file executable with "chmod +x iag-cli-updater.sh"
# Run this any time Iagon announces a new cli node update, or set up a cronjob to run it daily/weekly/monthly "crontab -e"
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

latest=$(curl https://api.github.com/repos/Iagonorg/mainnet-node-CLI/releases/latest | grep -o -P -m 1 'v.{0,5}') && \
current=v$(./iag-cli-$os --version) && \

if test "$current" = "$latest"
then
echo && \
echo "***********************" && \
echo "No new update available" && \
echo "***********************" && \
echo 
else
cd "$(dirname "$0")" && \
./iag-cli-$os stop && \
mkdir -p version-backups && \
mv iag-cli-$os version-backups/iag-cli-$os.$current.bak && \
wget "https://github.com/Iagonorg/mainnet-node-CLI/releases/download/$latest/iag-cli-$os" && \
chmod +x iag-cli-$os && \
./iag-cli-$os start && \
new=v$(./iag-cli-$os --version) && \
time=$(date) && \
echo " " >> updates.log && \
echo "$time: Updated from $current --> $new" >> updates.log && \
echo && \
echo "******************" && \
echo "Iagon Node updated" && \
echo "******************" && \
echo && \
echo "Old version:" && \
echo $current && \
echo && \
echo "New version:" && \
echo $new && \
echo 
fi
