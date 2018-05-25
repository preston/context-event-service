# frozen_string_literal: true

require 'json'

class WelcomeController < ApplicationController
  include ActionController::Live
  include Context::Session

  skip_before_action :authenticate_identity!, only: [:landing, :status]
  skip_authorization_check

  def landing
    render :json
  end

  # http://api.rubyonrails.org/classes/ActionController/Live/SSE.html
  def stream
    if params['channels']
      channels = params['channels'].split(',')
      channels.push(SESSION_URI_PREFIX + "/#{@current_jwt.id}") if @current_jwt
      channels.uniq!
      puts "Live-streaming channel subscriptions for: #{channels.join(', ')}"
      response.headers['Content-Type'] = 'text/event-stream'
      sse = SSE.new(response.stream)
      begin
        # Event.on_change do |data|
        # sse.write(data)
        # end
        sub = RedisSubscriber.new(channels)
        sub.process(sse)
      rescue IOError
        # Client Disconnected
        Rails.info 'Client disconnected from stream.'
      ensure
        Rails.info 'Closing client stream.'
        sse.close
      end
      render body: nil
    else
      render json: { message: "You must pass a 'channels' array that you wish to stream." }
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
            jwt: { id: jwt.id, encoded: jwt.encode }
          )
        end
      end
    end
    json[:message] = 'This application server and underlying database connection appear to be healthy.'
    json[:datetime] = Time.now
    render json: json, status: :ok
  end
end
