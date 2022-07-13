class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?                  # Aggiunge parametri al controllo di sicurezza di devise
    helper_method :require_department
    helper_method :dep_seats_translation

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) do |user_params|
          user_params.permit( :email, :password, :password_confirmation, { roles: [] })     # Parametri permessi DEVISE (la struttura passata al metodo permit è un array)
        end
    end

    rescue_from CanCan::AccessDenied do |exception|                                          # Reindirizza alla pagina corrente in caso di accesso negato da parte di Canard
        redirect_back(fallback_location: root_path)                                          # in caso di errore di path reindirizza alla home 
        flash[:alert] = exception.message                                                    # Mostra messagio di errore
    end

    rescue_from SQLite3::ConstraintException do |exception|                                                                 # Reindirizza alla pagina corrente se i dati inseriti non rispettano i vincoli sul database
        redirect_back(fallback_location: root_path)                                                                         # in caso di errore di path reindirizza alla home
        flash[:alert] = 'Questi dati sono gia stati inseriti da un altro utente. In particolare: [ '+exception.message+' ]' # Mostra messagio di errore
    end

    def require_department
        flash[:alert] = "Attenzione: Come manager devi creare un dipartimento!" # Mostra messagio di spiegazione
        redirect_to '/make_department'                                          # Reindirizza alla pagina di creazione del dipartimento
    end

end
