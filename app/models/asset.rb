class Asset < ActiveRecord::Base

	has_many	:references, dependent: :destroy

	validates_presence_of	:context
	validates_presence_of	:uri

end
