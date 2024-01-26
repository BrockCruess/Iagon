This script is useful if you don't run iag-cli as a service, but rather from a scheduled command or shell script.

To download the CLI Updater script, run this command in the directory where you want to store it (ideally your home directory):

```
curl https://raw.githubusercontent.com/BrockCruess/Iagon/main/CLI%20Auto%20Updater/iag-cli-updater.sh > iag-cli-updater.sh && chmod +x iag-cli-updater.sh && nano iag-cli-updater.sh
```
When the text editor opens, replace this path with your Iagon node file directory:

`directory=$HOME/iagon`

Press `Ctrl + x` to exit Nano text editor, then `y` to confirm modifications, and finally `Enter` to confirm the same file name.

Run this script any time Iagon announces a new cli node update:

```
./iag-cli-updater.sh
```

Or set up a cronjob to run it daily/weekly/monthly by running this command:

```
crontab -e
```

Add one of these lines at the bottom:

```
#Iagon CLI Node Daily Update:
0 0 * * * /your/path/to/iag-cli-updater.sh
```

```
#Iagon CLI Node Weekly Update:
0 0 * * 0 /your/path/to/iag-cli-updater.sh
```

```
#Iagon CLI Node Monthly Update:
0 0 1 * * /your/path/to/iag-cli-updater.sh
```
