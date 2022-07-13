class HomeController < ApplicationController

  # Pagina home del sito
  def index
    @q = Department.ransack(params[:q])
    @departments = @q.result(distinct: true)
    @week_days = WeekDay.all
    @quick_reservation = QuickReservation.where(user_id: current_user.id).first if user_signed_in?
  end

end
