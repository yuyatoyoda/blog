class RegistrationMailer < ApplicationMailer

  default from: "yuya.toyoda@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.registration_mailer.registration_email.subject
  #
  def registration_email(user)
    @name = user.name
    mail to: user.email, subject: "FiNC日報へようこそ"
  end
end
