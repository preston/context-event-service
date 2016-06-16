class Participant < ActiveRecord::Base

	belongs_to	:context
	belongs_to	:user

	validates_presence_of	:context
	validates_presence_of	:user

end
