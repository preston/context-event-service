# frozen_string_literal: true

class Event < ActiveRecord::Base
  include Context::Session

  belongs_to  :person, optional: true
  belongs_to  :session, optional: true
  belongs_to  :parent,  class_name: 'Event', optional: true
  belongs_to  :next, class_name: 'Event', optional: true
  belongs_to  :scope, class_name: 'Event', optional: true

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
    # Auto-commit to avoid locking the table, which is extremely hot.
	# Event.transaction do
	topics.each do |topic|
		Event.where('topic_uri = ? AND created_at < ?', topic, datetime).destroy_all
	end
    # .limit(32)
    # end
  end
end
