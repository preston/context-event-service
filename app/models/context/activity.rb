class Context::Activity < ActiveRecord::Base

	belongs_to	:parent,	class_name: 'Context::Activity'
	belongs_to	:previous,	class_name: 'Context::Activity'
	belongs_to	:context,	class_name: 'Context::Activity'
	belongs_to	:place,		class_name: 'Context::Place'

	has_many	:actor_roles,	class_name: 'Context::ActorRole',	dependent: :destroy
	has_many	:usage_roles,	class_name: 'Context::UsageRole',	dependent: :destroy
	has_many	:objectives,	class_name: 'Context::Objective',	dependent: :destroy

	has_many	:child_activities,		class_name: 'Context::Activity',	foreign_key: 'parent_id'
	has_many	:subsequent_activities,	class_name: 'Context::Activity',	foreign_key: 'previous_id'
	has_many	:contexts,				class_name: 'Context::Activity',	foreign_key: 'context_id'

	# validates_presence_of	:context
	validates_presence_of	:place
	validates_presence_of	:name


end
