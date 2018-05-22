class Session < ActiveRecord::Base

	belongs_to	:identity
	has_many	:events,	dependent: :destroy
	
	validates_presence_of	:identity

end
