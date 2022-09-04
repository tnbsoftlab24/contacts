class AssignProfileToJobMailer < ApplicationMailer
  def assign_me(profile,job)
    @profile = profile
    @job = job
    @email = @profile.user.email
    mail(to:  @email, subject: 'Vous avez été assigné a un nouveau job')
  end
end
