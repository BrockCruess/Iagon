**DOES NOT WORK FOR WINDOWS CLI VERSION**

*This script is useful if you don't run iag-cli as a service, but rather from a scheduled command or shell script.*

To download the CLI Auto Updater script, run this command in the directory where your iag-cli node file is stored:

```
curl https://raw.githubusercontent.com/BrockCruess/Iagon/main/CLI%20Auto%20Updater/iag-cli-updater.sh > iag-cli-updater.sh && chmod +x iag-cli-updater.sh
```

Run this script any time Iagon announces a new cli node update:

```
./iag-cli-updater.sh
```

Or set up a cronjob to check for updates daily at midnight by running this command with **your** script file path:

```
(crontab -l ; echo "0 0 * * * /bin/bash /your/iagon/directory/iag-cli-updater.sh")| crontab -
```
