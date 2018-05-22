class Place < ActiveRecord::Base
    include PgSearch
    # pg_search_scope :search_by_name, :against => :name
    pg_search_scope :search_by_name_and_description_and_address, against: [:name, :description, :address], using: {
        #   trigram: {},
        tsearch: { prefix: true }
    }

    has_many	:events,	class_name: 'Event', dependent: :destroy

	validates_presence_of	:name

end
