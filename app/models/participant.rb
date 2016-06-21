class Participant < ActiveRecord::Base

	belongs_to	:activity
	belongs_to	:user

	has_many	:responsibilities,	dependent: :destroy

	validates_presence_of	:activity
	validates_presence_of	:user

end
