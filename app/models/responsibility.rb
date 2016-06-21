class Responsibility < ActiveRecord::Base
	belongs_to	:activity
    belongs_to	:participant

    validates_presence_of :activity
    validates_presence_of :participant
    validates_presence_of :semantic_uri
end
