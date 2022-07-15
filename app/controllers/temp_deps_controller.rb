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
    if (Department.where(manager: current_user.email).count == 1)
      redirect_to '/manager_department'
      flash[:alert] = "Hai gia creato un dipartimento! Eccolo quì!"
    else
      if TempDep.where(manager: current_user.email).count == 0
        @temp_dep = TempDep.new
        # res = new_dep_map(current_user.email)
        # @dep_map = res[0]
        # @dep_event = res[1]
      end
    end
  end

  # Crea nuovo dipartimento su seats.io e un evento collegato ad esso
  def new_dep_map manager_name
    client = Seatsio::Client.new(Seatsio::Region.EU(), ENV['SEATS_IO_SECRET'])
    name = current_user.email
    venueType = "ROWS_WITH_SECTIONS"
    categories = [
      {"key": 1, "label": "Posti", "color": "#aaaaaa"},
      {"key": 2, "label": "Posti disabili", "color": "#bbbbbb"}
    ]
    chart = client.charts.create categories: categories, name: name#, venueType: venueType
    event = client.events.create chart_key: chart.key
    print "\n\n\n"+event.key+"\n\n\n\n"+chart.key+"\n\n"
    return [chart.key,event.key]
  end

  def create
    @temp_dep = TempDep.new(temp_dep_params)

    respond_to do |format|
      if @temp_dep.save
        format.html { render :new, notice: "Il dipartimento è stato registrato e potrai modificarlo successivamente. Procedi con la registrazione degli orari!" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
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