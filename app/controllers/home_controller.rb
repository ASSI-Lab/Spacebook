class HomeController < ApplicationController

  def index
    @departments = Department.all
    @week_days = WeekDay.all
  end

  # RESTITUISCE COORDINATE DELL'INDIRIZZO CHE VIENE FORNITO
  def get_coord ind
    client = OpenStreetMap::Client.new
    response = client.search(q: ind, format: 'json', addressdetails: '1', accept_language: 'en')
    geo_data = response[0]
    lat = geo_data["lat"]
    lon = geo_data["lon"]
    res =[lat,lon]
    return res
  end

  helper_method :get_coord
end
