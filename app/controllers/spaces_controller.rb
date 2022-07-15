class SpacesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_space, only: %i[ show edit update destroy ]

  def create
    @space = Space.new(space_params)

    respond_to do |format|
      if @space.save
        puts("Spazio #{@space.id} creato")
      else
        format.html { redirect_to request.referrer, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @space.update(space_params)
        format.html { redirect_to request.referrer, notice: ""+@space.typology+"-"+@space.name+" aggiornato correttamente." }
      else
        format.html { redirect_to request.referrer, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @space.destroy
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
