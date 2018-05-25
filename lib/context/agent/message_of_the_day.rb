# frozen_string_literal: true

module Context
  module Agent
    class MessageOfTheDay < Base
      MOTD_AGENT_URI = 'artaka://agents/message-of-the-day'
      MOTD_MODEL_URI = 'https://rubygems.org/gems/quotable/versions/0.0.2'
      MOTD_ACTION_URI = 'http://www.ke.tu-darmstadt.de/ontologies/ui_detail_level.owl#display'
      def initialize
        super [
          'http://www.ke.tu-darmstadt.de/ontologies/ui_detail_level.owl#load',
          'http://www.ke.tu-darmstadt.de/ontologies/ui_detail_level.owl#information-presentation-initialization'
        ]
      end

      def run
		super do |channel, msg|
			puts "Received event on #{channel}: #{msg}"
          # byebug
          trigger = JSON.parse(msg)
          e = Event.new(
            parent_id: trigger['id'],
            session_id: trigger['session_id'],
            topic_uri: MOTD_AGENT_URI,
            agent_uri: MOTD_AGENT_URI,
            action_uri: MOTD_ACTION_URI,
            model_uri: MOTD_MODEL_URI,
            parameters: { motd: Quotable.random }
          )
          #   puts e.to_json
          puts "Emitting message of the day: #{e.to_json}"
          RedisPublisher.new(session_uri_for(e.session_id), e.to_json).process
        end
      end
      end
  end
  end
