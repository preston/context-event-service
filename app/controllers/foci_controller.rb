class FociController < ApplicationController
	
  before_action :set_focus, only: [:show, :edit, :update, :destroy]

  # GET /foci
  # GET /foci.json
  def index
    @foci = Focus.all
  end

  # GET /foci/1
  # GET /foci/1.json
  def show
  end

  # GET /foci/new
  def new
    @focus = Focus.new
  end

  # GET /foci/1/edit
  def edit
  end

  # POST /foci
  # POST /foci.json
  def create
    @focus = Focus.new(focus_params)

    respond_to do |format|
      if @focus.save
        format.html { redirect_to @focus, notice: 'Focus was successfully created.' }
        format.json { render :show, status: :created, location: @focus }
      else
        format.html { render :new }
        format.json { render json: @focus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /foci/1
  # PATCH/PUT /foci/1.json
  def update
    respond_to do |format|
      if @focus.update(focus_params)
        format.html { redirect_to @focus, notice: 'Focus was successfully updated.' }
        format.json { render :show, status: :ok, location: @focus }
      else
        format.html { render :edit }
        format.json { render json: @focus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foci/1
  # DELETE /foci/1.json
  def destroy
    @focus.destroy
    respond_to do |format|
      format.html { redirect_to foci_url, notice: 'Focus was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_focus
      @focus = Focus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def focus_params
      params.require(:focus).permit(:context_id, :snomedct_id)
    end
end
