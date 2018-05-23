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
		publish_to_broker(e, :topic_uri)
		publish_to_broker(e, :model_uri)
		publish_to_broker(e, :controller_uri)
		publish_to_broker(e, :agent_uri)
		publish_to_broker(e, :action_uri)
	end

	def publish_to_broker(e, sym)
		channel = e.send(sym)
		if channel # it's not nil
			RedisPublisher.new(channel, e.to_json).process
			puts "PUBLISHED #{sym} TO CHANNEL #{channel}: #{e.to_json}"
		else
			puts "NO #{sym} VALUE TO PUBLISH"
		end
	end

end
