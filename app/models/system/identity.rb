class System::Identity < ActiveRecord::Base

	belongs_to	:person
	belongs_to	:provider

	has_many	:sessions,	dependent: :destroy
	has_many	:json_web_tokens,	dependent: :destroy

	validates_presence_of	:person
	validates_presence_of	:provider
	validates_presence_of	:sub

	validates_uniqueness_of	:sub, scope: [:provider_id]

end
