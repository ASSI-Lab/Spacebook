class SessionsController < Devise::SessionsController

    def new
        self.resource = resource_class.new(sign_in_params)
        clean_up_passwords(resource)
        yield resource if block_given?
        respond_with(resource, serialize_options(resource))
    end
    
    def create
        self.resource = warden.authenticate!(auth_options)
        set_flash_message!(:notice, :signed_in)
        sign_in(resource_name, resource)
        yield resource if block_given?
        get_user_coord(resource)
        respond_with resource, location: after_sign_in_path_for(resource)
    end

    # DELETE /resource/sign_out
    def destroy
        # Elimino dati geolocalizzazione utente
        current_user.latitude=nil
        current_user.longitude=nil
        current_user.remember_created_at=nil
        current_user.save
        signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
        set_flash_message! :notice, :signed_out if signed_out
        yield if block_given?
        respond_to_on_destroy
    end

    def get_user_coord(user)
        if user.longitude!=nil && user.latitude!=nil
          return
        else
          user_coord = make_abstract_request
          if user_coord!='error'
            user.latitude=user_coord[0]
            user.longitude=user_coord[1]
            user.save
            return
          else
            user.latitude="41.89333"
            user.longitude="12.48302"
            user.save
            return
          end
        end
    end
    
    def make_abstract_request
        uri = URI("https://ipgeolocation.abstractapi.com/v1/?api_key=#{ENV['ABSTRACT_GEO_KEY']}")

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER

        request =  Net::HTTP::Get.new(uri)

        response = http.request(request)
        puts "Status code: #{ response.code }"
        puts "Response body: #{ response.body }"
        deliv = JSON.parse(response.body)
        return [deliv["latitude"],deliv["longitude"]]
    rescue StandardError => error
        puts "Error (#{ error.message })"
        return "error"
    end    

end