class User < ActiveRecord::Base
    include PgSearch
    # pg_search_scope :search_by_name, :against => :name
    pg_search_scope :search_by_name_or_email, against: [:name, :email], using: {
        #   trigram: {},
        tsearch: { prefix: true }
    }

    has_many    :identities,    dependent: :destroy
    has_many	:issues,	dependent: :destroy
    has_many	:labs, dependent: :destroy
    has_many	:encounters, dependent: :destroy

    has_and_belongs_to_many	:problems,	class_name:	'Problem',	join_table: :issues

    validates_presence_of :name

    # attr_accessor :password
    #
    # def password=(password)
    #     self.password_hash = User.compute_hash(password)
    # end
    #
    # def self.compute_hash(password)
    #     h = nil
    #     if password
    #
    #         salt = Rails.application.secrets[:healthcreek_password_salt]
    #         h = Digest::SHA256.hexdigest(salt + password)
    #     end
    #     h
    # end
    #
    # # Returns self iff the password is correct, or falsey otherwise.
    # def authenticate(password)
    #     match = password_hash == User.compute_hash(password)
    #     match ? self : nil
    # end
end
