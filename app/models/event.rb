class Event < ActiveRecord::Base

	belongs_to	:person, optional: true
	belongs_to	:place, optional: true
	belongs_to	:parent,	class_name: 'Event', optional: true
	belongs_to	:next,	class_name: 'Event', optional: true
	belongs_to	:scope,	class_name: 'Event', optional: true

	has_many	:objectives,	dependent: :destroy

	has_many	:child_events,		class_name: 'Event',	foreign_key: 'parent_id'
	has_many	:previous_events,	class_name: 'Event',	foreign_key: 'next_id'
	has_many	:scoped_events,		class_name: 'Event',	foreign_key: 'scope_id'

	validates_presence_of	:topic_uri
	validates_presence_of	:model_uri

end
