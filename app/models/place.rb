class Place < ActiveRecord::Base

	has_many	:activities, dependent: :destroy

end
