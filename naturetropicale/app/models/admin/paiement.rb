class Admin::Paiement < ApplicationRecord
  has_one :profile
  has_many :jobs
  # mount_uploader :received, AttachmentUploader 
  has_one_attached :received
  # validates  :montant,:received,:comment,:owner_id, presence: true

  enum status: %i[impayer payer]

end
