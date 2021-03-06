class AssetsController < ApplicationController
    load_and_authorize_resource class: 'Asset'

    def index
        @assets = Asset.paginate(page: params[:page], per_page: params[:per_page])
        @assets = @assets.search_by_uri(params[:uri]) if params[:name]
      end

    def create
        @asset = Asset.new(asset_params)
        respond_to do |format|
            if @asset.save
                format.json { render :show, status: :created }
            else
                format.json { render json: @asset.errors.full_messages, status: :unprocessable_entity }
            end
        end
    end

    def update
        respond_to do |format|
            if @asset.update(asset_params)
                format.json { render :show, status: :ok, location: @asset }
            else
                format.json { render json: @asset.errors.full_messages, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @asset.destroy
        respond_to do |format|
            format.json { render :show }
        end
    end

    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def asset_params
        params.require(:asset).permit(:uri)
  end
  end
