class EnterpriseBillMailer < ApplicationMailer
  def new_bill(user)
    @profile = user
    attachments.inline["logo.png"] = File.read("#{Rails.root}/app/javascript/images/logo.png")
    mail(to: @profile.user.email, subject: "Vous avez reçu une nouvelle de facture")
  end
end
