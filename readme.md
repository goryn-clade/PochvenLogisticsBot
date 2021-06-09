# Pochven Logistics Bot for Eve Online

A simple bot for posting pochven logistics maps to discord, built with [discordrb](https://github.com/shardlab/discordrb) 

The maps are provided by **Kadesh Priestess** and details on how they work can be found in his excellent [Logistics via Pochven](https://docs.google.com/document/d/1Cllc7yWghQm52wZ2wFqn1e_Ule2KbNQtQuPNrP_TiHU/edit) document


---


### Basic Usage:

Invoke the bot with a system name and it will find the relevant map and embed it for you

![usage_example](https://i.imgur.com/2FJi08V.png)

---
## Setup

The Pochven Logistics Bot is intended as a base for you to run your own privately hosted bot. 

### 1. Create a bot

- Go to [Discord Developer Portal](https://discord.com/developers/applications) and create a new application. 
- Under the "Bot" tab, hit the "Add Bot" button to turn your new application into a bot.
- Click the "Copy" button to copy the bot's token, you'll need this in the configuration stage.
- On the Oauth2 tab check the "Bot" permission under "Scopes", and under "Bot Permissions" check "Write messages", "Embed Links" and "Read Message History"
- Copy the generated Oauth2 scope and paste it into your browser, this will allow you to invite your new bot to your server (must be an admin)

###  2. Clone it and Create a config.yml

- Clone this repository
- Create a `config.yml` at the project root


**Config Fields**

The config has fields that you will need to provide your own values for, use the `config.yml.example` as a base.

#### Required:
- `bot_token` - this is the token available on the "Bot" tab of your application
- `channels` - A list of the channels the bot should respond to. You can find your channel ids by turning on Discord developer mode and rightclicking the channel.

#### Optional (These can be left with their default values)
- `substring_matches` - How many potential systems the bot will list if your spelling is bad, i.e, if you ask for the map for "a", there's potentially hundreds of matches, but if the no. of matches exceeds the substring_matches value, it won't list them all.
- `prefix` - The command prefix for the bot, with the value `'!'` you then call the bot with *"!pochven system-name"*
- `cdn_base` - Specifies the base URL for the map images. Maps are hosted by Goryn Clade, but you can change this if you want to use your own maps 


### 3. Run it
- After your config has been created you can run the containers with `docker-compose run -d --build`
- The bot can be run outside of docker with `bundle install && ruby run.rb` 
- In the specified channels you can now call the bot to embed maps like `!pochven jita`

---

## CCP Copyright Notice

EVE Online, the EVE logo, EVE and all associated logos and designs are the intellectual property of CCP hf. All artwork, screenshots, characters, vehicles, storylines, world facts or other recognizable features of the intellectual property relating to these trademarks are likewise the intellectual property of CCP hf. EVE Online and the EVE logo are the registered trademarks of CCP hf. All rights are reserved worldwide. All other trademarks are the property of their respective owners. CCP hf. has granted permission to pyfa to use EVE Online and all associated logos and designs for promotional and information purposes on its website but does not endorse, and is not in any way affiliated with, pyfa. CCP is in no way responsible for the content on or functioning of this program, nor can it be liable for any damage arising from the use of this program.