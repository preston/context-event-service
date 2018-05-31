# frozen_string_literal: true

module Context
  module Agent
    class Pruner < Base
      def initialize
        super [
          # Context::Clock::TICK_URI_MINUTE
          Context::Clock::TICK_URI_SECOND
        ]
      end

      def run
        super do |_channel, msg|
          # byebug
          ttl = Context::Clock::TICK_TIME_TO_LIVE
          puts "Purging events older than #{ttl}."
          # sleep 3
          # trigger = JSON.parse(msg)
					Event.purge_older_than(ttl.ago,
						Context::Clock::TICK_URI_SECOND, 
						Context::Clock::TICK_URI_MINUTE, 
						Context::Clock::TICK_URI_HOUR, 
						Context::Clock::TICK_URI_DAY
					)

          #   puts e.to_json
          # puts "Smith emitting message: #{e.to_json}"
          # RedisPublisher.new(session_uri_for(e.session_id), e.to_json).process
        end
      end
    end
  end
end
