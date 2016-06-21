class SnomedctConcept < ActiveRecord::Base

	include PgSearch
    pg_search_scope :search_by_snomedct_id, against: :snomedct_id, using: {
        #   trigram: {},
        tsearch: { prefix: true }
    }

	has_many	:descriptions, class_name: 'SnomedctDescription',	dependent: :destroy

	validates_presence_of	:snomedct_id
	validates_uniqueness_of	:snomedct_id

end
