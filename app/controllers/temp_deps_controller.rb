class TempDepsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_temp_dep, only: %i[ show edit update destroy ]

  # Crea gli orari di apertura e chiusura settimanali del dipartimento temporaneo dopo aver ricevuto i dati da /make_department
  def set_temp_wd
    ["Lunedì", "Martedì", "Mercoledì", "Giovedì", "Venerdì", "Sabato", "Domenica"].each do |table_day|
      TempWeekDay.create(
        temp_dep_id: params[:temp_dep_id], dep_name: params[:dep_name], day: table_day,
        state: (params["#{table_day}OpenCheck"] == "1")? "Aperto" : "Chiuso",
        apertura: DateTime.new(params["#{table_day}Apertura(1i)"].to_i, params["#{table_day}Apertura(2i)"].to_i, params["#{table_day}Apertura(3i)"].to_i, params["#{table_day}Apertura(4i)"].to_i, params["#{table_day}Apertura(5i)"].to_i),
        chiusura: DateTime.new(params["#{table_day}Chiusura(1i)"].to_i, params["#{table_day}Chiusura(2i)"].to_i, params["#{table_day}Chiusura(3i)"].to_i, params["#{table_day}Chiusura(4i)"].to_i, params["#{table_day}Chiusura(5i)"].to_i)
      )
    end

    respond_to do |format|
      format.html { render :new }
    end
  end

  # Pagina di registrazione del dipartimento (creazione dei dati temporanei)
  def new
    # Controlla se l'utente ha effettuato l'accesso e se è manager, altrimenti lo reindirizza
    if !user_signed_in? or !current_user.is_manager?
      redirect_to '/home'
      flash[:alert] = "ATTENZIONE: non essendo manager non puoi accedere a questa pagina!"
    # Controlla se il manager ha un dipartimento e se si lo reindirizza ad esso
    elsif (Department.where(manager: current_user.email).count == 1)
      redirect_to '/manager_department'
      flash[:alert] = "Hai gia creato un dipartimento! Eccolo quì!"
    elsif TempDep.where(manager: current_user.email).count == 0
      @temp_dep = TempDep.new
    end
  end

  def create
    @temp_dep = TempDep.new(temp_dep_params)
    coord = get_coord(@temp_dep.via+" "+@temp_dep.civico+" "+@temp_dep.citta+" "+@temp_dep.cap)
    if coord=='error'
      redirect_to '/make_department'
      flash[:alert] = "Attenzione: Errore indirizzo dipartimento!\nControlla l'indirizzo inserito e la tua connessione internet e riprova!" # Notifica l'utente
      return
    else
      @temp_dep.lat=coord[0]
      @temp_dep.lon=coord[1]
    end
    authorize! :create, @temp_dep, :message => "Attenzione: Non sei autorizzato a creare un dipartimento!"
    respond_to do |format|
      if @temp_dep.save
        format.html { redirect_to '/make_department', notice: "Il dipartimento è stato registrato e potrai modificarlo successivamente. Procedi con la registrazione degli orari!" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def get_coord ind
    client = OpenStreetMap::Client.new
    response = client.search(q: ind, format: 'json', addressdetails: '1', accept_language: 'en')
    geo_data = response[0]
    if geo_data==nil
      return "error"
    else
      lat = geo_data["lat"]
      lon = geo_data["lon"]
      res =[lat,lon]
      return res
    end
  end

  def update
    respond_to do |format|
      if @temp_dep.update(temp_dep_params)
        format.html { redirect_to request.referrer, notice: "Le informazioni del tuo dipartimento sono state modificate correttamente" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @temp_dep.destroy

    respond_to do |format|
      if @temp_dep.save
        format.html { redirect_to request.referrer }
      else
        format.html { redirect_to request.referrer, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_temp_dep
      @temp_dep = TempDep.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def temp_dep_params
      params.require(:temp_dep).permit(:user_id, :name, :manager, :via, :civico, :cap, :citta, :provincia, :description, :floors, :number_of_spaces, :dep_map, :dep_event)
    end
end