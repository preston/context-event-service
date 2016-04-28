class WelcomeController < OpenIdConnectController

	skip_before_filter	:authenticate_user!, only: [:landing]
	skip_authorization_check

	def landing
	end

	def dashboard
	end

end
