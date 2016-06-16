class Focus < ActiveRecord::Base

	belongs_to	:context

	validates_presence_of	:context
	validates_presence_of	:snomedct_id

end
