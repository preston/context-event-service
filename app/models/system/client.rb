class System::Client < ActiveRecord::Base

	validates_presence_of	:name
	validates_presence_of	:launch_url

end
