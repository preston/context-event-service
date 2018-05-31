# frozen_string_literal: true

module Context
  module Agent
    class Pruner < Base
      PRUNER_AGENT_URI = 'artaka://agents/pruner'
      PRUNER_MODEL_URI = 'artaka://agents/pruner'
      PRUNER_ACTION_URI = 'artaka://agents/pruner/actions/complete'
      def initialize
        super [
          Context::Clock::TICK_URI_MINUTE
          # Context::Clock::TICK_URI_SECOND
        ]
      end

      def run
        super do |_channel, _msg|
          # byebug
          ttl = Context::Clock::TICK_TIME_TO_LIVE
          puts "Purging events older than #{ttl}."
          # sleep 3
          trigger = JSON.parse(_msg)
          Event.purge_older_than(ttl.ago,
                                 Context::Clock::TICK_URI_SECOND,
                                 Context::Clock::TICK_URI_MINUTE,
                                 Context::Clock::TICK_URI_HOUR,
                                 Context::Clock::TICK_URI_DAY)
          e = Event.new(
            parent_id: trigger['id'],
            topic_uri: PRUNER_AGENT_URI,
            agent_uri: PRUNER_AGENT_URI,
            action_uri: PRUNER_ACTION_URI,
            model_uri: PRUNER_MODEL_URI
          )
          e.save!
        end
      end
    end
  end
end
