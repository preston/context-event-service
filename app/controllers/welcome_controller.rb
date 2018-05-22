class WelcomeController < ApplicationController

	skip_before_action	:authenticate_identity!, only: [:landing]
	skip_authorization_check

	def landing
		@skip_navigation = true
	end

	def dashboard
	end

	def status
		json = {}
		jwt = request.headers['Authorization']
		if jwt
			if jwt = JsonWebToken.decode_authorization(jwt)
				if jwt = JsonWebToken.find(jwt['id'])
					event = Event.create_default!(jwt.identity.person)
					json.merge!(
						event: {
							id: event.id,
							path: event_path(event),
							url: event_url(event)
						},
						identity: {
							id: jwt.identity.id,
							person: {
								id: jwt.identity.person.id,
								name: jwt.identity.person.name,
								url: person_url(jwt.identity.person),
								path: person_path(jwt.identity.person)
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
