class Identity < ActiveRecord::Base

	belongs_to	:person
	belongs_to	:identity_provider

	has_many	:sessions,	dependent: :destroy

	validates_presence_of	:person
	validates_presence_of	:identity_provider
	validates_presence_of	:sub

	validates_uniqueness_of	:sub, scope: [:identity_provider_id]

end
