class UsersController < ApplicationController
    def reg
        redirect_to '/users/sign_up'
        flash[:notice] = "Errore registrazione!\nControlla i campi inseriti."
    end

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
        redirect_to request.referrer
        flash[:notice] = "All' account (\"#{@user.email}\") è stato #{@user.is_manager? ? "aggiunto" : "rimosso"} il ruolo di Manager con successo!"
    end    

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :requested_manager)
    end

end