class PersonalAreaController < ApplicationController
    before_action :authenticate_user!
    helper_method :load_events
    CALENDAR_ID = 'primary'

    def load_events
      begin
        client = Google::Apis::CalendarV3::CalendarService.new
        client_authorization = Signet::OAuth2::Client.new
        client_authorization.client_id = ENV["GOOGLE_CLIENT_ID"]
        client_authorization.client_secret = ENV["GOOGLE_CLIENT_SECRET"]
        client_authorization.access_token = current_user.access_token
        client_authorization.refresh_token = current_user.refresh_token
        client_authorization.expires_at = current_user.expires_at

        if current_user.expires_at <= Time.now.to_i
          redirect_to "/session_timeout"
        end

        client.authorization = client_authorization
        client.authorization.grant_type = "refresh_token"
        @result = client.list_events(CALENDAR_ID,max_results: 1000,single_events: true,order_by: 'startTime',time_min: Time.now.iso8601) # LEGGO I PROSSIMI 10 EVENTI SUL CALENDAR
        @hash = {} # HASH CHE CONTERRÀ TUTTI GLI EVENTI DEL CALENDAR
        @result.items.each do |event|
          x=[event.summary, event.start.date_time.strftime("%H:%M")]
          print x
          @hash[event.start.date_time.strftime("%Y-%m-%d").to_s]=x # AGGIUNGO GLI EVENTI FORMATTANDONE LA DATA CHE VIENE USATA COME CHIAVE
        end
        return @hash
      rescue => exception
        print "\n\n\n\nERRORE\n",exception,"\n\n\n\n"
      end
    end

end
