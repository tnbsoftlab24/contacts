module JobsHelper
  def total_paiement(id)
    profile = Profile.find(id)
    if profile.user.enterprise?
      sum = Job.where(owner_id: id, status: 3).sum("job_money")
      subscription = Paiement.where("owner_id = ? AND subscription =?", id, true).sum("montant")
      restant =  Paiement.where("owner_id = ? AND subscription =?", id, false).sum("montant")
      total = (subscription.to_f - sum.to_f) + restant.to_f
    elsif  profile.user.worker?
      proposals = Proposal.where(owner_id: id)
      @totalpai = 0 
      proposals&.each do |proposal|
        if proposal.job.status == "finished"
          @totalpai += proposal.job.employee_money.to_f
        end
      end
      subscription = Paiement.where("owner_id = ? AND subscription =?", id, true).sum("montant")
      restant =  Paiement.where("owner_id = ? AND subscription =?", id, false).sum("montant")
      total = (subscription.to_f +  @totalpai) - restant.to_f 
    end
    return total
  end
end
