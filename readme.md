# PochvenBot

A bot for posting pochven maps to discord on demand, built with [discordrb](https://github.com/shardlab/discordrb) 

Maps are provided by Kadesh Priestess and details on how they work can be found in his excellent [Logistics via Pochven](https://docs.google.com/document/d/1Cllc7yWghQm52wZ2wFqn1e_Ule2KbNQtQuPNrP_TiHU/edit) document


---


### Basic Usage:

Invoke the bot with a system name and it will find the relevant map and embed it for you

![usage_example](https://i.imgur.com/2FJi08V.png)

---
## Installation

### Create a bot

- Go to [Discord Developer Portal](https://discord.com/developers/applications) and create a new application. 
- Under the "Bot" tab, hit the "Add Bot" button to turn your new application into a bot.
- Click the "Copy" button to copy the bot's token, you'll need this in the configuration stage.
- On the Oauth2 tab check the "Bot" permission under "Scopes", and under "Bot Permissions" check "Write messages", "Embed Links" and "Read Message History"
- Copy the generated Oauth2 scope and paste it into your browser, this will allow you to invite your new bot to your server (must be an admin)

### Config.yml

The config has a few fields that you will need to enter yourself, use the `config.yml.example` to create your own `config.yml`

- `bot_token` - this is the token available on the "Bot" tab of your application
- `substring_matches` - How many potential systems the bot will list if your spelling is bad, ie, if you ask for the map for "a", there's potentially hundreds of matches, but if the no. of matches exceeds the substring_matches value, it won't list them all.
- `channels` - A list of the channels the bot should respond to. You can find your channel ids by turning on Discord developer mode and rightclicking the channel.
- `prefix` - The command prefix for the bot, with the value `'!'` you then call the bot with *"!pochven system-name"*
- `cdn_base` - Specifies the base URL for the map images. Maps are hosted by Goryn Clade, but you can change this if you want to use your own maps 


### Usage
- After your config has been created you can run the containers with `docker-compose run -d --build`
- In the specified channels you can now call the bot to embed maps like `!pochven jita`

