class InviteProfileToJobMailer < ApplicationMailer
  def invite_me(profile,job)
    @profile = profile
    @job = job
    @email = @profile.user.email
    mail(to:  @email, subject: 'Vous avez été invité a un nouveau job')
  end
end
