class RedisSubscriber < RedisBase
  attr_reader :channel

  def initialize(channel)
    @channel = channel
  end

  def process(sse)
    connection.subscribe(channel) do |on|
      on.message do |_channel, message|
				puts message
				sse.write(message)
      end
    end
  end
  end
