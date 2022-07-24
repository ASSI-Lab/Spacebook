require 'date'
require 'active_support/core_ext/date'

class DepartmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_department, only: %i[ show edit update destroy ]

  # GET /manager_department | Mostra al manager il dipartimento gestito | accessibile premento il bottone 'il mio dipartimento' nall'area personale
  def manager_department
    # Controlla se l'utente è manager
    if (current_user.is_manager?)

      # Mostra il dipartimento se esiste altrimenti reindirizza alla creazione
      @department = Department.where(manager: current_user.email) # Raccoglie l'eventuale dipartimento del manager
      @temp_dep = TempDep.where(manager: current_user.email)      # Raccoglie l'eventuale dipartimento temporaneo

      # Se il manager non ha ancora un dipartimento effettivo
      if (@department.count == 0)
        if (@temp_dep.count == 0)   # Se non ha neanche il temporaneo, reindirizza all acreazione del temporaneo
          redirect_to "/make_department"
        else (@temp_dep.count == 1) # Crea il dipartimento effettivo tramite i dati del temporaneo

          @temp_dep = @temp_dep.first                                                                 # Inizializza il dipartimento temporaneo
          @temp_week_day = TempWeekDay.where(temp_dep_id: @temp_dep.id)                               # Raccoglie gli orari temporanei relativi al dipartimento temporaneo
          @temp_sps = TempSp.where(temp_dep_id: @temp_dep.id)                                         # Raccoglie gli spazi temporanei relativi al dipartimento temporaneo

          # Crea il dipartimento effettivo con i dati temporanei
          @department = Department.create(user_id: current_user.id, name: @temp_dep.name, manager: @temp_dep.manager, via: @temp_dep.via, civico: @temp_dep.civico, cap: @temp_dep.cap, citta: @temp_dep.citta, provincia: @temp_dep.provincia,latitude: @temp_dep.lat,longitude: @temp_dep.lon, description: @temp_dep.description, floors: @temp_dep.floors, number_of_spaces: @temp_sps.count, dep_map: @temp_dep.dep_map, dep_event: @temp_dep.dep_event)

          @temp_week_day.each do |twd| # Crea gli orari effettivi
            WeekDay.create(department_id: @department.id, dep_name: @department.name, day: twd.day, state:twd.state, apertura: twd.apertura, chiusura: twd.chiusura)
          end
          @temp_sps.each do |temp_sp| # Crea gli spazi effettivi
            Space.create(department_id: @department.id, dep_name: temp_sp.dep_name, typology: temp_sp.typology, name: temp_sp.name, description: temp_sp.description, floor: temp_sp.floor, number_of_seats: temp_sp.number_of_seats, state: temp_sp.state)
          end
          @temp_dep.destroy # Elimina il dipartimento temporaneo e i relativi orari e spazi temporanei

          # Creazione dei posti settimanali per ogni orario prenotabile
          @week_days = WeekDay.where(department_id: @department.id) # Raccoglie gli orari del dipartimento
          @spaces = Space.where(department_id: @department.id)      # Raccoglie gli spazi del dipartimento

          # Per ogni spazio
          @spaces.each do |sp|
            # Per ogni giorno della settimana
            @week_days.each do |wd|
              # Se in questo giorno è aperto
              if (wd.state == "Aperto")

                @day = wd.day               # (1)
                @monday = Date.today.monday # (2) data del lunedì della settimana corrente

                # Tramite (1) & (2) sopra riportati calcola la data da inserire a seconda dei casi:
                if (@day=="Lunedì")       # Calcola la data del prossimo lunedì
                  @date = ((@monday+0).past?)? (@monday + 7) : (@monday)
                elsif (@day=="Martedì")   # Calcola la data del prossimo martedì
                  @date = ((@monday+1).past?)? (@monday + 8) : (@monday + 1)
                elsif (@day=="Mercoledì") # Calcola la data del prossimo mercoledì
                  @date = ((@monday+2).past?)? (@monday + 9) : (@monday + 2)
                elsif (@day=="Giovedì")   # Calcola la data del prossimo giovedì
                  @date = ((@monday+3).past?)? (@monday + 10) : (@monday + 3)
                elsif (@day=="Venerdì")   # Calcola la data del prossimo venerdì
                  @date = ((@monday+4).past?)? (@monday + 11) : (@monday + 4)
                elsif (@day=="Sabato")    # Calcola la data del prossimo sabato
                  @date = ((@monday+5).past?)? (@monday + 12) : (@monday + 5)
                elsif (@day=="Domenica")  # Calcola la data della prossimo domenica
                  @date = ((@monday+6).past?)? (@monday + 13) : (@monday + 6)
                end

                # Per ogni slot da un ora contenuto negli orari di (1)
                ((wd.chiusura.hour-wd.apertura.hour)).times do |h|

                  @start_date = DateTime.new(@date.year, @date.mon, @date.mday, wd.apertura.hour+h, 0, 0) # La data + l'orario d'inizio del posto
                  @end_date = DateTime.new(@date.year, @date.mon, @date.mday, wd.apertura.hour+h+1, 0, 0) # La data + l'orario di fine del posto

                  # Crea il posto relativo al giorno corrente
                  Seat.create(space_id: sp.id, dep_name: @department.name, typology: sp.typology, space_name: sp.name, position: 1, start_date: @start_date, end_date: @end_date, state: "Active")

                end
              end
            end
          end

          @reservations = Reservation.where(department_id: @department.id) # Raccoglie le prenotazioni del dipartimento trovato

        end
      # Se invece gia lo ha
      else
        # Elimina il dipartimento temporaneo residuo se esiste
        @temp_dep.first.destroy if (@temp_dep.count == 1) and (@department.count == 1)

        @department = @department.first                                  # Inizializza il dipartimento trovato
        @week_days = WeekDay.where(department_id: @department.id)        # Raccoglie gli orari,
        @spaces = Space.where(department_id: @department.id)             # gli spazi
        @reservations = Reservation.where(department_id: @department.id) # e le prenotazioni del dipartimento trovato

      end

      # A questo punto si aprirà la view '/manager_department' che lavorerà con questi dati.

    # Se l'user non è manager
    else
      redirect_back(fallback_location: root_path)                                     # Reindirizza alla pagina home ((???))
      flash[:alert] = "Attenzione: Non sei autorizzato a visualizzare questa pagina!" # Notifica l'utente
    end
  end


  # Mostra all'admin il dipartimento selezionato da gestione sito (/management)
  def show
    @week_days = WeekDay.where(department_id: @department.id)
    @spaces = Space.where(department_id: @department.id)
    @reservations = Reservation.where(department_id: @department.id)
  end

  def create
    @department = Department.new(department_params)
    authorize! :create, @department, :message => "Attenzione: Non sei autorizzato a creare un dipartimento."

    respond_to do |format|
      if @department.save
        flash[:alert] = "Il dipartimento è stato registrato correttamente all'interno del sito"
      else
        format.html { redirect_to request.referrer, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize! :update, @department, :message => "Attenzione: Non sei autorizzato ad aggiornare i dipartimenti."

    coord = get_coord(@department.via+" "+@department.civico+" "+@department.citta+" "+@department.cap)
    if coord=='error'
      redirect_to '/manager_department'
      flash[:alert] = "Attenzione: Errore indirizzo dipartimento!\nControlla l'indirizzo inserito e la tua connessione internet e riprova!" # Notifica l'utente
      return
    else
      @department.latitude=coord[0]
      @department.longitude=coord[1]
    end

    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to '/manager_department', notice: "Il dipartimento è stato aggiornato correttamente" }
      else
        format.html { redirect_to '/manager_department', status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize! :destroy, @department, :message => "Attenzione: Non sei autorizzato ad eliminare un dipartimento."

    @department.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer }
      flash[:alert] = "Il dipartimento e tutti i suoi spazi sono stati eliminati correttamente dal sito. In più tutte le prenotazioni relative a tali spazi sono state disdette comunicando tramite e-mail agli utenti interessati la motivazione"
    end
  end

  def manager_map_initializer
    res = new_dep_map(current_user.email)
    mydep = Department.find(params[:dep_id])
    mydep.update( dep_map: res[0], dep_event: res[1] )

    respond_to do |format|
      format.html { redirect_to '/manager_department' }
      flash[:alert] = "Mappa inizializzata, puoi ora visualizzarla e modificarla della pagina del tuo dipartimento"
    end
  end

  # Crea nuovo dipartimento su seats.io e un evento collegato ad esso
  def new_dep_map manager_name
    client = Seatsio::Client.new(Seatsio::Region.EU(), ENV['SEATS_IO_SECRET'])
    name = current_user.email
    chart = client.charts.copy("547d22f4-9842-4816-aab3-55fa3b935c56")
    event = client.events.create chart_key: chart.key
    client.charts.update key: chart.key, new_name: name
    client.charts.publish_draft_version(chart.key)
    print "\n\n\n"+event.key+"\n\n\n\n"+chart.key+"\n\n"
    return [chart.key,event.key]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def department_params
      params.require(:department).permit(:user_id, :name, :manager, :via, :civico, :cap, :citta, :provincia, :latitude, :longitude, :description, :floors, :number_of_spaces, :dep_map, :dep_event)
    end
end