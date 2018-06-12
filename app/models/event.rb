# frozen_string_literal: true

class Event < ActiveRecord::Base
  include Context::Session

  belongs_to  :person, optional: true
  belongs_to  :session, optional: true
	belongs_to  :timeline, optional: true

	belongs_to  :parent,  class_name: 'Event', optional: true
  belongs_to  :next, class_name: 'Event', optional: true

  has_many  :child_events, class_name: 'Event',	foreign_key: 'parent_id'
  has_many  :previous_events, class_name: 'Event',	foreign_key: 'next_id'

  validates_presence_of  :topic_uri
  validates_presence_of  :model_uri

  after_save do |e|
    puts "About to broadcast events for: #{e.to_json}"
    channels = [
      e.topic_uri,
      e.model_uri,
      e.controller_uri,
      e.agent_uri,
      e.action_uri
    ]
    if e.session_id
      channels.push(SESSION_URI_PREFIX)
      channels.push(session_uri_for(e.session_id)) if e.session_id
    end
    channels = channels.uniq.reject(&:nil?)
    channels.each do |c|
      publish_to_broker(e, c)
    end
  end

  def publish_to_broker(e, channel)
    if channel # it's not nil
      RedisPublisher.new(channel, e.to_json).process
      puts "Publishing event to channel: #{channel}"
    else
      puts "No channel provided for: #{e}"
    end
  end

	def self.purge_older_than(datetime, *topics)
		# To avoid foreign key violates, we'll nullify every prior to delete.
		# topics.each do |topic|
		# end
		
		# Auto-commit to avoid locking the table, which is extremely hot, we'll autocommit after every delete.
    # Event.transaction do
    topics.each do |topic|
			puts "Removing foreign key references from old events on topic #{topic}..."
      Event.where('topic_uri = ? AND created_at < ?', topic, datetime).update_all(parent_id: nil, next_id: nil)
			puts "Purging old events on topic #{topic}..."
			while (batch = Event.where('topic_uri = ? AND created_at < ?', topic, datetime).limit(10)).count > 0
				batch.each do |n|
					begin
						# Remove inbound references.
						n.child_events.update(parent_id: nil)
						n.previous_events.update(next_id: nil)
						# n.child_events.destroy
						# n.previous_events.destroy
						# n.parent.destroy if n.parent
						# n.next.destroy if n.next
						n.destroy
					rescue
						puts "Failed to destroy event #{n.id} on this pass."
					end
				end
			end
    end
    # end
  end
end
