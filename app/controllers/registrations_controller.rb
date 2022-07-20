require 'net/http'
require 'net/https'
class RegistrationsController < Devise::RegistrationsController
    # POST /resource
    def create
        build_resource(sign_up_params)
        # Chiamo AbstractApi per controllare l'esistenza della mail inserita per la registrazione(NUMERO DI CHIAMATE LIMITATO LASCIARE IL CODICE COMMENTATO E DECOMENTARLO SOLO PER I TEST!!)
        # CODICE COMMENTATO CAUSA CHIAMATE LIMITATE #####
        # response = make_abstract_request(resource.email)
        # if response=='error'
        #     redirect_to(request.referrer, alert:"Errore nel controllo validità mail controlla la tua connessione!")
        #     return
        # elsif response[0]=='200' && response[1]=='UNDELIVERABLE'
        #     redirect_to(request.referrer, alert:"L'email inserita non è valida controlla il campo e riprova!")
        #     return
        # end
        ################
        resource.save
        yield resource if block_given?
        if resource.persisted?
            if resource.active_for_authentication?
                set_flash_message! :notice, :signed_up
                sign_up(resource_name, resource)
                respond_with resource, location: after_sign_up_path_for(resource)
            else
                set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
                expire_data_after_sign_in!
                respond_with resource, location: after_inactive_sign_up_path_for(resource)
            end
        else
            clean_up_passwords resource
            set_minimum_password_length
            redirect_to(request.referrer, alert:resource.errors.full_messages[0])
        end
    end

    # Chiamo l'email verifier di AbstractApi per la verifica dell'esistenza dellla mail inserita (gestisco tutto tramite chiamate http)
    def make_abstract_request(email)
        uri = URI("https://emailvalidation.abstractapi.com/v1/?api_key=#{ENV['ABSTRACT_KEY']}&email=#{email}")
    
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    
        request =  Net::HTTP::Get.new(uri)
    
        response = http.request(request)
        deliv = JSON.parse(response.body)
        puts "Status code: #{ response.code }"
        puts "Response body: #{ response.body }"
        return [response.code,deliv["deliverability"]]
    rescue StandardError => error
        puts "Error (#{ error.message })"
        return "error"
    end

    protected

    def after_sign_up_path_for(resource)
        if current_user.is_manager?
            #print ("\n\n\n\n manager \n\n\n\n\n")
            '/make_department' # Or :prefix_to_your_route
        elsif current_user.is_admin?
            #print ("\n\n\n\n non manager \n\n\n\n")
            '/home'
        elsif current_user.is_user?
            '/home'
        else
            '/home'
        end
    end
end