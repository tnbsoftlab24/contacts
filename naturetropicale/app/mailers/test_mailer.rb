class TestMailer < ApplicationMailer
  def test(user)
    @user = user
    attachments.inline["logo.png"] = File.read("#{Rails.root}/app/javascript/images/logo.png")
    mail(to: @user.email, subject: "Test Mailer")
  end
end
