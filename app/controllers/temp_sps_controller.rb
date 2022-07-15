class TempSpsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_temp_sp, only: %i[ show edit update destroy ]

  def create
    @temp_sp = TempSp.new(temp_sp_params)

    respond_to do |format|
      if @temp_sp.save
        format.html { redirect_to request.referrer, notice: "Spazio inserito correttamente" }
      else
        format.html { redirect_to request.referrer, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @temp_sp.update(temp_sp_params)
        format.html { redirect_to request.referrer, notice: "Spazio aggiornato correttamente." }
      else
        format.html { redirect_to request.referrer, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @temp_sp.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer, notice: "Spazio rimosso correttamente." }
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
