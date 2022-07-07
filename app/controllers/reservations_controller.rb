class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: %i[ show edit update destroy ]

  # Raccoglie il dipartimento selezionato dall'utente, aggiorna i posti relativi nel db con date e orari corretti, ne carica i dati e reindirizza a '/make_rexservation'
  def set_department
    spaces = Space.where(dep_name: params[:name])
    # Aggiorna i posti del dipartimento ogni volta che un utente lo seleziona per effettuare una prenotazione
    spaces.each do |sp|
      Seat.where(space_id: sp.id).each do |seat|
        if ( seat.start_date.strftime("%Y%m%d%T") <= DateTime.now.strftime("%Y%m%d%T") )
          # Se il posto è di oggi ma l'orario è passato basta mettere expired nello stato dello spazio
          if ( seat.start_date.strftime("%Y%m%d") == DateTime.now.strftime("%Y%m%d") )
            seat.update(state: "Expired")
          # Se invece non è di oggi ma di un giorno precedente
          else
            # Crea il nuovo posto nel giorno corretto della settimana
            Seat.create(space_id: seat.space_id, dep_name: seat.dep_name, typology: seat.typology, space_name: seat.space_name, position: seat.position, start_date: seat.start_date+(604800), end_date: seat.end_date+(604800), state: "Active")
            # Distrugge il posto vecchio
            seat.destroy
          end
        end
      end
    end
    respond_to do |format|
      format.html { render :new, locals: { department: params, spaces: spaces} }
    end
  end

  # Raccoglie le prenotazioni richieste dall'utente e ne genera le prenotazioni del dipartimento e reindirizza a '/user_reservation'
  def make_res
    # Raccoglie lo stato della check di calendar (Spuntata o meno)
    sync_calendar = params["calendar_check"]
    # Per ognuno degli orari selezionati
    params.each do |check|
      if !(check[0]=="authenticity_token" or check[0]=="commit" or check[0]=="controller" or check[0]=="action" or check[0]=="calendar_check") and (check[1] == "1")
        seat = Seat.find(check[0])                        # Raccoglie il posto relativo
        space = Space.find(seat.space_id)                 # Raccoglie lo spazio relativo
        department = Department.find(space.department_id) # Raccoglie il dipartimento relativo

        # Crea la prenotazione con i dati sopra raccolti
        jcr = Reservation.create(user_id: current_user.id, department_id: department.id, space_id: space.id, seat_id: seat.id, email: current_user.email, dep_name: department.name, typology: space.typology, space_name: space.name, floor: space.floor, seat_num: seat.position, start_date: seat.start_date, end_date: seat.end_date, state: "Active")

        # Modifica il posto per renderlo occupato
        seat.update(state: "Reserved")

        # Controllo se l'utente ha spuntato o meno la check di calendar
        if sync_calendar=="1" # In caso positivo inizializzo con i dati opportuni la variabile res e chiamo sync_event

          res={}
          res["res_id"]=jcr.id
          res["name_dip"]=department.name
          res["space"]=space.typology.concat(" - ",space.name)
          res["seat"]=seat.position.to_s
          res["place"]=department.via.concat(", ",department.civico,", ",department.cap,", ",department.citta,", ",department.provincia)
          res["start_date"]=seat.start_date
          res["end_date"]=seat.end_date

          # INVIO L'HASH APPENA CREATO PER L'INVIO A GOOGLE CALENDAR
          sync_event res 
        end 
      end
    end
    respond_to do |format|
      format.html { render :reserved, locals: { make_res_parameters: params } }
    end
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
    if ( @reservation.start_date.strftime("%Y-%m-%d %T") > DateTime.now.strftime("%Y-%m-%d %T") )
      Seat.find(@reservation.seat_id).update(state: "Active")
    end
    
    # CONTROLLA SE LA PRENOTAZIONE È STATA SINCRONIZZATA SU CALENDAR RIMUOVENDOLA ANCHE DA LÌ IN CASO AFFERMATIVO
    if @reservation.is_sync!=nil
      remove_from_calendar @reservation
    end

    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer, notice: "La prenotazione è stata eliminata correttamente" }
      format.js {render inline: "location.reload();" }
    end
  end

  def sync_event res
    begin
      client = get_google_calendar_client current_user # INIZIALIZZO SERVIZIO CALENDAR
      event = get_event res                            # FORMATTO PER RICHIESTA API CALENDAR
      client.insert_event('primary', event)            # INSERISCO L'EVENTO CREATO SU CALENDAR
      result = client.list_events("primary",max_results: 1000,single_events: true,order_by: 'startTime',time_min: Time.now.iso8601) # CARICO GLI EVENTI DI CALENDAR

      # CERCO L'EVENTO CORRISPONDENTE A QUELLO APPENA CREATO
      result.items.each do |e|
        if (e.summary==event.summary && e.start.date_time==res["start_date"].rfc3339)
          Reservation.find(res["res_id"]).update({is_sync: e.id}) # INSERISCO L'EVENT ID NEL DB
        end
      end
      flash[:notice] = 'Prenotazioni sincronizzate con successo.'
    rescue => exception
      flash.now[:error] = "Errore!",exception
    end
  end

  def get_google_calendar_client current_user
    client = Google::Apis::CalendarV3::CalendarService.new
    client_authorization = Signet::OAuth2::Client.new
    client_authorization.client_id = ENV["GOOGLE_CLIENT_ID"]
    client_authorization.client_secret = ENV["GOOGLE_CLIENT_SECRET"]
    client_authorization.access_token = current_user.access_token
    client_authorization.refresh_token = current_user.refresh_token
    client_authorization.expires_at = current_user.expires_at
    
    if current_user.expires_at <= Time.now.to_i
      redirect_to "/session_timeout"
    end
    
    client.authorization = client_authorization
    client.authorization.grant_type = "refresh_token"
    
    return client
  end

  # FORMATTO I DATI RACCOLTI PER L'INVIO A GOOGLE CALENDAR API
  def get_event res
    event = Google::Apis::CalendarV3::Event.new(
    summary: res["name_dip"].concat(" ",res["space"]," ",res["seat"]),
    location: res["place"],
    description: "prenotazione posto",
    start: {
        date_time: res["start_date"].rfc3339,
        time_zone: "Europe/Rome"
    },
    end: {
        date_time: res["end_date"].rfc3339,
        time_zone: "Europe/Rome"
    },
    reminders: {
        use_default: false,
        overrides: [
        Google::Apis::CalendarV3::EventReminder.new(reminder_method:"popup", minutes: 10),
        Google::Apis::CalendarV3::EventReminder.new(reminder_method:"email", minutes: 20)
        ]
    },
    notification_settings: {
        notifications: [
                        {type: 'event_creation', method: 'email'},
                        {type: 'event_change', method: 'email'},
                        {type: 'event_cancellation', method: 'email'},
                        {type: 'event_response', method: 'email'}
                    ]
    }, 'primary': true
    )
  end

  # RIMUOVE LA PRENOTAZIONE DA GOOGLE CALENDAR
  def remove_from_calendar reservation
    begin
      client = get_google_calendar_client current_user # INIZIALIZZO CLIENT
      client.delete_event('primary',reservation.is_sync)  # RIMUOVO LA PRENOTAZIONE USANDO L'EVENT_ID
      flash[:notice] = "Prenotazione rimossa con successo da Calendar."
    rescue => exception
      flash[:error] = "Errore!",exception
      print "\n\n",exception,"\n\n"
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
