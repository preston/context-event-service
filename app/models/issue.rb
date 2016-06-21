class Issue < ActiveRecord::Base

	belongs_to	:user

	validates_presence_of	:user
	validates_presence_of	:concept_uri

end
