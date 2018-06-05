class Timeline < ActiveRecord::Base

	has_many	:events, dependent: :destroy
	has_many	:sessions, dependent: :destroy

end
