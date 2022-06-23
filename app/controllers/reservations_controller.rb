class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: %i[ show edit update destroy ]

  # GET /reservations or /reservations.json
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1 or /reservations/1.json
  def show
    authorize! :show, @reservation, :message => "Attenzione: Non sei autorizzato a visualizzare la prenotazione."
  end

  # GET /reserved
  def reserved
    @reservations = Reservation.where(email: current_user.email)
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
    authorize! :edit, @reservation, :message => "Attenzione: Non sei autorizzato a modificare la prenotazione."
  end

  # POST /reservations or /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)
    authorize! :create, @reservation, :message => "Attenzione: Non sei autorizzato ad effettuare una nuova prenotazione."

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to '/user_reservations', notice: "Prenotazione effettuata correttamente." }
        format.json { render :reserved, status: :created, location: @reservation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    authorize! :update, @reservation, :message => "Attenzione: Non sei autorizzato a modificare la prenotazione."
    respond_to do |format|
      if @reservation.update(reservation_params)
        #format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully updated." }
        #format.json { render :show, status: :ok, location: @reservation }
        format.html { redirect_to request.referrer, notice: "Prenotazione disabilitata." }
        # Deve manda email di spiegazioni
        format.js {render inline: "location.reload();" }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    authorize! :destroy, @reservation, :message => "Attenzione: Non sei autorizzato ad eliminare la prenotazione."
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer, notice: "La prenotazione è stata eliminata correttamente" }
      format.js {render inline: "location.reload();" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:user_id, :department_id, :space_id, :seat_id, :email, :dep_name, :typology, :space_name, :floor, :seat_num, :start_date, :end_date, :state, :is_sync)
    end
end
