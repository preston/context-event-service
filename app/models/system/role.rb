class System::Role < ActiveRecord::Base

	has_many	:capabilities,	dependent: :destroy
	has_many	:persons, source_type: 'Person', 	as: :entity, through: :capabilities,	source: :entity
	has_many	:groups, source_type: 'Group', 	as: :entity, through: :capabilities,	source: :entity

    validates_presence_of	:name
    validates_presence_of	:code

    validates_uniqueness_of	:name
    validates_uniqueness_of	:code
end
