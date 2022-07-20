require 'json'

class HomeController < ApplicationController

  # Pagina home del sito
  def index
    @q = Department.ransack(params[:q])      # Risultato della query tramite barra di ricerca
    @departments = @q.result(distinct: true) # Inizializza @departments con quelli risultani dalla query (query nulla = tutti i dipartimenti)
    @week_days = WeekDay.all
    @quick_reservation = QuickReservation.where(user_id: current_user.id).first if user_signed_in?

    respond_to do |format|

      lati = params[:lati]
      long = params[:long]

      response = RestClient.get('http://www.7timer.info/bin/api.pl?lon=long&lat=lati&product=civil&output=json')
      array = JSON.parse(response)
      giorno = array["init"]
      info_g1 = array["dataseries"][0]
      timepoint = info_g1["timepoint"]
      wind10m = info_g1["wind10m"]
      lifted_index = info_g1["lifted_index"]
      
      prec_amount = info_g1["prec_amount"]
      if(prec_amount==0)
        pa = "_"
      elsif(prec_amount==1)
        pa = "0-0.25mm/hr"
      elsif(prec_amount==2)
        pa = "0.25-1mm/hr"
      elsif(prec_amount==3)
        pa = "1-4mm/hr"
      elsif(prec_amount==4)
        pa = "4-10mm/hr"
      elsif(prec_amount==5)
        pa = "10-16mm/hr"
      elsif(prec_amount==6)
        pa = "16-30mm/hr"
      elsif(prec_amount==7)
        pa = "30-50mm/hr"
      elsif(prec_amount==8)
        pa = "50-75mm/hr"
      elsif(prec_amount==9)
        pa = "Over 75mm/hr"
      end

      cloudcover = info_g1["cloudcover"]
      if(cloudcover==1)
        cc="0%-6%"
      elsif(cloudcover==2)
        cc="6%-19%"
      elsif(cloudcover==3)
        cc="19%-31%"
      elsif(cloudcover==4)
        cc="31%-44%"
      elsif(cloudcover==5)
        cc="44%-56%"
      elsif(cloudcover==6)
        cc="56%-69%"
      elsif(cloudcover==7)
        cc="69%-81%"
      elsif(cloudcover==8)
        cc="81%-94%"
      elsif(cloudcover==9)
        cc="94%-100%"
      end

      weatherType = info_g1["weather"]
      if(weatherType=="clearday" || weatherType== "clearnight")
          icon = 'clear.png'
      elsif(weatherType=="pcloudyday" || weatherType== "pcloudynight")
          icon = 'pcloudy.png'
      elsif(weatherType=="mcloudyday" || weatherType== "mcloudynight")
          icon = 'mcloudy.png'
      elsif(weatherType=="cloudyday" || weatherType== "cloudynight")
          icon ='cloudy.png'
      elsif(weatherType=="humidday" || weatherType== "humidnight")
          icon = 'fog.png'
      elsif(weatherType=="lightrainday" || weatherType== "lightrainnight")
          icon = 'lightrain.png'
      elsif(weatherType=="oshowerday" || weatherType== "oshowernight")
          icon = 'oshower.png'
      elsif(weatherType=="ishowerday" || weatherType== "ishowernight")
          icon = 'ishower.png'
      elsif(weatherType=="lightsnowday" || weatherType== "lightsnownight")
          icon = 'lightsnow.png'
      elsif(weatherType=="rainday" || weatherType== "rainnight")
          icon = 'rain.png'
      elsif(weatherType=="snowday" || weatherType== "snownight")
          icon = 'snow.png'
      elsif(weatherType=="rainsnowday" || weatherType== "rainsnownight")
          icon = 'rainsnow.png'
      end

      velocità_vento = wind10m["speed"]
      if(velocità_vento == 1)
        velocità = "Below 0.3m/s"
      elsif(velocità_vento == 2)
        velocità = "0.3-3.4m/s"
      elsif(velocità_vento == 3)
        velocità = "3.4-8.0m/s"
      elsif(velocità_vento == 4)
        velocità = "8.0-10.8m/s"
      elsif(velocità_vento == 5)
        velocità = "10.8-17.2m/s"
      elsif(velocità_vento == 6)
        velocità = "17.2-24.5m/s"
      elsif(velocità_vento == 7)
        velocità = "24.5-32.6m/s"
      elsif(velocità_vento == 8)
        velocità = "Over 32.6m/s "
      end

      temperatura = info_g1["temp2m"]
      umidità = info_g1["rh2m"]
      direzione_vento = wind10m["direction"]
      prec_type = info_g1["prec_type"]

      format.html { render :index, locals: {icon: icon, temperatura: temperatura, umidità: umidità, cc: cc, direzione_vento: direzione_vento, velocità: velocità, prec_type: prec_type, pa: pa}}
    end


  end
end
