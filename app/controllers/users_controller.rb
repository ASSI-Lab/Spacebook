class UsersController < ApplicationController
    def index
        @users = User.all
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

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
    end

end