class PremiumJobCategoryMailer < ApplicationMailer
  def premium_job_category(proposal)
    @proposal = proposal
    @job_owner_email = @proposal.job.owner.user.email
    mail(to: @proposal_owner_email, subject: 'Nouvelle proposition pour votre job')
  end
end
