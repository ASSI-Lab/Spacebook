require 'date'
require 'active_support/core_ext/date'

class DepartmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_department, only: %i[ show edit update destroy ]

  # GET /departments or /departments.json
  def index
    @departments = Department.all
  end

  # GET /manager_department | Mostra al manager il dipartimento gestito | accessibile premento il bottone 'il mio dipartimento' nall'area personale
  def manager_department
    if (current_user.is_manager?) # Controlla se l'utente è manager
      
      # Crea il dipartimento effettivo con relativi orari, spazi e posti se è presente un dipartimento temporaneo associato a questo manager nel DB
      @temp_dep = TempDep.where(manager: current_user.email)  # Raccoglie l'eventuale dipartimento temporaneo
      if (@temp_dep.count == 1)                               # Controlla se il dipartimento temporaneo esiste

        # Inizializza il dipartimento temporaneo e crea il dipartimento effettivo con i dati di quello temporaneo
        @temp_dep = @temp_dep.first
        @department = Department.create(user_id: current_user.id, name: @temp_dep.name, manager: @temp_dep.manager, via: @temp_dep.via, civico: @temp_dep.civico, cap: @temp_dep.cap, citta: @temp_dep.citta, provincia: @temp_dep.provincia, description: @temp_dep.description, floors: @temp_dep.floors, number_of_spaces: @temp_dep.number_of_spaces)

        # Raccoglie gli orari temporanei relativi al dipartimento temporaneo e con il ciclo crea gli orari effettivi
        @temp_week_day = TempWeekDay.where(temp_dep_id: @temp_dep.id).each do |twd|
          WeekDay.create(department_id: @department.id, dep_name: @department.name, day: twd.day, state:twd.state, apertura: twd.apertura, chiusura: twd.chiusura)
        end

        # Raccoglie gli spazi temporanei relativi al dipartimento temporaneo e con il ciclo crea gli spazi effettivi
        @temp_sps = TempSp.where(temp_dep_id: @temp_dep.id).each do |temp_sp|
          Space.create(department_id: @department.id, dep_name: temp_sp.dep_name, typology: temp_sp.typology, name: temp_sp.name, description: temp_sp.description, floor: temp_sp.floor, number_of_seats: temp_sp.number_of_seats, state: temp_sp.state)
        end

        @temp_dep.destroy                                       # Elimina il dipartimento temporaneo e i relativi orari e spazi temporanei

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
              @monday = Date.today.monday # (2)
              
              # Tramite (1) & (2) sopra riportati calcola la data da inserire a seconda dei casi:
              if (@day=="Lunedì")         # Calcola la data del prossimo lunedì
                if @monday.past?
                  @date = @monday + 7
                else
                  @date = @monday
                end
              elsif (@day=="Martedì")     # Calcola la data del prossimo martedì
                if (@monday+1).past?
                  @date = @monday + 8
                else
                  @date = @monday + 1
                end
              elsif (@day=="Mercoledì")   # Calcola la data del prossimo mercoledì
                if (@monday+2).past?
                  @date = @monday + 9
                else
                  @date = @monday + 2
                end
              elsif (@day=="Giovedì")     # Calcola la data del prossimo giovedì
                if (@monday+3).past?
                  @date = @monday + 10
                else
                  @date = @monday + 3
                end
              elsif (@day=="Venerdì")     # Calcola la data del prossimo venerdì
                if (@monday+4).past?
                  @date = @monday + 11
                else
                  @date = @monday + 4
                end
              elsif (@day=="Sabato")      # Calcola la data del prossimo sabato
                if (@monday+5).past?
                  @date = @monday + 12
                else
                  @date = @monday + 5
                end
              elsif (@day=="Domenica")    # Calcola la data della prossimo domenica
                if (@monday+6).past?
                  @date = @monday + 13
                else
                  @date = @monday + 6
                end
              end
              
              # Per ogni slot da un ora contenuto negli orari di (1)
              ((wd.chiusura.hour-wd.apertura.hour)).times do |h|
                
                @start_date = DateTime.new(@date.year,@date.mon,@date.mday,wd.apertura.hour+h,0,0) # La data + L'orario d'inizio del posto
                @end_date = DateTime.new(@date.year,@date.mon,@date.mday,wd.apertura.hour+h+1,0,0) # La data + L'orario di fine del posto
                
                # Per ogni posto dello spazio
                sp.number_of_seats.times do |pos| # Crea i posti relativi ad una settimana dal momento della creazione
                  Seat.create(space_id: sp.id, dep_name: @department.name, typology: sp.typology, space_name: sp.name, position: pos+1, start_date: @start_date, end_date: @end_date, state: "Active")
                end
              end
            end
          end
        end

      end

      # Mostra il dipartimento se esiste altrimenti reindirizza alla creazione
      @department = Department.where(manager: current_user.email)          # Raccoglie l'eventuale dipartimento del manager
      if ((@department.count) == 0)                                        # Controlla se il dipartimento esiste
        redirect_to "/make_department"                                     # In caso negativo reindirizza alla creazione del dipartimento
      else
        @week_days = WeekDay.where(department_id: ((@department).first).id)           # In caso positivo invece raccoglie gli orari,
        @spaces = Space.where(department_id: ((@department).first).id)                # gli spazi
        @reservations = Reservation.where(department_id: ((@department).first).id)    # e le prenotazioni del dipartimento trovato
      end # A questo punto si aprirà la view '/manager_department' che lavorerà con questi dati.

    else                          # Se l'user non è manager
      redirect_back(fallback_location: root_path)                                             # Reindirizza alla pagina home ((???))
      flash[:alert] = "Attenzione: Non sei autorizzato a visualizzare questa pagina!"         # Notifica l'utente
    end
  end

  # GET /departments/1 or /departments/1.json | Mostra all'admin il singolo dipartimento
  def show
    @spaces = Space.where(department_id: @department.id)
    @week_days = WeekDay.where(department_id: @department.id)
  end

  # GET /departments/new | Mostra al manager la pagina di creazione dei dipartimenti e degli spazi con i relativi form
  def new
    @department = Department.new
    authorize! :new, @department, :message => "Attenzione: Non sei autorizzato a creare un dipartimento."
  end

  # GET /departments/1/edit
  def edit
  end

  # POST /departments or /departments.json
  def create
    @department = Department.new(department_params)
    authorize! :create, @department, :message => "Attenzione: Non sei autorizzato a creare un dipartimento."

    respond_to do |format|
      if @department.save
        format.html { redirect_to request.referrer, notice: "Il dipartimento è stato creato correttamente all'interno del sito" }
        format.js {render inline: "location.reload();" }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departments/1 or /departments/1.json
  def update
    authorize! :update, @department, :message => "Attenzione: Non sei autorizzato ad aggiornare un dipartimento."
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to '/manager_department', notice: "Il dipartimento è stato aggiornato correttamente" }
        format.json { render :manager_department, status: :ok, location: @department }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1 or /departments/1.json
  def destroy
    authorize! :destroy, @department, :message => "Attenzione: Non sei autorizzato ad eliminare un dipartimento."
    @department.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer, notice: "Il dipartimento e tutti i suoi spazi sono stati eliminati correttamente dal sito. In più tutte le prenotazioni relative a tali spazi sono state disdette comunicando tramite e-mail agli utenti interessati la motivazione" }
      format.js {render inline: "location.reload();" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def department_params
      params.require(:department).permit(:user_id, :name, :manager, :via, :civico, :cap, :citta, :provincia, :description, :floors, :number_of_spaces)
    end
end
