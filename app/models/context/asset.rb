class Context::Asset < ActiveRecord::Base
	include PgSearch
	pg_search_scope :search_by_uri, against: [:uri], using: {
        #   trigram: {},
        # tsearch: { prefix: true }
    }

	has_many	:usage_roles,	class_name: 'Context::UsageRole', dependent: :destroy

	validates_presence_of	:uri
	validates_uniqueness_of	:uri

end
