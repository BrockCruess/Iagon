**DOES NOT WORK FOR WINDOWS CLI VERSION**

*This script is useful if you don't run iag-cli as a service, but rather from a scheduled command or shell script.*

Run this command with **your** script file path to download the CLI Fail Catcher script and schedule it as a crontab job to run every half hour:

```
# Put your node directory after "path=", with no slash at the end:
path=/directory/where/your/iag-cli-*/file/is/with/no/slash/at/the/end

cd $path
curl https://raw.githubusercontent.com/BrockCruess/Iagon/main/CLI%20Fail%20Catcher/iag-cli-failcatcher.sh > iag-cli-failcatcher.sh && chmod +x iag-cli-failcatcher.sh && (crontab -l ; echo "*/30 * * * * $path/iag-cli-failcatcher.sh")| crontab -
```
