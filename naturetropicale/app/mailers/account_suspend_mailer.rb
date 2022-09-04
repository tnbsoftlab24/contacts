class AccountSuspendMailer < ApplicationMailer
  def reject_profile(user, profile)
    @user = user
    @profile = profile
    mail(to: @user, subject: 'Compte Naturetropicale Suspendu')
  end
end





