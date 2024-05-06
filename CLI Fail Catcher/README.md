<h1 align="center">
CLI Fail Catcher<br/><br/>
</h1>

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
curl https://raw.githubusercontent.com/BrockCruess/Iagon/main/CLI%20Fail%20Catcher/iag-cli-failcatcher.sh > iag-cli-failcatcher.sh && chmod +x iag-cli-failcatcher.sh && (crontab -l ; echo "*/15 * * * * cd $iagDirectory && /bin/bash iag-cli-failcatcher.sh") | crontab - && (crontab -l ; echo "0 1 * * * curl https://raw.githubusercontent.com/BrockCruess/Iagon/main/CLI%20Fail%20Catcher/iag-cli-failcatcher.sh > $iagDirectory/iag-cli-failcatcher.sh && chmod +x $iagDirectory/iag-cli-failcatcher.sh") | crontab -
```

<br>
<br>

> [!TIP]
> If you also run the [CLI Discord Command Bot](https://github.com/BrockCruess/Iagon/tree/main/CLI%20Discord%20Command%20Bot) and you'd like to receive a Discord message notification every time your node goes down, download [discord-notification.py](https://github.com/BrockCruess/Iagon/blob/main/CLI%20Fail%20Catcher/discord-notification.py) to the same directory as `iag-cli-failcatcher.sh` on your node server, edit the file to set your Discord Bot Token and your Discord User ID, then remove the hashmarks at the start of lines [39](https://github.com/BrockCruess/Iagon/blob/main/CLI%20Fail%20Catcher/iag-cli-failcatcher.sh#L39) and [46](https://github.com/BrockCruess/Iagon/blob/main/CLI%20Fail%20Catcher/iag-cli-failcatcher.sh#L46) in `iag-cli-failcatcher.sh` and update the `python3` and `discord-notification.py` file paths in those two lines.
