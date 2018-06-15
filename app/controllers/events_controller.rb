# frozen_string_literal: true

class EventsController < ApplicationController
  include ActionController::Live
  include Context::Session
  # skip_before_action :authenticate_identity!
  # load_and_authorize_resource :event #class: 'Event'
  load_resource :event, except: [:stream]

  # http://api.rubyonrails.org/classes/ActionController/Live/SSE.html
  def stream
    if params['channels']
      channels = params['channels'].split(',')
      channels.push(session_uri_for(@current_jwt.id)) if @current_jwt
      channels.uniq!
      puts "Live-streaming channel subscriptions for: #{channels.join(', ')}"
      response.headers['Content-Type'] = 'text/event-stream'
      sse = SSE.new(response.stream)
      begin
        # Event.on_change do |data|
        # sse.write(data)
        # end
        sub = RedisSubscriber.new(channels)
        sub.process do |channel, message|
          # puts "SENDING: #{message}"
          # byebug
          tmp = JSON.parse(message)
          if tmp['agent_uri'] # Something intended for the client
            sse.write(message)
          else # Likely client echo traffic
            # Ignore it
          end            
        end
      rescue IOError
        # Client Disconnected
        puts 'Client disconnected from stream.'
      ensure
        puts 'Closing client stream.'
        sse.close
      end
      render body: nil
    else
      render json: { message: "You must pass a 'channels' array that you wish to stream." }
    end
  end

  def index
    @events = Event.paginate(page: params[:page], per_page: params[:per_page])
    if params[:role]
      @events = @events.joins(events: :role).where('roles.code = ?', params[:role])
    end
    # sort = %w(name external_id).include?(params[:sort]) ? params[:sort] : :name
    # order = 'desc' == params[:order] ? :desc : :asc
    # @events = @events.order(sort => order)
    # if params[:external_id] # External IDs are not gauranteed to be unique, so we may have multiple results.
    #     @events = @events.where('external_id = ?', params[:external_id])
    # end
    @events = @events.search_by_name(params[:name]) if params[:name]
    end

	def create
		puts request.body.read
		@event = Event.new(event_params)
		puts @event
		# Not sure why .permit won't accept JSON parameter fields, so we'll copy it manually for now.
    @event.parameters = params['parameters']
    @event.person = @current_person

    # TODO: Should only allow agents to override the session information.
    @event.session = @current_jwt unless @event.session_id
    if @event.save
      render :show, status: :created
    else
      render json: @event.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      render :show, status: :ok
    else
      render json: @event.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    render :show
rescue ActiveRecord::InvalidForeignKey => e
  render :show, status: :unprocessable_entity
end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:parent_id, :session_id, :name, :timeline_id, :topic_uri, :model_uri, :controller_uri, :agent_uri, :action_uri, :place_id, :next_id, :person_id, :parameters)
end

end
