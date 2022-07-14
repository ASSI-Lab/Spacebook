class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def ban
        @user = User.find(params[:id])
        if @user.access_locked?
            @user.unlock_access!
            UserMailer.with(user: @user).unlocked_account_email.deliver_now
        else
            @user.lock_access!
            UserMailer.with(user: @user).blocked_account_email.deliver_now
        end
        redirect_to request.referrer
        flash[:notice] = "Account utente(#{@user.email}) bloccato: #{@user.access_locked?}"
    end
end