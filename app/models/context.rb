class Context < ActiveRecord::Base

	validates_presence_of	:name

	has_many	:activities, dependent: :destroy
	has_many	:assets, dependent: :destroy
	has_many	:foci, dependent: :destroy
	has_many	:objectives, dependent: :destroy
	has_many	:participants, dependent: :destroy

end
