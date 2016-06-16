class SnomedctDescription < ActiveRecord::Base

	belongs_to				:snomedct_concept
	validates_presence_of	:snomedct_concept

	validates_presence_of	:snomedct_id
	validates_uniqueness_of	:snomedct_id

end
