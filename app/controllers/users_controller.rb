class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def ban
        @user = User.find(params[:id])
        if @user.access_locked?
            @user.unlock_access!
        else
            @user.lock_access!
        end
        redirect_to request.referrer
        flash[:notice] = "Account utente(#{@user.email}) bloccato: #{@user.access_locked?}"
    end
end