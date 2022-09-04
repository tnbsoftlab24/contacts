class NewUserWaitingForApprovalMailer < ApplicationMailer
  def activate_profile(user,profile)
    @user = user
    @profile = profile
    mail(to:"notifications@naturetropicale.ca", subject: 'Nouveau Utilisateur à Naturetropicale')
  end
end
