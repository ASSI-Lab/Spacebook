class UserMailer < ApplicationMailer
    default from: 'notifications@example.com'
 
  def blocked_account_email
    @user = params[:user]
    @url  = 'http://127.0.0.1:3000/users/sign_in'
    mail(to: @user.email, subject: 'Your account has been blocked')
  end

  def unlocked_account_email
    @user = params[:user]
    @url  = 'http://127.0.0.1:3000/users/sign_in'
    mail(to: @user.email, subject: 'Your account has been unlocked')
  end  
end