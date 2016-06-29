class ObjectivesController < ApplicationController

	load_resource	:activity
	load_and_authorize_resource

  def index
    @objectives = Context::Objective.all
  end

  def show
  end

  def create
    @objective = Context::Objective.new(objective_params)

    respond_to do |format|
      if @objective.save
        # format.html { redirect_to @objective, notice: 'objective was successfully created.' }
        format.json { render :show, status: :created, location: @objective }
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
        format.json { render :show, status: :ok, location: @objective }
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
