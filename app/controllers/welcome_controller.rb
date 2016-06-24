class WelcomeController < ApplicationController

	skip_before_filter	:authenticate_identity!, only: [:landing]
	skip_authorization_check

	def landing
		@skip_navigation = true
	end

	def dashboard
	end

	def status
		Person.first
		json = {}
		jwt = request.headers['Authorization']
		if jwt
			if jwt = JsonWebToken.decode_authorization(jwt)
				if jwt = JsonWebToken.find(jwt['id'])
					json.merge!(
						identity: {
							id: jwt.identity.id,
							person: {
								id: jwt.identity.person.id,
								name: jwt.identity.person.name
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
