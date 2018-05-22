class ActivitiesController < ApplicationController
    load_and_authorize_resource class: 'Event'

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
        respond_to do |format|
            if @event.save
                format.json { render :show, status: :created }
            else
                format.json { render json: @event.errors.full_messages, status: :unprocessable_entity }
            end
        end
    end

    def update
        respond_to do |format|
            if @event.update(event_params)
                format.json { render :show, status: :ok }
            else
                format.json { render json: @event.errors.full_messages, status: :unprocessable_entity }
            end
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
        params.require(:event).permit(:parent_id, :name, :topic_uri, :place_id, :next_id, :session_id)
  end
end
