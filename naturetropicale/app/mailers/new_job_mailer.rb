class NewJobMailer < ApplicationMailer
  layout 'mailer'
  def new_job(job)
    @job = job
    # attachments.inline["logo.png"] = File.read("#{Rails.root}/app/javascript/images/logo.png")
    mail(to: 'notifications@naturetropicale.ca', subject: 'Un nouveau job a été crée')
  end
end
