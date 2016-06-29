class Context::ActorRole < ActiveRecord::Base
	belongs_to	:activity,	class_name: 'Context::Activity'
    belongs_to	:person,	class_name: 'System::Person'

    validates_presence_of :activity
    validates_presence_of :person
    validates_presence_of :semantic_uri

	validates_uniqueness_of	:semantic_uri,	scope: [:activity_id, :person_id], message: 'instance may only be applied once per person-actor role association'

end
