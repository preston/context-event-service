class Identity < ActiveRecord::Base

	belongs_to	:user
	belongs_to	:provider

	has_many	:sessions,	dependent: :destroy

	validates_presence_of	:user
	validates_presence_of	:provider
	validates_presence_of	:sub

	validates_uniqueness_of	:sub, scope: [:provider_id]

end
