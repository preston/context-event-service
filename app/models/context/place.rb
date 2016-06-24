class Context::Place < ActiveRecord::Base

	has_many	:activities,	class_name: 'Context::Activity', dependent: :destroy

end
