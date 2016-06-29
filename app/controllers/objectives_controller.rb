class ObjectivesController < ApplicationController
    load_resource	:activity,	class: 'Context::Activity'
    load_and_authorize_resource	class: 'Context::Objective'

    def index
        @objectives = Context::Objective.all
    end

    def show
    end

    def create
        @objective = Context::Objective.new(objective_params)
        @objective.activity_id = params['activity_id']
        respond_to do |format|
            if @objective.save
                # format.html { redirect_to @objective, notice: 'objective was successfully created.' }
                format.json { render :show, status: :created }
            else
                # format.html { render :new }
                format.json { render json: @objective.errors.full_messages, status: :unprocessable_entity }
            end
        end
    end

    def update
        respond_to do |format|
            if @objective.update(objective_params)
                # format.html { redirect_to @objective, notice: 'objective was successfully updated.' }
                format.json { render :show, status: :ok }
            else
                # format.html { render :edit }
                format.json { render json: @objective.errors.full_messages, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @objective.destroy
        respond_to do |format|
            #   format.html { redirect_to objectives_url, notice: 'objective was successfully destroyed.' }
            format.json { render json: @objective }
        end
    end

    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def objective_params
        params.require(:objective).permit(:activity_id, :formalized, :language, :semantic_uri, :specification, :comment)
    end
end
