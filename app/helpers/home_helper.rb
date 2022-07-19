require 'json'

module HomeHelper

    def get_meteo_info (lati,long)
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
            icon = image_path('clear.png')
        elsif(weatherType=="pcloudyday" || weatherType== "pcloudynight")
            icon = image_path('pcloudy.png')
        elsif(weatherType=="mcloudyday" || weatherType== "mcloudynight")
            icon = image_path('mccloudy.png')
        elsif(weatherType=="cloudyday" || weatherType== "cloudynight")
            icon =image_path('cloudy.png')
        elsif(weatherType=="humidday" || weatherType== "humidnight")
            icon = image_path('fog.png')
        elsif(weatherType=="lightrainday" || weatherType== "lightrainnight")
            icon = image_path('lightrain.png')
        elsif(weatherType=="oshowerday" || weatherType== "oshowernight")
            icon = image_path('oshower.png')
        elsif(weatherType=="ishowerday" || weatherType== "ishowernight")
            icon = image_path('ishower.png')
        elsif(weatherType=="lightsnowday" || weatherType== "lightsnownight")
            icon = image_path('lightsnow.png')
        elsif(weatherType=="rainday" || weatherType== "rainnight")
            icon = image_path('rain.png')
        elsif(weatherType=="snowday" || weatherType== "snownight")
            icon = image_path('snow.png')
        elsif(weatherType=="rainsnowday" || weatherType== "rainsnownight")
            icon = image_path('rainsnow.png')
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
        
        
        return [icon,temperatura,umidità,cc,direzione_vento,velocità,prec_type,pa]
  
  
    end
  

end
