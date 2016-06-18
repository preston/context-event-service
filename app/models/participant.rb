class Participant < ActiveRecord::Base

	belongs_to	:context
	belongs_to	:user

	has_many	:responsibilities,	class_name: 'Actor',	dependent: :destroy

	validates_presence_of	:context
	validates_presence_of	:user

end
