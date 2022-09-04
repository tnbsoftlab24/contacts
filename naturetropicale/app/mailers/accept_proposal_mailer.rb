class AcceptProposalMailer < ApplicationMailer
  def accept_proposal(proposal)
    @proposal = proposal
    @proposal_owner = @proposal.owner.user.email
    mail(to: @proposal_owner, subject: 'Votre proposition a ete accepté')
  end
end
