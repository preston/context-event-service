class Role < ActiveRecord::Base

	has_many	:capabilities,	dependent: :destroy
	has_many	:users, source_type: 'User', 	as: :entity, through: :capabilities,	source: :entity
	has_many	:groups, source_type: 'Group', 	as: :entity, through: :capabilities,	source: :entity

    validates_presence_of	:name
    validates_presence_of	:code

    validates_uniqueness_of	:name
    validates_uniqueness_of	:code
end
