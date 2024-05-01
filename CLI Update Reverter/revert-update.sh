# Don't forget to make this .sh file executable with "chmod +x revert-update.sh"
# Run this script in the same directory as your iag-cli node file to go back one node version
#!/bin/bash

UNAME=$(uname)
if test "$UNAME" = "FreeBSD"; then
    OS=freebsd
elif test "$UNAME" = "Linux"; then
    OS=linux
elif test "$UNAME" = "Darwin"; then
    OS=macos
fi
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )" && \
cd $SCRIPTPATH && \
CURRENT=v$(./iag-cli-$OS --version) && \
SUB=$(echo $CURRENT | rev | cut -c 2- | rev) && \
FROM=$(echo $CURRENT | awk '{print substr($0,length,1)}') && \
TO="$((FROM-1))" && \
PREVIOUS="$(echo $SUB$TO)" && \
echo "" && \
echo "Would you like to revert from $CURRENT to $PREVIOUS?" && \
echo "Please input 1 for Yes or 2 for No:" && \
select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "" && echo "Reverting now..." && echo ""; break;;
        No ) echo "" && echo "Okay, bye!" && echo "" && exit;;
    esac
done
./iag-cli-$OS stop && \
mkdir -p version-backups && \
mv "iag-cli-$OS" "version-backups/iag-cli-$OS.$CURRENT.bak" && \
wget -q "https://github.com/Iagonorg/mainnet-node-CLI/releases/download/$PREVIOUS/iag-cli-$OS" && \
chmod +x "iag-cli-$OS" && \
./iag-cli-$OS start && \
NEW="v$(./iag-cli-$OS --version)" && \
TIME=$(date) && \
echo "" >> updates.log && \
echo "$TIME: Reverted from $CURRENT --> $NEW" >> updates.log && \
echo "" && \
echo "*******************" && \
echo "Iagon Node reverted" && \
echo "*******************" && \
echo "" && \
echo "Previous version:" && \
echo $CURRENT && \
echo "" && \
echo "Current version:" && \
echo $NEW && \
echo ""
