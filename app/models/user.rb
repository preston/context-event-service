class User < ActiveRecord::Base
    include PgSearch
    # pg_search_scope :search_by_name, :against => :name
    pg_search_scope :search_by_name_or_email, against: [:name, :email], using: {
        #   trigram: {},
        tsearch: { prefix: true }
    }

    has_many	:memberships,	class_name: 'Member',	dependent: :destroy
    has_and_belongs_to_many	:groups,	join_table: :members

    has_many	:individual_capabilities,	class_name: 'Capability',	as: :entity,	dependent: :destroy
    has_many	:individual_roles,	class_name: 'Role',	through: :individual_capabilities,	source: :role

    has_many :identities, dependent: :destroy
    has_many	:issues,	dependent: :destroy
    has_many	:results, dependent: :destroy
	has_many	:participants, dependent: :destroy
	has_many	:foci, dependent: :destroy

    # has_and_belongs_to_many	:problems,	class_name:	'Problem',	join_table: :issues

    validates_presence_of :name
end
