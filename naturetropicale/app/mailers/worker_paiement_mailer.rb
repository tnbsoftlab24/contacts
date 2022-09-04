class WorkerPaiementMailer < ApplicationMailer
  def new_paiement(user)
    @user = user
    attachments.inline["logo.png"] = File.read("#{Rails.root}/app/javascript/images/logo.png")
    mail(to: @user.email, subject: "Vous avez reçu une confirmation de paiement")
  end
end
