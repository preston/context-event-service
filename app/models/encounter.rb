class Encounter < ActiveRecord::Base

	belongs_to :user
	belongs_to :issue
	belongs_to :context

	has_many	:participants, dependent: :destroy

	validates_presence_of	:user
	validates_presence_of	:issue
	validates_presence_of	:context

end
