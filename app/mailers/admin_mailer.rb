class AdminMailer < ApplicationMailer

  def request_manager_role_email
    @user = params[:user]
    @url  = 'http://127.0.0.1:3000/users/sign_in'
    mail(to: @user.email, subject: 'The user '+@user.email+' requested manager role!')
  end

end
