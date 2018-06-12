class RedisPublisher < RedisBase
  
  attr_reader :data, :channel

  def initialize(channel, data)
    super()
    @channel = channel
    @data = data
  end

	def process
		begin
			connection.publish(channel, data)
		rescue SocketError => e
			# Not sure exactly what to do with this except for swallowing it :/
			puts "Failure to publish event to #{channel}!!! Looks like something funky is happening with the network."
		end
  end
end
