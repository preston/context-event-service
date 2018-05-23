require 'json'
class WelcomeController < ApplicationController

	include ActionController::Live

	skip_before_action	:authenticate_identity! #, only: [:landing]
	skip_authorization_check

	def landing
		render :json
	end

	# http://api.rubyonrails.org/classes/ActionController/Live/SSE.html
	def stream
		if params['topics']
			topics = params['topics'].split(',')
			puts "Live-streaming more topic subscription for: #{topics.join(', ')}"
			response.headers['Content-Type'] = 'text/event-stream'
			sse = SSE.new(response.stream)
			begin
				# Event.on_change do |data|
				# sse.write(data)
				# end
				sub = RedisSubscriber.new(topics)
				sub.process(sse)
				# sse.write({ name: 'John'})
				# sleep 1
				# sse.write({ name: 'John'}, id: 10)
				# sleep 1
				# sse.write({ name: 'John'}, id: 10, event: "other-event")
				# sleep 1
				# sse.write({ name: 'John'}, id: 10, event: "other-event", retry: 500)
			rescue IOError
				# Client Disconnected
				Rails.info "Client disconnected from stream."
			ensure
				Rails.info "Closing client stream."
				sse.close
			end
			render body: nil
		else
			render json: {message: "You must pass a 'topics' array that you wish to stream."}
		end
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
