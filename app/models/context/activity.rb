class Context::Activity < ActiveRecord::Base

	belongs_to	:parent,	class_name: 'Context::Activity'
	belongs_to	:next,	class_name: 'Context::Activity'
	belongs_to	:scope,	class_name: 'Context::Activity'
	belongs_to	:place,		class_name: 'Context::Place'

	has_many	:actor_roles,	class_name: 'Context::ActorRole',	dependent: :destroy
	has_many	:usage_roles,	class_name: 'Context::UsageRole',	dependent: :destroy
	has_many	:objectives,	class_name: 'Context::Objective',	dependent: :destroy

	has_many	:child_activities,		class_name: 'Context::Activity',	foreign_key: 'parent_id'
	has_many	:previous_activities,	class_name: 'Context::Activity',	foreign_key: 'next_id'
	has_many	:scoped_activities,		class_name: 'Context::Activity',	foreign_key: 'scope_id'

	# validates_presence_of	:context
	# validates_presence_of	:place
	validates_presence_of	:name

	def self.create_default!(person)
		now = Time.now
		clinical = Context::Activity.create!(name: 'Default', place: Context::Place.first, started_at: now, system: false)
		system = Context::Activity.create!(name: 'Select Patient', parent: clinical, started_at: now, system: true)
		Context::ActorRole.create!(activity: clinical, person: person, semantic_uri: 'uri://example/physician')
		Context::ActorRole.create!(activity: system, person: person, semantic_uri: 'uri://example/system-user')
		asset = Context::Asset.find_or_create_by(uri: 'uri://example/schedule')
		Context::UsageRole.create!(activity: system, asset: asset, semantic_uri: 'uri://example/options')
		clinical
	end

end
