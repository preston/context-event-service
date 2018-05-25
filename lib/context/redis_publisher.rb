class RedisPublisher < RedisBase
  
  attr_reader :data, :channel

  def initialize(channel, data)
    super()
    @channel = channel
    @data = data
  end

  def process
    connection.publish(channel, data)
  end
end
