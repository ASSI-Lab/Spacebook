class AdminMailer < ApplicationMailer

  def request_manager_role_email(admin_mail)
    @user = params[:user]
    @url  = 'http://127.0.0.1:3000/users/sign_in'
    mail(to: admin_mail, subject: 'The user '+@user.email+' requested manager role!')
  end

end
