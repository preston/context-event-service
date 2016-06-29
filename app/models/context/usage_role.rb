class Context::UsageRole < ActiveRecord::Base

    belongs_to	:activity,	class_name: 'Context::Activity'
    belongs_to	:asset,		class_name: 'Context::Asset'

    validates_presence_of	:activity
    validates_presence_of	:asset
	validates_presence_of	:semantic_uri

	validates_uniqueness_of	:semantic_uri,	scope: [:activity_id, :asset_id], message: 'instance may only be applied once per asset/role association'

end
