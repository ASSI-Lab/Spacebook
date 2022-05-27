class ManagementController < ApplicationController

  # GET /management
  def index
    @users = User.all
    @departments = Department.all
    @reservations = Reservation.all
  end

end
