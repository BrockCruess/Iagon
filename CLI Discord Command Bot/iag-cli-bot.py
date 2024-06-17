import discord
from discord.ext import commands
import subprocess
import requests

# Read Discord token from file
with open("discord.token", "r") as token_file:
    TOKEN = token_file.read().strip()

# Read command path from file
with open("iag-cli.path", "r") as command_file:
    COMMAND_PATH = command_file.read().strip()

def fetch_commands_help():
    url = "https://raw.githubusercontent.com/BrockCruess/Iagon/main/CLI%20Discord%20Command%20Bot/commands.help"
    response = requests.get(url)
    if response.status_code == 200:
        return response.text
    else:
        return "Failed to fetch commands help from GitHub."

# Define Discord intents
intents = discord.Intents.default()
intents.messages = True  # Enable message intents

# Create a Discord bot instance with intents
bot = commands.Bot(command_prefix='', intents=intents)

@bot.event
async def on_ready():
    print(f'Logged in as {bot.user}')

@bot.event
async def on_message(message):
    if message.author == bot.user:
        return

    # Check if the message is "commands"
    if message.content.lower() == "commands":
        commands_help = fetch_commands_help()
        await message.channel.send(commands_help)
    else:
        # Check if the message was sent in a private channel
        if isinstance(message.channel, discord.DMChannel):
            print(f"Message received: '{message.content}' from {message.author}")

            # Extract the command from the message
            if message.content.lower() == "test:rw": # Handling for test:rw that inputs the default directory
                await message.channel.send("Testing read and write speeds in your Iagon storage directory. Please wait...")
                command = f"echo \"\" | {COMMAND_PATH} {message.content}"

                # Run the command and capture stderr output only
                try:
                    result = subprocess.run(command, shell=True, text=True, capture_output=True, timeout=30)
                    stderr = result.stderr.strip()  # Remove leading/trailing whitespace from stderr
                except subprocess.CalledProcessError as e:
                    stderr = str(e.stderr, 'utf-8')
                except subprocess.TimeoutExpired:
                    stderr = "Command timed out."

                print(f"Command stderr: '{stderr}'")

                # Send the stderr output back to the user
                if stderr:
                    await message.channel.send(stderr)
                else:
                    await message.channel.send("No output available")
            elif message.content.lower() == "version": # Handling for "version", an artificial command alias
                command = f"{COMMAND_PATH} -V" # Convert "version" to the -V flag to check node version
                await message.channel.send(f"Checking version...")

                # Run the command and capture both stdout and stderr output
                try:
                    result = subprocess.run(command, shell=True, text=True, capture_output=True, timeout=30)
                    stdout = result.stdout.strip()  # Remove leading/trailing whitespace from stdout
                    stderr = result.stderr.strip()  # Remove leading/trailing whitespace from stderr
                except subprocess.CalledProcessError as e:
                    stderr = str(e.stderr, 'utf-8')
                    stdout = ""
                except subprocess.TimeoutExpired:
                    stderr = "Command timed out."
                    stdout = ""

                print(f"Command stdout: '{stdout}'")
                print(f"Command stderr: '{stderr}'")

                # Send the output back to the user
                if stdout:
                    await message.channel.send(stdout)
                elif stderr:
                    await message.channel.send(stderr)
                else:
                    await message.channel.send("No output available")
            else:
                command = f"{COMMAND_PATH} {message.content}"
                await message.channel.send(f"Running '{message.content}' command...")

                # Run the command and capture both stdout and stderr output
                try:
                    result = subprocess.run(command, shell=True, text=True, capture_output=True, timeout=30)
                    stdout = result.stdout.strip()  # Remove leading/trailing whitespace from stdout
                    stderr = result.stderr.strip()  # Remove leading/trailing whitespace from stderr
                except subprocess.CalledProcessError as e:
                    stderr = str(e.stderr, 'utf-8')
                    stdout = ""
                except subprocess.TimeoutExpired:
                    stderr = "Command timed out."
                    stdout = ""

                print(f"Command stdout: '{stdout}'")
                print(f"Command stderr: '{stderr}'")

                # Send the output back to the user
                if stdout:
                    await message.channel.send(stdout)
                elif stderr:
                    await message.channel.send(stderr)
                else:
                    await message.channel.send("No output available")

# Start the bot
bot.run(TOKEN)
