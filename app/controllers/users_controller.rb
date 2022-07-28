class UsersController < ApplicationController

    def ban
        @user = User.find(params[:id])
        if @user.access_locked?
            @user.unlock_access!
            @user.locking_reason = nil
            @user.save
            UserMailer.with(user: @user).unlocked_account_email.deliver_now
        else
            @user.lock_access!
            @user.locking_reason = "Bloccato dall'amministratore"
            @user.save
            UserMailer.with(user: @user).blocked_account_email.deliver_now
        end
        redirect_to request.referrer
        flash[:notice] = "L' account (\"#{@user.email}\") è stato #{@user.access_locked? ? "bloccato" : "sbloccato"} con successo!"
    end

    def set_manager
        @user = User.find(params[:id])
        if @user.is_manager?
            @user.role='user'
            @user.save
            UserMailer.with(user: @user).removed_manager_email.deliver_now
        elsif @user.is_user?
            @user.role='manager'
            @user.save
            UserMailer.with(user: @user).accepted_manager_email.deliver_now
        end
        @user.requested_manager = nil
        @user.save
        redirect_to request.referrer
        flash[:notice] = "All' account (\"#{@user.email}\") è stato #{@user.is_manager? ? "aggiunto" : "rimosso"} il ruolo di Manager con successo!"
    end

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :requested_manager)
    end

    def manager_req
        @user = User.find(params[:id])
        @user.requested_manager = 'true'
        @user.save
        User.where(role: 'admin').each do |admin|
        AdminMailer.with(user: @user).request_manager_role_email(admin.email).deliver_now
        end
        redirect_to request.referrer
        flash[:notice] = "Hai richiesto il ruolo di Manager con successo!"
    end

    def get_user_coord
        user = User.find(params[:id])
        user_coord = make_abstract_request
        if user_coord!='error'
            user.latitude=user_coord[0]
            user.longitude=user_coord[1]
            user.save
            redirect_to request.referrer
            flash[:notice] = "Posizione rilevata correttamente. Mappa centrata sulla tua posizione!"
            return
        else
            user.latitude="41.89333"
            user.longitude="12.48302"
            user.save
            redirect_to request.referrer
            flash[:notice] = "Posizione non rilevata! Mappa centrata su Roma!"
            return
        end
    end

    def make_abstract_request
        uri = URI("https://ipgeolocation.abstractapi.com/v1/?api_key=#{ENV["ABSTRACT_GEO_KEY"]}")

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER

        request =  Net::HTTP::Get.new(uri)

        response = http.request(request)
        #puts "Status code: #{ response.code }"
        #puts "Response body: #{ response.body }"
        deliv = JSON.parse(response.body)
        return [deliv["latitude"],deliv["longitude"]]
    rescue StandardError => error
        puts "Error (#{ error.message })"
        return "error"
    end

end