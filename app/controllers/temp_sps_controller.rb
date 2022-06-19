class TempSpsController < ApplicationController
  before_action :set_temp_sp, only: %i[ show edit update destroy ]

  # GET /temp_sps or /temp_sps.json
  def index
    @temp_sps = TempSp.all
  end

  # GET /temp_sps/1 or /temp_sps/1.json
  def show
  end

  # GET /temp_sps/new
  def new
    @temp_sp = TempSp.new
  end

  # GET /temp_sps/1/edit
  def edit
  end

  # POST /temp_sps or /temp_sps.json
  def create
    @temp_sp = TempSp.new(temp_sp_params)

    respond_to do |format|
      if @temp_sp.save
        format.html { redirect_to temp_sp_url(@temp_sp), notice: "Temp sp was successfully created." }
        format.json { render :show, status: :created, location: @temp_sp }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @temp_sp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /temp_sps/1 or /temp_sps/1.json
  def update
    respond_to do |format|
      if @temp_sp.update(temp_sp_params)
        format.html { redirect_to temp_sp_url(@temp_sp), notice: "Temp sp was successfully updated." }
        format.json { render :show, status: :ok, location: @temp_sp }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @temp_sp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /temp_sps/1 or /temp_sps/1.json
  def destroy
    @temp_sp.destroy

    respond_to do |format|
      format.html { redirect_to temp_sps_url, notice: "Temp sp was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_temp_sp
      @temp_sp = TempSp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def temp_sp_params
      params.require(:temp_sp).permit(:dep_name, :typology, :name, :floor, :number_of_seats, :state)
    end
end
