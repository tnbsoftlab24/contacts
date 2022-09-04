class Contact < ApplicationRecord
  has_paper_trail  only: [:first_name, :last_name, :email, :phone_number], on: [:update]
  
  validates :first_name, :last_name, :email, :phone_number, presence: true
  validates :email, uniqueness: true

  scope :ordered, -> { order(id: :desc) }
  broadcasts_to ->(contact) { "contacts" }, inserts_by: :prepend
end
