class Participant < ActiveRecord::Base

	belongs_to	:encounter
	belongs_to	:user

	validates_presence_of	:encounter
	validates_presence_of	:user

end
