class SeatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_seat, only: %i[ show edit update destroy ]

  def create
    @seat = Seat.new(seat_params)

    respond_to do |format|
      if @seat.save
        puts("Posto "+@seat.id+" creato.")
      else
        format.html { redirect_to request.referrer, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|

      if @seat.update(seat_params)
        flash[:alert] = "Disponibilità posto aggiornata."
      else
        format.html { redirect_to request.referrer, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @seat.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seat
      @seat = Seat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def seat_params
      params.require(:seat).permit(:space_id, :dep_name, :typology, :space_name, :position, :start_date, :end_date, :state)
    end
end
