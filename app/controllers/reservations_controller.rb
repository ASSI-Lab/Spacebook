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
    sync_calendar = params["calendar_check"] # RECUPERO IL VALORE DELLA CHECKBOX DI SINCRONIZZAZIONE
    params.each do |check|
      if !(check[0]=="authenticity_token" or check[0]=="commit" or check[0]=="controller" or check[0]=="action" or check[0]=="calendar_check") and (check[1] == "1")
        seat = Seat.find(check[0])
        space = Space.find(seat.space_id)
        department = Department.find(space.department_id)
        jcr = Reservation.create(user_id: current_user.id, department_id: department.id, space_id: space.id, seat_id: seat.id, email: current_user.email, dep_name: department.name, typology: space.typology, space_name: space.name, floor: space.floor, seat_num: seat.position, start_date: seat.start_date, end_date: seat.end_date, state: "Active")
        seat.update(state: "Reserved")
        if sync_calendar=="1" # CONTROLLO SE LA SPUNTA PER LA SINCRONIZZAZIONE È PRESENTE
          res={}
          res["res_id"]=jcr.id
          res["name_dip"]=department.name
          res["space"]=space.typology.concat(" - ",space.name)
          res["seat"]=seat.position.to_s
          res["place"]=department.via.concat(", ",department.civico,", ",department.cap,", ",department.citta,", ",department.provincia)
          res["start_date"]=seat.start_date
          res["end_date"]=seat.end_date
          sync_event res # INVIO L'HASH APPENA CREATO PER L'INVIO A GOOGLE CALENDAR
        end 
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

  def sync_event res
    begin
      client = get_google_calendar_client current_user          # INIZIALIZZO SERVIZIO CALENDAR
      event = get_event res                                    # FORMATTO PER RICHIESTA API CALENDAR
      client.insert_event('primary', event)                     # INSERISCO L'EVENTO CREATO SU CALENDAR
      result = client.list_events("primary",max_results: 1000,single_events: true,order_by: 'startTime',time_min: Time.now.iso8601) # CARICO GLI EVENTI DI CALENDAR
      result.items.each do |e| # CERCO L'EVENTO CORRISPONDENTE A QUELLO APPENA CREATO
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
    return unless (current_user.present? && current_user.access_token.present? && current_user.refresh_token.present?) # CONTROLLO PRESENZA TOKEN
    secrets = Google::APIClient::ClientSecrets.new({# FORMATTO I DATI UTENTE E APPLICAZIONE PER LA RICHIESTA DEL TOKEN A GOOGLE
      "web" => {
        "access_token" => current_user.access_token,
        "refresh_token" => current_user.refresh_token,
        "client_id" => ENV["GOOGLE_CLIENT_ID"],
        "client_secret" => ENV["GOOGLE_CLIENT_SECRET"]
      }
    })
    begin
      client.authorization = secrets.to_authorization     # INVIO LA RICHIESTA FORMATTATA A GOOGLE API AUTHORIZER
      client.authorization.grant_type = "refresh_token"

      if !current_user.present?# IN CASO DI NON VALIDITÀ DELLA SESSIONE UTENTE CHIEDO IL REFRESH DEL TOKEN
        client.authorization.refresh!
        current_user.update_attributes(# AGGIORNO I DATI UTENTE DEL DB CON IL NUOVO TOKEN
          access_token: client.authorization.access_token,
          refresh_token: client.authorization.refresh_token,
          expires_at: client.authorization.expires_at.to_i
        )
      end
    rescue => e
      flash[:error] = "Il tuo token è scaduto. Per favore esegui nuovamente l'accesso con Google."
      redirect_to :back
    end
    client
  end

  def get_event res   # FORMATTO I DATI RACCOLTI PER L'INVIO A GOOGLE CALENDAR API
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
