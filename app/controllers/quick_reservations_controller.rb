class QuickReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quick_reservation, only: %i[ show edit update destroy ]

  # POST /quick_reservations or /quick_reservations.json
  def create
    @quick_reservation = QuickReservation.new(quick_reservation_params)

    respond_to do |format|
      if @quick_reservation.save
        #format.html { redirect_to quick_reservation_url(@quick_reservation), notice: "Quick reservation was successfully created." }
        #format.json { render :show, status: :created, location: @quick_reservation }
        format.html { redirect_to request.referrer, notice: "Lo spazio è stato impostato come prenotazione rapida" }
        format.js {render inline: "location.reload();" }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quick_reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quick_reservations/1 or /quick_reservations/1.json
  def update
    respond_to do |format|
      if @quick_reservation.update(quick_reservation_params)
        format.html { redirect_to quick_reservation_url(@quick_reservation), notice: "Quick reservation was successfully updated." }
        format.json { render :show, status: :ok, location: @quick_reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quick_reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quick_reservations/1 or /quick_reservations/1.json
  def destroy
    @quick_reservation.destroy

    respond_to do |format|
      #format.html { redirect_to quick_reservations_url, notice: "Quick reservation was successfully destroyed." }
      #format.json { head :no_content }
      format.html { redirect_to request.referrer }
      format.js {render inline: "location.reload();" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quick_reservation
      @quick_reservation = QuickReservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quick_reservation_params
      params.require(:quick_reservation).permit(:user_id, :department_id, :space_id, :email, :dep_name, :typology, :space_name)
    end
end
