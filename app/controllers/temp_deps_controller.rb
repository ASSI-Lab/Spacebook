class TempDepsController < ApplicationController
  before_action :set_temp_dep, only: %i[ show edit update destroy ]

  # GET /temp_deps or /temp_deps.json
  def index
    @temp_deps = TempDep.all
  end

  # GET /temp_deps/1 or /temp_deps/1.json
  def show
  end

  # GET /temp_deps/new
  def new
    @temp_dep = TempDep.new
  end

  # GET /temp_deps/1/edit
  def edit
  end

  # POST /temp_deps or /temp_deps.json
  def create
    @temp_dep = TempDep.new(temp_dep_params)

    respond_to do |format|
      if @temp_dep.save
        format.html { redirect_to temp_dep_url(@temp_dep), notice: "Temp dep was successfully created." }
        format.json { render :show, status: :created, location: @temp_dep }
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
        format.html { redirect_to temp_dep_url(@temp_dep), notice: "Temp dep was successfully updated." }
        format.json { render :show, status: :ok, location: @temp_dep }
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
      format.html { redirect_to temp_deps_url, notice: "Temp dep was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_temp_dep
      @temp_dep = TempDep.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def temp_dep_params
      params.require(:temp_dep).permit(:name, :manager, :via, :civico, :cap, :citta, :provincia, :description, :floors, :number_of_spaces, :slot, :min_apertura, :ora_apertura, :min_chiusura, :ora_chiusura)
    end
end
