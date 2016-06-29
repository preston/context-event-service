class ActorRolesController < ApplicationController

	load_resource	:activity
	load_and_authorize_resource

  def index
    @actor_roles = Context::ActorRole.all
  end

  def show
  end

  def create
    @actor_role = Context::ActorRole.new(actor_role_params)

    respond_to do |format|
      if @actor_role.save
        # format.html { redirect_to @actor_role, notice: 'actor_role was successfully created.' }
        format.json { render :show, status: :created, location: @actor_role }
      else
        # format.html { render :new }
        format.json { render json: @actor_role.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @actor_role.update(actor_role_params)
        # format.html { redirect_to @actor_role, notice: 'actor_role was successfully updated.' }
        format.json { render :show, status: :ok, location: @actor_role }
      else
        # format.html { render :edit }
        format.json { render json: @actor_role.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @actor_role.destroy
    respond_to do |format|
    #   format.html { redirect_to actor_roles_url, notice: 'actor_role was successfully destroyed.' }
      format.json { render json: @actor_role }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def actor_role_params
      params.require(:actor_role).permit(:activity_id, :semantic_uri, :person_id)
    end
end
