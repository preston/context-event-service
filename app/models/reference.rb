class Reference < ActiveRecord::Base

    belongs_to	:activity
    belongs_to	:asset

    validates_presence_of	:activity
    validates_presence_of	:asset

end
