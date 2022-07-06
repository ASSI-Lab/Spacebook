require "google/apis/calendar_v3"
require "google/api_client/client_secrets.rb"

class PersonalAreaController < ApplicationController
    before_action :authenticate_user!
    helper_method :load_events
    CALENDAR_ID = 'primary'

    def load_events
      begin
        client = Google::Apis::CalendarV3::CalendarService.new
        return unless (current_user.present? && current_user.access_token.present? && current_user.refresh_token.present?) # CONTROLLO PRESENZA TOKEN
        secrets = Google::APIClient::ClientSecrets.new({# FORMATTO I DATI UTENTE E APPLICAZIONE PER LA RICHIESTA DEL TOKEN A GOOGLE
          "web" => {
            "access_token" => current_user.access_token,
            "refresh_token" => current_user.refresh_token,
            "client_id" => ENV["GOOGLE_CLIENT_ID"],
            "client_secret" => ENV["GOOGLE_CLIENT_SECRET"]
          }
        })
        begin
          client.authorization = secrets.to_authorization     # INVIO LA RICHIESTA FORMATTATA A GOOGLE API AUTHORIZER
          client.authorization.grant_type = "refresh_token"
  
          if !current_user.present?# IN CASO DI NON VALIDITÀ DELLA SESSIONE UTENTE CHIEDO IL REFRESH DEL TOKEN
            client.authorization.refresh!
            current_user.update_attributes(# AGGIORNO I DATI UTENTE DEL DB CON IL NUOVO TOKEN
              access_token: client.authorization.access_token,
              refresh_token: client.authorization.refresh_token,
              expires_at: client.authorization.expires_at.to_i
            )
          end
        rescue => e
          flash[:error] = "Il tuo token è scaduto. Per favore esegui nuovamente l'accesso con Google."
          redirect_to :back
        end
        @result = client.list_events(CALENDAR_ID,max_results: 1000,single_events: true,order_by: 'startTime',time_min: Time.now.iso8601)# LEGGO I PROSSIMI 10 EVENTI SUL CALENDAR
        @hash = {}# HASH CHE CONTERRÀ TUTTI GLI EVENTI DEL CALENDAR
        @result.items.each do |event|
          x=[event.summary, event.start.date_time.strftime("%H:%M")]
          print x
          @hash[event.start.date_time.strftime("%Y-%m-%d").to_s]=x# AGGIUNGO GLI EVENTI FORMATTANDONE LA DATA CHE VIENE USATA COME CHIAVE
        end
        return @hash
      rescue => exception
        print "\n\n\n\nERRORE\n",exception,"\n\n\n\n"
      end
    end

end
