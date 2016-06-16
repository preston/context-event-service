class Interest < ActiveRecord::Base
    belongs_to	:role

    validates_presence_of	:role
    validates_presence_of	:code

    validates_uniqueness_of	:code,	scope: [:role_id]
  end
