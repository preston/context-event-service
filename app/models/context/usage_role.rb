class Context::UsageRole < ActiveRecord::Base

    belongs_to	:activity,	class_name: 'Context::Activity'
    belongs_to	:asset,		class_name: 'Context::Asset'

    validates_presence_of	:activity
    validates_presence_of	:asset

end
