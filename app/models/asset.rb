class Asset < ActiveRecord::Base

	belongs_to	:context

	validates_presence_of	:context
	validates_presence_of	:uri

end
