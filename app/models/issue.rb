class Issue < ActiveRecord::Base

	belongs_to	:user
	belongs_to	:snomedct_concept

	validates_presence_of	:user
	validates_presence_of	:snomedct_concept
	validates_numericality_of	:snomedct_id, only_integer: true

end
