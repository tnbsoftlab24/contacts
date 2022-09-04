class Paiement < ApplicationRecord
  belongs_to :profile_id, class_name: 'Profile', optional: true
  has_many :jobs
  # validates  :montant,:received,:comment,:owner_id, presence: true
  has_one_attached :received

  # def received_attached?
  #   self.received.attached?
  # end


  def received_url
    if self.received.attached?
      Rails.application.routes.url_helpers.rails_blob_path(self.received, only_path: true)
    else
      nil
    end
  end
end
