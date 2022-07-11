class HomeController < ApplicationController

  def index
    @departments = Department.all
    @week_days = WeekDay.all
  end

  def get_coord ind
    client = OpenStreetMap::Client.new
    response = client.search(q: ind, format: 'json', addressdetails: '1', accept_language: 'en')
    print "\n\n\n",response,ind,"\n\n\n"
  end

  helper_method :get_coord
end
