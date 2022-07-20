class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: %i[ show edit update destroy ]

  # Raccoglie il nome del dipartimento selezionato dall'utente, ne carica gli spazi e reindirizza a '/make_rexservation'
  def set_department
    selected_spaces = Space.where(dep_name: params[:selected_dep_name])

    respond_to do |format|
      format.html { render :new, locals: { department: params, selected_spaces: selected_spaces} }
    end
  end

  # Raccoglie le azioni e gli spazi richiesti dall'utente e agisce di conseguenza, infine reindirizza a '/user_reservation'
  def make_res

    sync_calendar = params["calendar_check"] # Raccoglie lo stato della check di calendar (Spuntata o meno)

    # Per ognuno dei params
    params.each do |check|
      # Se il param è riferito ad un check degli spazi da prenotare
      if (check[1] == "MakeRes")

        seat = Seat.find(check[0])                        # Raccoglie il posto relativo
        space = Space.find(seat.space_id)                 # Raccoglie lo spazio relativo
        department = Department.find(space.department_id) # Raccoglie il dipartimento relativo

        # Crea la prenotazione con i dati sopra raccolti
        jcr = Reservation.create(user_id: current_user.id, department_id: department.id, space_id: space.id, seat_id: seat.id, email: current_user.email, dep_name: department.name, typology: space.typology, space_name: space.name, floor: space.floor, seat_num: seat.position, start_date: seat.start_date, end_date: seat.end_date, state: "Valida")
        # Modifica il posto per renderlo occupato
        seat.update(position: seat.position+1)

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

      # Se il param è riferito ad un check per aggiungere uno spazio ai preferiti
      elsif (check[1] == "AddFavSp")

        space = Space.find((check[0].to_i)*(-1))          # Raccoglie lo spazio relativo
        department = Department.find(space.department_id) # Raccoglie il dipartimento relativo

        # Aggiunge lo spazio alla lista dei preferiti
        FavouriteSpace.create(user_id: current_user.id, department_id: department.id, space_id: space.id, email: current_user.email, dep_name: department.name, typology: space.typology, space_name: space.name)

      # Se il param è riferito ad un check per rimuovere uno spazio dai preferiti
      elsif (check[1] == "RmFavSp")
        FavouriteSpace.find(check[0]).destroy # Raccoglie lo spazio preferito relativo e lo rimuove
      # Se il param è riferito ad un check per impostare uno spazio come prenotazione rapida
      elsif (check[1] == "SetQkRes")
        # Ottiene l'id dello spazio da impostare
        id_str = ""
        check[0].each_char do |char|
          if char=="0" or char=="1" or char=="2" or char=="3" or char=="4" or char=="5" or char=="6" or char=="7" or char=="8" or char=="9"
            id_str.concat(char)
          end
        end
        id_int = id_str.to_i

        space = Space.find(id_int)                        # Raccoglie lo spazio relativo
        department = Department.find(space.department_id) # Raccoglie il dipartimento relativo

        # Imposta lo spazio come prenotazione rapida
        QuickReservation.create(user_id: current_user.id, department_id: department.id, space_id: space.id, email: current_user.id, dep_name: department.name, typology: space.typology, space_name: space.name)

      # Se il param è riferito ad un check per sostituire uno spazio alla prenotazione rapida
      elsif (check[1] == "UpdateQkRes")

        qk_res = QuickReservation.where(user_id: current_user.id) # Raccoglie la prenotazione rapida relativa

        # Ottiene l'id dello spazio da sostituire
        id_str = ""
        check[0].each_char do |char|
          if char=="0" or char=="1" or char=="2" or char=="3" or char=="4" or char=="5" or char=="6" or char=="7" or char=="8" or char=="9"
             id_str.concat(char)
          end
        end
        id_int = id_str.to_i

        space = Space.find(id_int)                        # Raccoglie lo spazio relativo
        department = Department.find(space.department_id) # Raccoglie il dipartimento relativo

        # Aggiorna la prenotazione rapida
        qk_res.update(department_id: department.id, space_id: space.id, dep_name: department.name, typology: space.typology, space_name: space.name)

      # Se il param è riferito ad un check per rimuovere lo spazio dalla prenotazione rapida
      elsif (check[1] == "RmQkRes")

        # Ottiene l'id dello spazio da rimuovere
        id_str = ""
        check[0].each_char do |char|
          if char=="0" or char=="1" or char=="2" or char=="3" or char=="4" or char=="5" or char=="6" or char=="7" or char=="8" or char=="9"
            id_str.concat(char)
          end
        end
        id_int = id_str.to_i

        QuickReservation.where(user_id: current_user.id, space_id: id_int).first.destroy # Rimuove la prenotazione rapida

      end
    end

    respond_to do |format|
      format.html { render :reserved, locals: { make_res_parameters: params } }
    end
  end

  def create
    authorize! :create, @reservation, :message => "Attenzione: Non sei autorizzato ad effettuare prenotazioni!"
    @reservation = Reservation.new(reservation_params)

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to '/user_reservations', notice: "Prenotazione '"+@reservation.typology+" - "+@reservation.space_name+"' effettuata correttamente" }
      else
        format.html { redirect_to request.referrer, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize! :update, @reservation, :message => "Attenzione: Non sei autorizzato a modificare le prenotazioni!"

    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to request.referrer, notice: "Prenotazione '"+@reservation.typology+" - "+@reservation.space_name+"' disabilitata correttamente" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy

    # Libera il posto della prenotazione eliminata
    if ( @reservation.start_date.strftime("%Y%m%d%T") > DateTime.now.strftime("%Y%m%d%T") )
      @seat = Seat.find(@reservation.seat_id)
      @seat.update(position: @seat.position-1)
    end
    
    # CONTROLLA SE LA PRENOTAZIONE È STATA SINCRONIZZATA SU CALENDAR RIMUOVENDOLA ANCHE DA LÌ IN CASO AFFERMATIVO
    if @reservation.is_sync!=nil
      remove_from_calendar @reservation
    end

    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer, notice: "La prenotazione è stata eliminata correttamente" }
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
        if (e.summary==event.summary && e.start.date_time==res["start_date"].change(:offset => "+0100").rfc3339)
          Reservation.find(res["res_id"]).update({is_sync: e.id}) # INSERISCO L'EVENT ID NEL DB
          #print "\n\n\nORARIO EVENTO CALENDAR: ",e.start.date_time,"\n\nORARIO EVENTO LOCALE: ",res["start_date"],"\n\nORARIO EVENTO UTC: ",res["start_date"].change(:offset => "+0100").rfc3339,"\n\n\n\n"
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
        date_time: res["start_date"].change(:offset => "+0100").rfc3339,
        time_zone: "Europe/Rome"
    },
    end: {
        date_time: res["end_date"].change(:offset => "+0100").rfc3339,
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
