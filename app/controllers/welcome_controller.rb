class WelcomeController < OpenIdConnectController

	skip_before_filter	:authenticate_user!, only: [:landing]
	skip_authorization_check

	def landing
		@skip_navigation = true
	end

	def dashboard
	end

end
