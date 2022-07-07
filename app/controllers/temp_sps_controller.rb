class TempSpsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_temp_sp, only: %i[ show edit update destroy ]

  # POST /temp_sps or /temp_sps.json
  def create
    @temp_sp = TempSp.new(temp_sp_params)

    respond_to do |format|
      if @temp_sp.save
        format.html { redirect_to request.referrer, notice: "Spazio inserito correttamente." }
        format.js {render inline: "location.reload();" }
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
        format.html { redirect_to request.referrer, notice: "Spazio aggiornato correttamente." }
        format.js {render inline: "location.reload();" }
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
      format.html { redirect_to request.referrer, notice: "Spazio rimosso correttamente." }
      format.js {render inline: "location.reload();" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_temp_sp
      @temp_sp = TempSp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def temp_sp_params
      params.require(:temp_sp).permit(:temp_dep_id, :dep_name, :typology, :name, :description, :floor, :number_of_seats, :state)
    end
end
