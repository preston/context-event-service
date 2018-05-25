# frozen_string_literal: true

class RedisSubscriber < RedisBase
  attr_reader :channels

  def initialize(channels)
    super()
    @channels = channels
  end

  def process(&block)
    # https://stackoverflow.com/questions/32009079/psubscribe-redis-command-on-rails
    connection.psubscribe(channels) do |on|
      on.pmessage do |event, c, message|
        # puts "REC AND MAKING CALLBACK FOR: #{message}"
       block.call(c, message)
      end
    end
  end
end
