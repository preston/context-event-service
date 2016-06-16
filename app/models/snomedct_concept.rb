class SnomedctConcept < ActiveRecord::Base

	has_many	:interests,	dependent: :destroy
	has_many	:foci,	dependent: :destroy
	has_many	:snomedct_descriptions,	dependent: :destroy

	validates_presence_of	:snomedct_id
	validates_uniqueness_of	:snomedct_id

end
