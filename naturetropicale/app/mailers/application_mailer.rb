class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('MAILER_NO_REPLY') { 'Naturetropicale Team <notifications@naturetropicale.ca>' }
  layout 'mailer'

  append_view_path("#{Rails.root}/app/views/mailers")
end
