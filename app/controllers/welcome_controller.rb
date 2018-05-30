# frozen_string_literal: true

require 'json'

class WelcomeController < ApplicationController

  skip_before_action :authenticate_identity! #, only: [:landing, :status]
  skip_authorization_check

  def landing
    render
  end

  def status
    json = {}
    jwt = request.headers['Authorization']
    if jwt
      if jwt = Session.decode_authorization(jwt)
        if jwt = Session.find(jwt['id'])
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
