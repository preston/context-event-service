class EventsController < ApplicationController
    
    skip_before_action :authenticate_identity!
    # load_and_authorize_resource :event #class: 'Event'
    load_resource :event

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
        @event = Event.new(event_params)
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
		begin
        	@event.destroy
        	render :show
		rescue ActiveRecord::InvalidForeignKey => e
       		render :show, status: :unprocessable_entity
		end
	end

    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
        params.require(:event).permit(:parent_id, :session_id, :name, :topic_uri, :model_uri, :controller_uri, :agent_uri, :action_uri, :place_id, :next_id, :session_id)
  end
end
