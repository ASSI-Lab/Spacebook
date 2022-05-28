class ManagementController < ApplicationController
  before_action :authenticate_user!
  # GET /management
  def index
    if(current_user.is_admin?)                                                        # Blocca l'accesso alla pagina se non si è amministratori 
      @users = User.all
      @departments = Department.all
      @reservations = Reservation.all
    else
      redirect_back(fallback_location: root_path)                                           
      flash[:alert] = "Attenzione: Non sei autorizzato a visualizzare questa pagina!"
    end
  end

end
