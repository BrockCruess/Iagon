############################################################

# Set your operating system - options: freebsd, linux, macos
os=linux

# Set your Iagon node directory
directory=$HOME/iagon

# Don't forget to make this .sh file executable with "chmod +x iag-cli-updater.sh"
# Run this any time Iagon announces a new cli node update, or set up a cronjob to run it weekly/monthly "crontab -e"

############################################################

latest=$(curl https://api.github.com/repos/Iagonorg/mainnet-node-CLI/releases/latest | grep -o -P -m 1 'v.{0,5}') && \
cd $directory && \
./iag-cli-$os stop && \
mv iag-cli-$os iag-cli-$os.bak && \
wget "https://github.com/Iagonorg/mainnet-node-CLI/releases/download/$latest/iag-cli-$os" && \
chmod +x iag-cli-$os && \
./iag-cli-$os start && \
./iag-cli-$os --version
