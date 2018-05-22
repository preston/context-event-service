class System::IdentityProvidersController < ApplicationController

    skip_before_action	:authenticate_identity! #,	except: :destroy
    skip_authorization_check

    def launch
        
	end

end
