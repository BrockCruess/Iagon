<h1 align="center">
CLI Process Killer<br/><br/>
</h1>

> [!NOTE]
> Does not work with the Windows CLI version of Iagon Node.

<br>

This script is useful if you don't run iag-cli as a service, but rather from a scheduled command or shell script.

If your node is held up and won't start/restart properly, run this script to fully kill all Iagon-related processes then try starting it again.

To download the executable script, run this command in the directory where your iag-cli node file is stored:

```
curl https://raw.githubusercontent.com/BrockCruess/Iagon/main/CLI%20Process%20Killer/kill-iag.sh > kill-iag.sh && chmod +x kill-iag.sh
```

To kill all Iagon-related processes, run the script:

```
./kill-iag.sh
```

