class Focus < ActiveRecord::Base

	belongs_to	:context
	belongs_to	:user
	belongs_to	:snomedct_concept

	validates_presence_of	:context

end
