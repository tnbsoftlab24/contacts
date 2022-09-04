class ReviewsMailer < ApplicationMailer
  layout 'mailer'
  def new_review(profile)
    @profile = profile
    # attachments.inline["logo.png"] = File.read("#{Rails.root}/app/javascript/images/logo.png")
    mail(to: @profile.user.email, subject: 'Vous avez été noté')
  end
end
