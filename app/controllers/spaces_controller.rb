class SpacesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_space, only: %i[ show edit update destroy ]

  # GET /spaces or /spaces.json
  def index
    @spaces = Space.all
  end

  # GET /spaces/1 or /spaces/1.json
  def show
  end

  # GET /spaces/new
  def new
    @space = Space.new
  end

  # GET /spaces/1/edit
  def edit
  end

  # POST /spaces or /spaces.json
  def create
    @space = Space.new(space_params)

    respond_to do |format|
      if @space.save
        format.html { redirect_to request.referrer, notice: "Spazio creato correttamente." }
        format.js {render inline: "location.reload();" }
      else
        format.html { redirect_to request.referrer, notice: "Spazio non creato correttamente." }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spaces/1 or /spaces/1.json
  def update
    respond_to do |format|
      if @space.update(space_params)
        format.html { redirect_to request.referrer, notice: "Spazio aggiornato correttamente." }
        format.js {render inline: "location.reload();" }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spaces/1 or /spaces/1.json
  def destroy
    @space.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer, notice: "Spazio eliminato correttamente." }
      format.js {render inline: "location.reload();" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_space
      @space = Space.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def space_params
      params.require(:space).permit(:department_id, :dep_name, :typology, :name, :description, :floor, :number_of_seats, :state)
    end
end
