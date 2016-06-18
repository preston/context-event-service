class Actor < ActiveRecord::Base
    belongs_to	:activity
    belongs_to	:participant

    validates_presence_of :activity
    validates_presence_of :participant
end
