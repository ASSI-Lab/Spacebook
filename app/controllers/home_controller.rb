class HomeController < ApplicationController

  def index
    @departments = Department.all
    @week_days = WeekDay.all
  end

end
