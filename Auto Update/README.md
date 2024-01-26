To download the CLI Updater script, run this command in the directory where you want to store it (ideally your home directory):

```
wget https://github.com/BrockCruess/iagon/blob/main/Auto%20Update/iag-cli-updater.sh && chmod +x iag-cli-updater.sh
```

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
