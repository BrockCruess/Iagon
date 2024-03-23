# Iagon Discord Command Bot

This Python bot runs in the same directory as your iag-cli-* file. Any Iagon commands sent via private message to the bot will be run on your node, and the command outputs will be returned to you via private message.

## Bot setup:

### 1. Create a new Discord server:

- Click the + at the bottom of the server list.

![image](https://github.com/BrockCruess/Iagon/assets/54557110/38c0d805-6d19-4149-847c-f312dad9b879)

- No template is needed as this server will not actually be used for anything, the bot just has to be in a server with you to be allowed to send you messages.

- At the time of writing this the process is:
  - Click "Create My Own"
  - Click "For me and my friends"
  - Name the server something like "My Bots"
> [!WARNING]
> Do not invite anyone else to this server. Only invite your own private bots. Anyone in this server can interact with bots in the server, meaning they can send Iagon commands to your node.




### 2. Create a Discord Bot Token:

- On the [Discord Developer Portal](discord.com/developers/applications), create a New Application:

![image](https://github.com/BrockCruess/Iagon/assets/54557110/d139547e-d7f9-4d3b-859f-f67f901f6c08)

- Name it "Iagon Bot", check the box and click "Create":

![image](https://github.com/BrockCruess/Iagon/assets/54557110/fbcbd4cb-f324-4027-b393-499774eb55c4)

- On the Iagon Bot application's page, Navigate to "OAuth2":

![image](https://github.com/BrockCruess/Iagon/assets/54557110/8182391c-278b-42be-876a-5fc97c28457c)

- Under "OAuth2 URL Generator" check "bot", then under "BOT PERMISSIONS" check "Administrator".

- Go to the bottom of the page and click "Copy" to copy the bot's invite URL:

![image](https://github.com/BrockCruess/Iagon/assets/54557110/5bb3f5f7-a6e5-464e-ac18-df16d5a99b26)

- Paste the bot's invite URL in a new tab in your web browser and invite the bot **only** to your new bot server.

- Back on the Discord Developer Portal, on the Iagon Bot application's page, go to "Bot":

![image](https://github.com/BrockCruess/Iagon/assets/54557110/9d6b3036-ccdb-4892-92ac-848bfc8b662e)

- Under "TOKEN", click "Reset Token":

![image](https://github.com/BrockCruess/Iagon/assets/54557110/d7ded603-8e13-4b14-a018-912305a493be)

- Click "Yes, do it!":

![image](https://github.com/BrockCruess/Iagon/assets/54557110/9bfa13a9-3946-4333-a4da-0f11b3c9ef95)

- If you have MFA enabled (which you absolutely should), enter your authentication code and click "Submit":

![image](https://github.com/BrockCruess/Iagon/assets/54557110/c7c90788-f96d-4a57-aa39-43d2c822cdde)

> [!IMPORTANT]
> Always use MFA/2FA with your online accounts. It's way too easy to steal your account if you don't use MFA/2FA. Having your Discord account connected to something as important as your Iagon node is very dangerous if you don't use Discord MFA.

- Now click "Copy" to copy your Bot Token:

![image](https://github.com/BrockCruess/Iagon/assets/54557110/006bf318-0462-4941-95ae-9c051d83b7a4)

> [!WARNING]
> Never share your bot token with anyone!
> 
> The token shown above was temporarily made for the purposes of this tutorial and no longer exists.

- Paste this token in a temporary text file or somewhere accessible for now, we'll need it later.




### 3. Set up the Python bot:

- Install Python 3 or newer.

- Install the required Python package for Discord:
```
pip install discord
```

- In the same directory as your `iag-cli-*` file, run this command to download all of the bot's files:
```
curl https://raw.githubusercontent.com/BrockCruess/Iagon/main/CLI%20Discord%20Command%20Bot/iag-cli-bot.py > iag-cli-bot.py && \
curl https://raw.githubusercontent.com/BrockCruess/Iagon/main/CLI%20Discord%20Command%20Bot/iag-cli.path > iag-cli.path && \
curl https://raw.githubusercontent.com/BrockCruess/Iagon/main/CLI%20Discord%20Command%20Bot/discord.token > discord.token && \
curl https://raw.githubusercontent.com/BrockCruess/Iagon/main/CLI%20Discord%20Command%20Bot/commands.help > command.help
```

> [!NOTE]
> Stay in this directory for the rest of the steps.

- Update the `discord.token` file with your Discord bot token.

- Update the `iag-cli.path` file with the name of your `iag-cli-*` file. The default is the name of the [Linux CLI file](https://github.com/Iagonorg/mainnet-node-CLI/releases/latest/).

- Run this command to create a start script for the bot:
```
nano start-discord-bot.sh
```
- Copy and and paste this into the Nano window (right-click to paste) then save and close the file with `CTRL + X`:
```
#!/bin/bash
python3 iag-cli-bot.py
```
- Run this command to give the script executable permissions:
```
chmod +x start-discord-bot.sh
```

> [!TIP]
> From this point on, anywhere you see `python3` used in a command, you may have to replace it with an absolute path to your Python executable file, depending on how you installed Python.
> 
> It's recommended that you test running `python3 iag-cli-bot.py` to see if Python successfully executes the script to start the bot. If it doesn't, try providing an absolute path like `/usr/bin/python3 iag-cli-bot.py`. Whichever works, use it for the following steps.

> [!NOTE]
> If you're using the root user to run your Iagon Node (typically not recommended), you might not need `sudo` in the following commands.

- Run this command to create a new systemd service for the bot's start script:
```
sudo nano /etc/systemd/system/iag-cli-bot.service
```
- Enter your password if prompted. In the following text, modify the `YOUR-USERNAME`, the `/ABSOLUTE/PATH/TO/iag-cli-*/FOLDER/` and the `/ABSOLUTE/PATH/TO/YOUR/start-discord-bot.sh` with the name of the user that runs your Iagon node, your working directory (Iagon folder) path, and the bot's start script path respectively. Copy the entire modified text and paste it into the Nano window (right-click to paste) then save and close the file with `CTRL + X`:
```
[Unit]
Description = Iagon Discord Command Bot Service
Wants = network-online.target
After = network-online.target

[Service]
User = YOUR-USERNAME
WorkingDirectory = /ABSOLUTE/PATH/TO/iag-cli-*/FOLDER
ExecStart = /bin/bash -c '/ABSOLUTE/PATH/TO/YOUR/start-discord-bot.sh'
TimeoutStopSec = 5
Restart = always
RestartSec = 5

[Install]
WantedBy = multi-user.target
```

- Enable the new service so it runs on startup. Enter your password if prompted:
```
sudo systemctl enable iag-cli-bot.service
```

- Start the bot service. Enter your password if prompted:
```
sudo systemctl start iag-cli-bot.service
```

- Check the status of the bot service to make sure it's running:
```
systemctl status iag-cli-bot.service
```
You should see something like this that says
$\color{green}{\textsf{active (running)}}$
:

![Screenshot 2024-03-23 135134](https://github.com/BrockCruess/Iagon/assets/54557110/44be573c-1acf-46f6-aeec-5be373b206d2)



### Go to your Discord bot server and right click your Iagon Bot to send it a message. Send `commands` to the bot and it will send back a list of all commands you can send it.