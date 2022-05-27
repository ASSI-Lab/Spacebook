class QuickReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quick_reservation, only: %i[ show edit update destroy ]

  # GET /quick_reservations or /quick_reservations.json
  def index
    @quick_reservations = QuickReservation.all
  end

  # GET /quick_reservations/1 or /quick_reservations/1.json
  def show
  end

  # GET /quick_reservations/new
  def new
    @quick_reservation = QuickReservation.new
  end

  # GET /quick_reservations/1/edit
  def edit
  end

  # POST /quick_reservations or /quick_reservations.json
  def create
    @quick_reservation = QuickReservation.new(quick_reservation_params)

    respond_to do |format|
      if @quick_reservation.save
        format.html { redirect_to quick_reservation_url(@quick_reservation), notice: "Quick reservation was successfully created." }
        format.json { render :show, status: :created, location: @quick_reservation }
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
      format.html { redirect_to quick_reservations_url, notice: "Quick reservation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quick_reservation
      @quick_reservation = QuickReservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quick_reservation_params
      params.require(:quick_reservation).permit(:email, :department, :typology, :space)
    end
end
