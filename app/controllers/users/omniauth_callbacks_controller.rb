# app/controllers/users/omniauth_callbacks_controller.rb:

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
        # You need to implement the method below in your model (e.g. app/models/user.rb)
        @user = User.from_omniauth(request.env['omniauth.auth'])
  
        if @user.persisted?
          flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
          auth = request.env["omniauth.auth"]                   # RICHIEDO A GOOGLE HASH DI AUTORIZZAZIONE(CONTIENE I DATI DEL PROFILO GOOGLE DELL'UTENTE)
          @user.access_token = auth.credentials.token           # AGGIUNGO ACCESS TOKEN UTENTE AL DATABASE
          @user.expires_at = auth.credentials.expires_at        # AGGIUNGO DATA SCADENZA TOKEN UTENTE AL DATABASE
          @user.refresh_token = auth.credentials.refresh_token  # AGGIUNGO TOKEN DI REFRESH AL DATABASE
          @user.provider = "Google"
          @user.save!
          get_user_coord(@user)
          sign_in_and_redirect @user, event: :authentication
        else
          session['devise.google_data'] = request.env['omniauth.auth'].except('extra') # Removing extra as it can overflow some session stores
          redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
        end
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