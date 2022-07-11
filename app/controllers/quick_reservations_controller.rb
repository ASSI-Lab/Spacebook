class QuickReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quick_reservation, only: %i[ show edit update destroy ]

  # Effettua la prenotazione rapida sullo spazio impostato e mostra il risultato all'utente
  def make_quick_res
    @qk_res = QuickReservation.where(user_id: current_user.id).first                    # Raccoglie la prenotazione rapida

    @user_res = Reservation.where(user_id: current_user.id, space_id: @qk_res.space_id) # Raccoglie le prenotazioni dell'utente fatte sullo stesso spazio della rapida

    alredy_reserved = 0 # Variabile di controllo

    # Se c'è almeno una prenotazione di quelle sopra riportate
    if @user_res.count != 0
      # Per ognuna di esse
      @user_res.each do |user_res|
        # Controlla se sono in data odierna e se sono ancora valide
        if ( user_res.start_date.strftime("%Y%m%d%T") >= DateTime.now.strftime("%Y%m%d%T") ) and ( user_res.start_date.strftime("%Y%m%d") < ((DateTime.now)+(86400)).strftime("%Y%m%d") )
          alredy_reserved = 1 # Se si imposta la variabile di controllo a 1
        end
      end
    end

    # Se la variabile di controllo è a 1 allora si ha gia almeno una prenotazione oggi per lo spazio desiderato
    if alredy_reserved == 1
      redirect_to '/user_reservations'                                                                                                                     # Reindirizza alla pagina delle prenotazioni utente
      flash[:alert] = "Hai gia una prenotazione per questo spazio oggi, se desideri effettuarne un altra puoi farlo dalla pagina 'Effettua prenotazione'!" # Notifica l'utente
    # Se invece è a zero, inizializza i dati con i quali prenota lo spazio desiderato
    else
      @seat = Seat.where(space_id: @qk_res.space_id, space_id: @qk_res.space_id, typology: @qk_res.typology, state: "Active").order(:start_date, :position).first
      @space = Space.find(@seat.space_id)
      @department = Department.find(@space.department_id)

      @reservation = Reservation.create(user_id: current_user.id, department_id: @department.id, space_id: @space.id, seat_id: @seat.id, email: current_user.email, dep_name: @department.name, typology: @space.typology, space_name: @space.name, floor: @space.floor, seat_num: @seat.position, start_date: @seat.start_date, end_date: @seat.end_date, state: "Active")
      @seat.update(state: "Reserved")
    end
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
      format.html { redirect_to request.referrer }
      format.js { render inline: "location.reload();" }
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
