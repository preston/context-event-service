class Objective < ActiveRecord::Base
    belongs_to	:context

    validates_presence_of	:context
end
