import discord
import sys

TOKEN = 'YOUR_DISCORD_BOT_TOKEN_LEAVE_THE_QUOTES'
USER_ID = your_numberical_discord_userid_no_quotes

# Intents
intents = discord.Intents.default()
intents.messages = True

# Initialize the bot with intents
client = discord.Client(intents=intents)

@client.event
async def on_ready():
    print(f'Bot logged in as {client.user}')

    try:
        # Fetch the user object
        user = await client.fetch_user(USER_ID)
        # Send a private message
        await user.send("Iagon Storage Node went down and was restarted.")
        print("Message sent successfully.")
    except discord.NotFound:
        print("User not found.")
    except discord.Forbidden:
        print("The bot does not have permission to send a message to this user.")
    except discord.HTTPException:
        print("Failed to send the message due to an HTTP error.")

    # Close the bot
    await client.close()
    sys.exit()

# Run the bot
client.run(TOKEN)
