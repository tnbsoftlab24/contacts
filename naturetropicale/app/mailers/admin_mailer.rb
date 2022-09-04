class AdminMailer < ApplicationMailer
  layout 'mailer'
  def new_user_waiting_for_approval(email)
    @email = email
    mail(to: 'notifications@naturetropicale.ca', subject: 'Activation de compte en attente')
  end
end
