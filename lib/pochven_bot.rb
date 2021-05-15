require 'discordrb'
require 'yaml'

class PochvenBot
  CONFIG    = './config.yml'.freeze
  PNG       = '.png'.freeze
  DESC      = 'show me a map'.freeze
  USAGE     = 'pochven jita'.freeze
  MANY      = 'Too many matches for '.freeze
  SPECIFIC  = ', try to be more specific!'.freeze
  CANNOT    = 'Cannot find '.freeze
  ONEOF     = ', did you mean one of: '

  def initialize
    @bot ||= Discordrb::Commands::CommandBot.new(token: config['bot_token'], prefix: prefix_proc)
    @bot.debug = {}
  end

  def run
    @bot.command(:pochven, description: DESC,
          usage: USAGE, min_args: 1) do |event, system_name|

      unless valid_systems.include? system_name
        possibilities = valid_systems.find_all { |s| s =~ /#{system_name}/}
        if possibilities.size == 1
          selected_system = possibilities[0] 
        else
          if possibilities.size > config['substring_matches']
            next "#{MANY}`#{system_name}`#{SPECIFIC}"
          else
            next "#{CANNOT}`#{system_name}`#{ONEOF}`#{possibilities.join(', ')}`"
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
      prefix = prefixes[message.channel.id] || '.'
      message.content[prefix.size..-1] if message.content.start_with?(prefix)
    end
  end

  def config
    @config ||= YAML.load(File.read(CONFIG))
  end

  def prefixes
    @prefixes ||= {
      config['channel_prefix'] => '!'
    }
  end

  def valid_systems
    @valid_systems ||= File.open(config['systems_list']).map {|l| l.strip}
  end  

  def img_url(system_name)
    [config['cdn_base'], system_name, PNG].join('')
  end
end
