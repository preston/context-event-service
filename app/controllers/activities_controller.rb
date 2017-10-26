class ActivitiesController < ApplicationController
    load_and_authorize_resource class: 'Context::Activity'

    def index
        @activities = Context::Activity.paginate(page: params[:page], per_page: params[:per_page])
        if params[:role]
            @activities = @activities.joins(activities: :role).where('roles.code = ?', params[:role])
        end
        # sort = %w(name external_id).include?(params[:sort]) ? params[:sort] : :name
        # order = 'desc' == params[:order] ? :desc : :asc
        # @activities = @activities.order(sort => order)
        # if params[:external_id] # External IDs are not gauranteed to be unique, so we may have multiple results.
        #     @activities = @activities.where('external_id = ?', params[:external_id])
        # end
        @activities = @activities.search_by_name(params[:name]) if params[:name]
      end

    def create
        @activity = Context::Activity.new(activity_params)
        respond_to do |format|
            if @activity.save
                #   format.html { redirect_to @activity, notice: 'activity was successfully created.' }
                format.json { render :show, status: :created }
            else
                #   format.html { render :new }
                format.json { render json: @activity.errors.full_messages, status: :unprocessable_entity }
            end
        end
    end

    def update
        respond_to do |format|
            if @activity.update(activity_params)
                #   format.html { redirect_to @activity, notice: 'activity was successfully updated.' }
                format.json { render :show, status: :ok }
            else
                #   format.html { render :edit }
                format.json { render json: @activity.errors.full_messages, status: :unprocessable_entity }
            end
        end
    end

    def destroy
		begin
        	@activity.destroy
        	render :show
		rescue ActiveRecord::InvalidForeignKey => e
       		render :show, status: :unprocessable_entity
		end
	end

    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
        params.require(:activity).permit(:parent_id, :name, :description, :started_at, :ended_at, :semantic_uri, :place_id, :system, :next_id, :scope_id)
  end
end
