class ValidateAccountMailer < ApplicationMailer
  def new_profile(user, profile)
    @user = user
    @profile = profile
    mail(to: @user, subject: 'Bienvenue A Naturetropicale')
  end
end
