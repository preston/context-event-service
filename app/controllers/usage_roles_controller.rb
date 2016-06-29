class UsageRolesController < ApplicationController
    load_resource	:activity
    load_and_authorize_resource

    def index
        @usage_roles = Context::UsageRole.all
    end

    def show
    end

    def create
        @usage_role = Context::UsageRole.new(usage_role_params)

        respond_to do |format|
            if @usage_role.save
                # format.html { redirect_to @usage_role, notice: 'usage_role was successfully created.' }
                format.json { render :show, status: :created, location: @usage_role }
            else
                # format.html { render :new }
                format.json { render json: @usage_role.errors.full_messages, status: :unprocessable_entity }
            end
        end
    end

    def update
        respond_to do |format|
            if @usage_role.update(usage_role_params)
                # format.html { redirect_to @usage_role, notice: 'usage_role was successfully updated.' }
                format.json { render :show, status: :ok, location: @usage_role }
            else
                # format.html { render :edit }
                format.json { render json: @usage_role.errors.full_messages, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @usage_role.destroy
        respond_to do |format|
            #   format.html { redirect_to usage_roles_url, notice: 'usage_role was successfully destroyed.' }
            format.json { render json: @usage_role }
        end
    end

    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def usage_role_params
        params.require(:usage_role).permit(:activity_id, :semantic_uri, :asset_id)
    end
end
