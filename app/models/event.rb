class Event < ActiveRecord::Base

	belongs_to	:person, optional: true
	belongs_to	:place, optional: true
	belongs_to	:session, optional: true
	belongs_to	:parent,	class_name: 'Event', optional: true
	belongs_to	:next,	class_name: 'Event', optional: true
	belongs_to	:scope,	class_name: 'Event', optional: true

	has_many	:objectives,	dependent: :destroy

	has_many	:child_events,		class_name: 'Event',	foreign_key: 'parent_id'
	has_many	:previous_events,	class_name: 'Event',	foreign_key: 'next_id'
	has_many	:scoped_events,		class_name: 'Event',	foreign_key: 'session_id'

	validates_presence_of	:topic_uri
	validates_presence_of	:model_uri

	after_save do |e|
		puts "AFTER SAVE: #{e.to_json}"
		channels = [
			e.topic_uri,
			e.model_uri,
			e.controller_uri,
			e.agent_uri,
			e.action_uri
		]
		channels.push(Context::Session::SESSION_URI_PREFIX)
		if(e.session_id)
			channels.push("#{Context::Session::SESSION_URI_PREFIX}/#{e.session_id}")
		end
		channels = channels.uniq.reject(&:nil?)
		channels.each do |c|
			publish_to_broker(e, c)
		end
	end

	def publish_to_broker(e, channel)
		if channel # it's not nil
			RedisPublisher.new(channel, e.to_json).process
			puts "Publishing event to channel #{channel}: #{e.to_json}"
		else
			puts "No channel provided for publication of event: #{e}"
		end
	end

end
