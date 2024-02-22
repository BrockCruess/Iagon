**DOES NOT WORK FOR WINDOWS CLI VERSION**

*This script is useful if you don't run iag-cli as a service, but rather from a scheduled command or shell script.*

<br>

## Download:

To download the CLI Auto Updater script, run this command in the directory where your iag-cli node file is stored:

```
curl https://raw.githubusercontent.com/BrockCruess/Iagon/main/CLI%20Auto%20Updater/iag-cli-updater.sh > iag-cli-updater.sh && chmod +x iag-cli-updater.sh
```
<br>

For a manual approach, run this script any time Iagon announces a new cli node update:

```
./iag-cli-updater.sh
```
<br>

All updates will be logged to a file called `updates.log` with a timestamp.

<br>

## Schedule:

Set up a cronjob to check for updates daily at midnight by running this command with **your** script file path:

```
# Put your node directory after "iagDirectory=", with no slash at the end:
iagDirectory=/directory/where/your/iag-cli-*/file/is/with/no/slash/at/the/end

cd $iagDirectory
(crontab -l ; echo "0 0 * * * /bin/bash $iagDirectory/iag-cli-updater.sh")| crontab -
```

<br>

If you run your node as **root** user, use this instead with **your** script file path:

```
# Put your node directory after "iagDirectory=", with no slash at the end:
iagDirectory=/directory/where/your/iag-cli-*/file/is/with/no/slash/at/the/end

cd $iagDirectory
(sudo crontab -l ; echo "0 0 * * * /bin/bash $iagDirectory/iag-cli-updater.sh")| sudo crontab -
```

<br>

## Update:

If a new version of this script is available, run this command in the directory where your current Auto Updater script is stored:

```
curl https://raw.githubusercontent.com/BrockCruess/Iagon/main/CLI%20Auto%20Updater/iag-cli-updater.sh > iag-cli-updater.sh && chmod +x iag-cli-updater.sh
```
