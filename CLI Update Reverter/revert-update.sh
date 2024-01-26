# Don't forget to make this .sh file executable with "chmod +x revert-update.sh"
# Run this script in the same directory as your iag-cli node file to go back one node version
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

current=v$(./iag-cli-$os --version) && \
sub=$(echo $current | rev | cut -c 2- | rev) && \
from=$(echo $current | awk '{print substr($0,length,1)}') && \
to="$((from-1))" && \
previous="$(echo $sub$to)" && \
./iag-cli-$os stop && \
mv iag-cli-$os iag-cli-$os.$current.bak && \
wget "https://github.com/Iagonorg/mainnet-node-CLI/releases/download/$previous/iag-cli-$os" && \
chmod +x iag-cli-$os && \
./iag-cli-$os start && \
new=v$(./iag-cli-$os --version) && \
time=$(date) && \
echo "$time: Reverted from $current --> $new" >> updates.log && \
echo " " >> updates.log &&\
echo && \
echo "*******************" && \
echo "Iagon Node reverted" && \
echo "*******************" && \
echo && \
echo "Previous version:" && \
echo $current && \
echo && \
echo "Current version:" && \
echo $new && \
echo 
