class JobFinishedMailer < ApplicationMailer
  layout 'mailer'
  def job_ended(job_owner, job)
    p "dodo"
    @job_owner = job_owner
    @job = job
    p "dodooooooo"
    # @emails =  [@job_owner.user.email,"notifications@naturetropicale.ca"]
    # @emails.each do |email|
    #   p email
      mail(to: @job_owner.user.email, cci:'notifications@naturetropicale.ca', subject: 'Job terminé')
    # end
  end
end
