class Context < ActiveRecord::Base

	validates_presence_of	:name

	has_many	:participants, dependent: :destroy
	has_many	:foci, dependent: :destroy

end
