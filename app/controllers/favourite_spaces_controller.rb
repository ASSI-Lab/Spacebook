class FavouriteSpacesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_favourite_space, only: %i[ show edit update destroy ]

  # Mostra all'utente la lista dei suoi spazi preferiti
  def index
    @favourite_spaces = FavouriteSpace.where(user_id: current_user.id)
  end

  def create
    @favourite_space = FavouriteSpace.new(favourite_space_params)

    respond_to do |format|
      if @favourite_space.save
        format.html { redirect_to request.referrer, notice: "Lo spazio '"+@favourite_space.typology+" - "+@favourite_space.name+"' è stato aggiunto ai preferiti." }
      else
        format.html { redirect_to request.referrer, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    typ = @favourite_space.typology
    nm = @favourite_space.space_name
    @favourite_space.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer, notice: "Lo spazio '"+typ+" - "+nm+"' è stato rimosso dai preferiti." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favourite_space
      @favourite_space = FavouriteSpace.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def favourite_space_params
      params.require(:favourite_space).permit(:user_id, :department_id, :space_id, :email, :dep_name, :typology, :space_name)
    end
end
