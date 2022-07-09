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

  # GET /temp_deps/new
  def new
    if (Department.where(manager: current_user.email).count == 1)
      redirect_to '/manager_department'
      flash[:alert] = "Hai gia creato un dipartimento! Eccolo quì!" # Mostra messagio di spiegazione
    else
      @temp_dep = TempDep.new
    end
  end

  # POST /temp_deps or /temp_deps.json
  def create
    @temp_dep = TempDep.new(temp_dep_params)

    respond_to do |format|
      if @temp_dep.save
        format.html { redirect_to request.referrer, notice: "Il dipartimento è stato registrato correttamente. Procedi con la registrazione degli spazi!" }
        format.js {render inline: "location.reload();" }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @temp_dep.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /temp_deps/1 or /temp_deps/1.json
  def update
    respond_to do |format|
      if @temp_dep.update(temp_dep_params)
        format.html { redirect_to request.referrer, notice: "Le informazioni del dipartimento sono state modificate correttamente" }
        format.js {render inline: "location.reload();" }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @temp_dep.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /temp_deps/1 or /temp_deps/1.json
  def destroy
    @temp_dep.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer, notice: "Il dipartimento è stato rimosso correttamente!" }
      format.js {render inline: "location.reload();" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_temp_dep
      @temp_dep = TempDep.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def temp_dep_params
      params.require(:temp_dep).permit(:user_id, :name, :manager, :via, :civico, :cap, :citta, :provincia, :description, :floors, :number_of_spaces)
    end
end

# Parameters: {
#   "authenticity_token"=>"[FILTERED]",
#   "temp_dep_id"=>"1",
#   "dep_name"=>"Ed.M.Polo",

#   "''day''OpenCheck"=>val,
#     "''day''Apertura(1i)"=>val,
#     "''day''Apertura(2i)"=>val,
#     "''day''Apertura(3i)"=>val,
#     "''day''Apertura(4i)"=>val,
#     "''day''Apertura(5i)"=>val,

#     "''day''Chiusura(1i)"=>val,
#     "''day''Chiusura(2i)"=>val,
#     "''day''Chiusura(3i)"=>val,
#     "''day''Chiusura(4i)"=>val,
#     "''day''Chiusura(5i)"=>val,

#   "commit"=>"Imposta orari"
#   }