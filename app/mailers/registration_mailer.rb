class RegistrationMailer < ApplicationMailer

  default from: "yuya.toyoda@gmail.com"

  def registration_email(@user)
    @name = @user.name
    mail to: @user.email, subject: "FiNC日報へようこそ"
  end
end
