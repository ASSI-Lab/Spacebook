class HomeController < ApplicationController

  def index
    @departments = Department.all
    @week_days = WeekDay.all
    @quick_reservation = QuickReservation.where(user_id: current_user.id).first if user_signed_in?
  end

end
