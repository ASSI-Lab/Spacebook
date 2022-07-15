class ManagementController < ApplicationController
  before_action :authenticate_user!

  # Pagina di gestione del sito da parte degli admin
  def index

    if(current_user.is_admin?) # Blocca l'accesso alla pagina se non si è amministratori
      @users = User.all
      @departments = Department.all
      @week_days = WeekDay.all
      @reservations = Reservation.all
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = "Attenzione: per gestire il sito devi essere un amministratore!"
    end
  end

end
