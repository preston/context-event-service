class Objective < ActiveRecord::Base
    belongs_to	:activity

    validates_presence_of	:activity
end
