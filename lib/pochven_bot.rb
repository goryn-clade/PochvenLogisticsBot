require 'discordrb'
require 'yaml'

class PochvenBot
  CONFIG    = './config.yml'.freeze
  SYSTEMS   = './lib/system_names.txt'.freeze
  PNG       = '.png'.freeze
  DESC      = 'show me a map'.freeze
  USAGE     = 'pochven jita'.freeze
  MANY      = 'Too many matches for '.freeze
  SPECIFIC  = ', try to be more specific!'.freeze
  CANNOT    = 'Cannot find system '.freeze
  ONEOF     = ', did you mean one of: '.freeze
  SPELLING  = ', check your spelling and try again'.freeze
  HELP      = ".\n**The Pochven Bot posts the pochven exit map for a requested system.**\n • Use it like `!p jita`, to get the map for jita.\n • See pinned posts for Kadesh\'s guide on how to read the maps".freeze
  # System names only use these characters. Stripping everything else keeps
  # markdown and mentions out of replies.
  INVALID   = /[^a-z0-9-]/.freeze
  # discordrb 3.8 has no name for this intent, so pass its bit.
  MESSAGE_CONTENT = 1 << 15

  def initialize
    # Only the intents the bot uses. The default (:all) asks for privileged
    # intents the application is not approved for, and Discord refuses it.
    @bot ||= Discordrb::Commands::CommandBot.new(token: config['bot_token'], prefix: prefix_proc,
                                                 intents: [:servers, :server_messages, MESSAGE_CONTENT])
  end

  def run
    @bot.command(:p, description: DESC,
          usage: USAGE, min_args: 1) do |event, arg1, arg2, arg3|

      system_name = [arg1,arg2,arg3].compact.join('-').downcase.tr(' ', '-').gsub(INVALID, '')

      next HELP if system_name == 'help' || system_name.empty?

      unless valid_systems.include? system_name
        possibilities = valid_systems.find_all { |s| s.include? system_name }
        if possibilities.size == 1
          selected_system = possibilities[0] 
        else
          if possibilities.size > config['substring_matches']
            next "#{MANY}`#{system_name}`#{SPECIFIC}"
          elsif possibilities.size > 0
            next "#{CANNOT}`#{system_name}`#{ONEOF}`#{possibilities.join(', ')}`"
          else
            next "#{CANNOT}`#{system_name}`#{SPELLING}"
          end
        end
      else
        selected_system = system_name
      end

      event.channel.send_embed("Here's the exit map for #{selected_system}") do |embed|
        embed.image = Discordrb::Webhooks::EmbedImage.new(url: img_url(selected_system))
      end
    end
    @bot.run
  end

  def prefix_proc
    @prefix_proc ||= proc do |message|
      prefix = prefixes[message.channel.id]
      message.content[prefix.size..-1] if prefix && message.content.start_with?(prefix)
    end
  end

  def config
    @config ||= YAML.load(File.read(CONFIG))
  end

  def prefixes
    @prefixes ||= config['channels'].map { |id| [id,config['prefix']] }.to_h
  end

  def valid_systems
    @valid_systems ||= File.open(SYSTEMS).map {|l| l.strip}
  end  

  def img_url(system_name)
    [config['cdn_base'], system_name, PNG].join('')
  end
end
