class AccountActivateMailer < ApplicationMailer
  def account_activate(user, profile)
    @profile = profile
    @user = user
    mail(to: @user, subject: 'Votre Compte à été validé')
  end
end
