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
> If you'd like to receive an email notification every time your node goes down, set up [mailx](https://linux.die.net/man/1/mailx) on your node server then remove the hashmarks at the start of lines [36](https://github.com/BrockCruess/Iagon/blob/68dac2068726a5a31ecb727a62ac5d0361096d54/CLI%20Fail%20Catcher/iag-cli-failcatcher.sh#L36) and [42](https://github.com/BrockCruess/Iagon/blob/68dac2068726a5a31ecb727a62ac5d0361096d54/CLI%20Fail%20Catcher/iag-cli-failcatcher.sh#L42) in `iag-cli-failcatcher.sh`
