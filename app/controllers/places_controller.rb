class PlacesController < ApplicationController
    load_and_authorize_resource class: 'Place'

    def index
        @places = Place.paginate(page: params[:page], per_page: params[:per_page])
        @places = @places.search_by_name_and_description_and_address(params[:text]) if params[:text]
      end


    def create
        @place = Place.new(place_params)
        respond_to do |format|
            if @place.save
                #   format.html { redirect_to @place, notice: 'place was successfully created.' }
                format.json { render :show, status: :created, location: @place }
            else
                #   format.html { render :new }
                format.json { render json: @place.errors.full_messages, status: :unprocessable_entity }
            end
        end
    end

    def update
        respond_to do |format|
            if @place.update(place_params)
                #   format.html { redirect_to @place, notice: 'place was successfully updated.' }
                format.json { render :show, status: :ok, location: @place }
            else
                #   format.html { render :edit }
                format.json { render json: @place.errors.full_messages, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @place.destroy
        respond_to do |format|
            format.json { head :no_content }
        end
    end

    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
        params.require(:place).permit(:name, :description, :address)
	end
end
