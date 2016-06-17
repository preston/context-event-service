class WelcomeController < ApplicationController

	skip_before_filter	:authenticate_identity!, only: [:landing]
	skip_authorization_check

	def landing
		@skip_navigation = true
	end

	def dashboard
	end

	def status
		User.first
		json = {}
		jwt = request.headers['Authorization']
		if jwt
			if jwt = JsonWebToken.decode_authorization(jwt)
				if jwt = JsonWebToken.find(jwt['id'])
					json.merge!(
						identity: {
							id: jwt.identity.id,
							user: {
								id: jwt.identity.user.id,
								name: jwt.identity.user.name
							}
						},
						jwt: {id: jwt.id, encoded: jwt.encode}
					)
				end
			end
		end
		json.merge!(
			message: 'This application server and underlying database connection appear to be healthy.',
			datetime: Time.now)
        render json: json, status: :ok
	end

end
