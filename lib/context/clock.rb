module Context

	module Clock

		TICK_URI_PREFIX = "artaka://ticks"
		TICK_URI_SECOND = "#{TICK_URI_PREFIX}/second"
		TICK_URI_MINUTE = "#{TICK_URI_PREFIX}/minute"
		TICK_URI_HOUR = "#{TICK_URI_PREFIX}/hour"
		TICK_URI_DAY = "#{TICK_URI_PREFIX}/day"

		def emit_every_to(seconds, channel)
			loop do
				emit_tick channel
				sleep seconds
			end
		end

		def emit_tick(topic_uri)
			e = Event.new()
			e.topic_uri = e.model_uri = topic_uri
			e.save!
			puts "Emited tick to #{e.topic_uri}."
		end
	end

end