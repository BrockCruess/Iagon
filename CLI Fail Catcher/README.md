> [!NOTE]
> Does not work with the Windows CLI version of Iagon Node.

<br>

This script is useful if you don't run iag-cli as a service, but rather from a scheduled command or shell script. In fact, with this script you don't need to schedule iag-cli to run on reboot, because this script will always start the node if it's not running (after 15 minutes).

This is meant for nodes running under a regular user, not root. To make it work with root you'll have to use "sudo crontab" anywhere the below command uses "crontab", and type in your root password if prompted.

<br>

## Download & Setup:

Run this command with **your** iag-cli-* file directory to download the CLI Fail Catcher script and schedule it as a crontab job to check for failures every 15 mins:

```
# Put your node directory after "iagDirectory=", with no slash at the end:
iagDirectory=/DirectoryWhereYour/iag-cli-*FileIsWithNoSlashAtTheEnd

cd $iagDirectory
curl https://raw.githubusercontent.com/BrockCruess/Iagon/main/CLI%20Fail%20Catcher/iag-cli-failcatcher.sh > iag-cli-failcatcher.sh && chmod +x iag-cli-failcatcher.sh && (crontab -l ; echo "*/15 * * * * cd $iagDirectory && /bin/bash iag-cli-failcatcher.sh") | crontab -
```
<br>

If you run your node as root user, use this instead with your iag-cli-* file directory:

```
# Put your node directory after "iagDirectory=", with no slash at the end:
iagDirectory=/DirectoryWhereYour/iag-cli-*FileIsWithNoSlashAtTheEnd

cd $iagDirectory
curl https://raw.githubusercontent.com/BrockCruess/Iagon/main/CLI%20Fail%20Catcher/iag-cli-failcatcher.sh > iag-cli-failcatcher.sh && chmod +x iag-cli-failcatcher.sh && (sudo crontab -l ; echo "*/15 * * * * cd $iagDirectory && /bin/bash iag-cli-failcatcher.sh") | sudo crontab -
```

<br>

All failures will be logged to a file called `failures.log` with a timestamp.

<br>

## Update:

If a new version of this script is available, run this command in the directory where your current Fail Catcher script is stored:

```
curl https://raw.githubusercontent.com/BrockCruess/Iagon/main/CLI%20Fail%20Catcher/iag-cli-failcatcher.sh > iag-cli-failcatcher.sh && chmod +x iag-cli-failcatcher.sh
```
