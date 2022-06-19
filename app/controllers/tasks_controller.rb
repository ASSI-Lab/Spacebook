require "google/apis/calendar_v3"
require "google/api_client/client_secrets.rb"

class TasksController < ApplicationController
  CALENDAR_ID = 'primary'

  def index
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  def create
      client = get_google_calendar_client current_user          # INIZIALIZZO SERVIZIO CALENDAR
      task = params[:task]                                      # CREO PARAMETRI PER EVENTO
      event = get_event task                                    # FORMATTO PER RICHIESTA API CALENDAR
      client.insert_event('primary', event)                     # INSERISCO L'EVENTO CREATO SU CALENDAR
      redirect_to tasks_path
      flash[:notice] = 'Evento aggiunto con successo.'
  end

  def show
    client = get_google_calendar_client current_user # INIZIALIZZO CLIENT GOOGLE CALENDAR
    @result = client.list_events(CALENDAR_ID,
                                  max_results: 10,
                                  single_events: true,
                                  order_by: 'startTime',
                                  time_min: Time.now.iso8601)
    client
  end

  def get_google_calendar_client current_user
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
      client
  end

  private

  def get_event task   # FORMATTO I DATI RACCOLTI PER L'INVIO A GOOGLE CALENDAR API
      attendees = task[:members].split(',').map{ |t| {email: t.strip} }
      event = Google::Apis::CalendarV3::Event.new(
      summary: task[:title],
      location: task[:place],
      description: task[:description],
      start: {
          date_time: Time.new(task['start_date(1i)'],task['start_date(2i)'],task['start_date(3i)'],task['start_date(4i)'],task['start_date(5i)']).to_datetime.rfc3339,
          time_zone: "Europe/Rome"
      },
      end: {
          date_time: Time.new(task['end_date(1i)'],task['end_date(2i)'],task['end_date(3i)'],task['end_date(4i)'],task['end_date(5i)']).to_datetime.rfc3339,
          time_zone: "Europe/Rome"
      },
      attendees: attendees,
      reminders: {
          use_default: false,
          overrides: [
          Google::Apis::CalendarV3::EventReminder.new(reminder_method:"popup", minutes: 10),
          Google::Apis::CalendarV3::EventReminder.new(reminder_method:"email", minutes: 20)
          ]
      },
      notification_settings: {
          notifications: [
                          {type: 'event_creation', method: 'email'},
                          {type: 'event_change', method: 'email'},
                          {type: 'event_cancellation', method: 'email'},
                          {type: 'event_response', method: 'email'}
                      ]
      }, 'primary': true
      )
  end
end

