# frozen_string_literal: true

module Context
	module Agent
	  class Smith < Base
		SMITH_AGENT_URI = 'artaka://agents/smith'
		SMITH_MODEL_URI = 'http://matrix.wikia.com/wiki/Quotes_from_The_Matrix_Revolutions'
		SMITH_ACTION_URI = 'http://www.ke.tu-darmstadt.de/ontologies/ui_detail_level.owl#display'
		def initialize
		  super [
			'http://www.ke.tu-darmstadt.de/ontologies/ui_detail_level.owl*'
		  ]
		end
  
		def run
		  super do |channel, msg|
			# byebug
			trigger = JSON.parse(msg)
			puts "Received event on #{channel}"#: #{msg}"
			e = Event.new(
			  parent_id: trigger['id'],
			  session_id: trigger['session_id'],
			  topic_uri: SMITH_AGENT_URI,
			  agent_uri: SMITH_AGENT_URI,
			  action_uri: SMITH_ACTION_URI,
			  model_uri: SMITH_MODEL_URI,
			  parameters: {
				message: 'Illusions, Mr. Anderson. Vagaries of perception.',
				url: SMITH_MODEL_URI
			}
			)
			#   puts e.to_json
			puts "Smith emitting message: #{e.to_json}"
			RedisPublisher.new(session_uri_for(e.session_id), e.to_json).process
		  end
		end
		end
	end
	end
  