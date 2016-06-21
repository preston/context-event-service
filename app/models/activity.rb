class Activity < ActiveRecord::Base

	belongs_to	:parent,	class_name: 'Activity'
	belongs_to	:previous,	class_name: 'Activity'
	belongs_to	:context,	class_name: 'Activity'
	belongs_to	:place

	has_many	:responsibilities, dependent: :destroy
	has_many	:references, dependent: :destroy
	has_many	:objectives, dependent: :destroy
	has_many	:participants, dependent: :destroy

	has_many	:child_activities,	class_name: 'Activity',	foreign_key: 'parent_id'
	has_many	:subsequent_activities,	class_name: 'Activity',	foreign_key: 'previous_id'
	has_many	:contexts,	class_name: 'Activity',	foreign_key: 'context_id'

	# validates_presence_of	:context
	validates_presence_of	:place
	validates_presence_of	:name


end
