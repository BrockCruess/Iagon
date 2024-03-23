import discord
from discord.ext import commands
import subprocess

# Read Discord token from file
with open("discord.token", "r") as token_file:
    TOKEN = token_file.read().strip()

# Read command path from file
with open("iag-cli.path", "r") as command_file:
    COMMAND_PATH = command_file.read().strip()

def load_commands_help():
    with open("commands.help", "r") as help_file:
        return help_file.read()

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
        commands_help = load_commands_help()
        await message.channel.send(commands_help)
    else:
        # Check if the message was sent in a private channel
        if isinstance(message.channel, discord.DMChannel):
            print(f"Message received: '{message.content}' from {message.author}")

            # Extract the command from the message
            command = f"{COMMAND_PATH} {message.content}"

            # Run the command and capture output
            try:
                result = subprocess.run(command, shell=True, text=True, capture_output=True, timeout=30)
                output = result.stderr
            except subprocess.CalledProcessError as e:
                output = str(e.stderr, 'utf-8')
            except subprocess.TimeoutExpired:
                output = "Command timed out."

            print(f"Command output: '{output}'")
            # Send the output back to the user
            await message.channel.send(output)

# Start the bot
bot.run(TOKEN)
