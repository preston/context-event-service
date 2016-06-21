class Interest < ActiveRecord::Base

	belongs_to	:group

    validates_presence_of	:group
    validates_presence_of	:concept_uri

    validates_uniqueness_of	:concept_uri, scope: [:group_id]

  end
