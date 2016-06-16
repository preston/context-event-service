class Focus < ActiveRecord::Base

	belongs_to	:context
	belongs_to	:snomedct_concept

	validates_presence_of	:context
	validates_presence_of	:snomedct_concept

end
