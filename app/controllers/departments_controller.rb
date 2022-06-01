class DepartmentsController < ApplicationController
  before_action :set_department, only: %i[ show edit update destroy ]

  # GET /departments or /departments.json
  def index
    @departments = Department.all
  end

  # GET /manager_department | Mostra al manager il dipartimento gestito | accessibile premento il bottone 'il mio dipartimento' nall'area personale
  def manager_department
    if current_user.is_manager?                                                            # Controlla se l'utente è manager
      @department = Department.where(manager: current_user.email)
      @spaces = Space.where(department_id: ((@department).first).id)
    else
      redirect_back(fallback_location: root_path)                                          # In caso di errore di path reindirizza alla home 
      flash[:alert] = "Attenzione: Non sei autorizzato a visualizzare questa pagina!"      # Mostra messagio di errore
    end
  end

  # GET /departments/1 or /departments/1.json | Mostra all'admin il singolo dipartimento
  def show
    @spaces = Space.where(department_id: @department.id)
  end

  # GET /departments/new | Mostra al manager la pagina di creazione dei dipartimenti e degli spazi con i relativi form
  def new
    @department = Department.new
    @space = Space.new
    @seat = Seat.new
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
        # format.html { redirect_to '/manager_department', notice: "Il dipartimento è stato creato correttamente." }
        # format.json { render :manager_department, status: :created, location: @department }
        format.html { redirect_to request.referrer, notice: "Il dipartimento è stato creato correttamente" }
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
        format.html { redirect_to department_url(@department), notice: "Department was successfully created." }
        format.json { render :show, status: :created, location: @department }
        # format.html { redirect_to '/manager_department', notice: "Il dipartimento è stato aggiornato correttamente" }
        # format.json { render :manager_department, status: :ok, location: @department }
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
      format.html { redirect_to request.referrer, notice: "Il dipartimento è stato eliminato correttamente" }
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
      params.require(:department).permit(:user_id, :name, :manager, :via, :civico, :cap, :citta, :provincia, :description, :floors, :number_of_spaces, :slot, :ora_apertura, :min_apertura, :ora_chiusura, :min_chiusura)
    end
end
