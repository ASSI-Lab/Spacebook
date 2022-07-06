class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: %i[ show edit update destroy ]

  # GET /reservations or /reservations.json
  def index
    @reservations = Reservation.all
  end

  # Raccoglie il dipartimento selezionato dall'utente e ne carica i dati e reindirizza a '/make_rexservation'
  def set_department
    respond_to do |format|
      format.html { render :new, locals: { department: params } }
    end
  end

  # Raccoglie le prenotazioni richieste dall'utente e ne genera le prenotazioni del dipartimento e reindirizza a '/user_reservation'
  def make_res
    params.each do |check|
      if !(check[0]=="authenticity_token" or check[0]=="commit" or check[0]=="controller" or check[0]=="action") and (check[1] == "1")
        seat = Seat.find(check[0])
        space = Space.find(seat.space_id)
        department = Department.find(space.department_id)
        Reservation.create(user_id: current_user.id, department_id: department.id, space_id: space.id, seat_id: seat.id, email: current_user.email, dep_name: department.name, typology: space.typology, space_name: space.name, floor: space.floor, seat_num: seat.position, start_date: seat.start_date, end_date: seat.end_date, state: "Active", is_sync: 0)
        seat.update(state: "Reserved")
      end
    end
    respond_to do |format|
      format.html { render :reserved, locals: { make_res_parameters: params } }
    end
  end

  # GET /reservations/1 or /reservations/1.json
  def show
    authorize! :show, @reservation, :message => "Attenzione: Non sei autorizzato a visualizzare la prenotazione."
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
    Seat.find(@reservation.seat_id).update(state: "Active")
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
