class RedisPublisher < RedisBase

	attr_reader :options, :channel
	
	def initialize channel, options
	  @channel     = channel
	  @options = options
	end
	
	def process
	  connection.publish(channel, options)
	end

end