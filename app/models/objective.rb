class Objective < ActiveRecord::Base
    belongs_to	:event

    validates_presence_of	:event
end
