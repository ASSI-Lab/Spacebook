class SeatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_seat, only: %i[ show edit update destroy ]

  # POST /seats or /seats.json
  def create
    @seat = Seat.new(seat_params)

    respond_to do |format|
      if @seat.save
        # format.html { redirect_to seat_url(@seat), notice: "Seat was successfully created." }
        # format.json { render :show, status: :created, location: @seat }
        format.html { redirect_to request.referrer, notice: "Posto creato." }
        format.js {render inline: "location.reload();" }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @seat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seats/1 or /seats/1.json
  def update
    respond_to do |format|
      if @seat.update(seat_params)
        # format.html { redirect_to seat_url(@seat), notice: "Seat was successfully updated." }
        # format.json { render :show, status: :ok, location: @seat }
        format.html { redirect_to request.referrer, notice: "Disponibilità posto aggiornata." }
        format.js {render inline: "location.reload();" }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @seat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seats/1 or /seats/1.json
  def destroy
    @seat.destroy

    respond_to do |format|
      #format.html { redirect_to seats_url, notice: "Seat was successfully destroyed." }
      #format.json { head :no_content }
      format.html { redirect_to request.referrer, notice: "Posto eliminato." }
      format.js {render inline: "location.reload();" }
    end
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
