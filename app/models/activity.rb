class Activity < ActiveRecord::Base

	belongs_to	:context
	belongs_to	:place
	has_many	:actors, dependent: :destroy

	validates_presence_of	:context
	validates_presence_of	:place
end
