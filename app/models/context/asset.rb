class Context::Asset < ActiveRecord::Base

	has_many	:usage_roles,	class_name: 'Context::UsageRole', dependent: :destroy

	validates_presence_of	:context
	validates_presence_of	:uri

end
