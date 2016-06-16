class Interest < ActiveRecord::Base

	belongs_to	:role
	belongs_to	:snomedct_concept

    validates_presence_of	:role
    validates_presence_of	:snomedct_concept

    validates_uniqueness_of	:snomedct_concept, scope: [:role_id]

  end
