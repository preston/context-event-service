class Member < ActiveRecord::Base

    belongs_to	:person
    belongs_to	:group

    validates_presence_of	:person
    validates_presence_of	:group

    validates_uniqueness_of	:person_id,	scope: [:group_id]
end
