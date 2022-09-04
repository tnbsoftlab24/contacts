class Proposal < ApplicationRecord
  after_initialize :proposal_default_values
  belongs_to :job
  belongs_to :owner, class_name: 'Profile'
  enum status: %i[en_cours accepté refusé]

  def self.for_owner(account)
    find_by(owner: current_user.profile.id)
  end

  private
    def proposal_default_values
      self.status ||= "en_cours"
    end
end
