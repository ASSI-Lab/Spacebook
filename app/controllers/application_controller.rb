class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?                  # Aggiunge parametri al controllo di sicurezza di devise

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) do |user_params|
          user_params.permit( :email, :password, :password_confirmation, { roles: [] })     # Parametri permessi (la struttura passata al metodo permit è un array)
        end
    end

    rescue_from CanCan::AccessDenied do |exception|
        redirect_to root_path, :alert => exception.message                                  # Reindirizza alla home in caso di accesso negato da parte di Canard
    end
end
