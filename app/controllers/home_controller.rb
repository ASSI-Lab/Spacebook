class HomeController < ApplicationController

  # Pagina home del sito
  def index
    @q = Department.ransack(params[:q])      # Risultato della query tramite barra di ricerca
    @departments = @q.result(distinct: true) # Inizializza @departments con quelli risultani dalla query (query nulla = tutti i dipartimenti)
    @week_days = WeekDay.all
    @quick_reservation = QuickReservation.where(user_id: current_user.id).first if user_signed_in?
  end

  
end
