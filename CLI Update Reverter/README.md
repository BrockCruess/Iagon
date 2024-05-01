<h1 align="center">
CLI Update Reverter<br/><br/>
</h1>

> [!NOTE]
> Does not work with the Windows CLI version of Iagon Node.

<br>

This script is useful if you don't run iag-cli as a service, but rather from a scheduled command or shell script.

If you're having troubles with a new node version update, run this script to go back one version.

To download the executable script, run this command in the directory where your iag-cli node file is stored:

```
curl https://raw.githubusercontent.com/BrockCruess/Iagon/main/CLI%20Update%20Reverter/revert-update.sh > revert-update.sh && chmod +x revert-update.sh
```

To revert your node version, run the script:

```
./revert-update.sh
```

Upon success this script will add an entry to `updates.log`
