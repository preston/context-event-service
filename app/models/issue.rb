class Issue < ActiveRecord::Base

	belongs_to	:user

	validates_presence_of	:user
	validates_presence_of	:snomedct_id
	validates_numericality_of	:snomedct_id, only_integer: true	

end
