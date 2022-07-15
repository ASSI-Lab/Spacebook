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
          if @user.roles_mask != nil                            ####################
            print "\n\n\n",@user.roles_mask,"\n\n\n"            #
          else                                                  #
            print "\n\n\n SENZA RUOLO \n\n\n"                   #
            u = @user                                           # FUNZIONALITÀ CHE ASSOCIA A CHI USA LOGIN GOOGLE IL RUOLO DI ADMIN(SOLO TEST!!!)
            u.roles = ['admin']                                 #
            u.save                                              #
            print "\n\n\n",u.roles_mask,"\n\n\n"                #
          end                                                   ####################
          sign_in_and_redirect @user, event: :authentication
        else
          session['devise.google_data'] = request.env['omniauth.auth'].except('extra') # Removing extra as it can overflow some session stores
          redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
        end
    end
  end