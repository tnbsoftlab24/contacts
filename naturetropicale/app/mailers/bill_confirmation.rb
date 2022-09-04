class BillConfirmationMailer < ApplicationMailer
  def bill_confirmation(user)
    @user = user
    attachments.inline["logo.png"] = File.read("#{Rails.root}/app/javascript/images/logo.png")
    mail(to:'notifications@naturetropicale.ca', subject: "Vous avez reçu une facture paiement")
  end
end
