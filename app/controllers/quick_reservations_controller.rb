class QuickReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quick_reservation, only: %i[ show edit update destroy ]

  # Effettua la prenotazione rapida sullo spazio impostato e mostra il risultato all'utente
  def make_quick_res
    @qk_res = QuickReservation.where(user_id: current_user.id).first                    # Raccoglie la prenotazione rapida
    user_res = Reservation.where(user_id: current_user.id, space_id: @qk_res.space_id) # Raccoglie le prenotazioni dell'utente fatte sullo stesso spazio della prenotazione rapida
    now_date = DateTime.now
    alredy_reserved = 0                                                                 # Variabile di controllo

    # Se c'è almeno una prenotazione di quelle sopra riportate
    if user_res.count != 0
      # Per ognuna di esse
      user_res.each do |user_res|
        urs_res_sd = user_res.start_date
        # Controlla se sono in data odierna e se sono ancora valide
        if urs_res_sd.strftime("%k").to_i == ((now_date).strftime("%k").to_i + 1)%23 and urs_res_sd.strftime("%Y%m%d") == (now_date).strftime("%Y%m%d")
          alredy_reserved = 1 # In caso positivo imposta la variabile di controllo a 1
        end
      end
    end

    if alredy_reserved == 1 # Se la variabile di controllo è a 1 allora si ha gia almeno una prenotazione oggi per lo spazio desiderato
      # Reindirizza alla pagina delle prenotazioni utente
      redirect_to '/user_reservations'
      flash[:alert] = "Hai gia una prenotazione per la prossima ora, se desideri effettuarne un altra per le ore successive puoi farlo dalla pagina 'Effettua prenotazione'!"
    else                    # Se invece è a 0, inizializza i dati con i quali prenota lo spazio della prenotazione rapida
      seat = Seat.where(space_id: @qk_res.space_id, state: "Active").order(:start_date).first
      space = Space.find(@qk_res.space_id)
      if seat.start_date.strftime("%k").to_i == ((now_date).strftime("%k").to_i + 1)%23 and seat.start_date.strftime("%Y%m%d") == (now_date).strftime("%Y%m%d") and seat.position <= space.number_of_seats

        space = Space.find(seat.space_id)
        department = Department.find(space.department_id)

        # Crea la prenotazione
        @reservation = Reservation.create(user_id: current_user.id, department_id: department.id, space_id: space.id, seat_id: seat.id, email: current_user.email, dep_name: department.name, typology: space.typology, space_name: space.name, floor: space.floor, seat_num: seat.position, start_date: seat.start_date, end_date: seat.end_date, state: "Active")

        # Aggiorna il posto
        seat.update(position: seat.position+1)
      end
    end
  end

  def create
    @quick_reservation = QuickReservation.new(quick_reservation_params)

    respond_to do |format|
      if @quick_reservation.save
        flash[:alert] = "Prenotazione rapida impostata correttamente su '"+@quick_reservation.typology+" - "+@quick_reservation.space_name+"'"
      else
        format.html { redirect_to referrer.request, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @quick_reservation.update(quick_reservation_params)
        flash[:alert] = "Prenotazione rapida sostituita correttamente con '"+@quick_reservation.typology+" - "+@quick_reservation.space_name+"'"
      else
        format.html { redirect_to referrer.request, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @quick_reservation.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer }
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
