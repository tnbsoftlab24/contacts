class MultiPlace < ApplicationRecord
  before_save :set_adresse
  # attr_accessor :address1, :address2, :country, :region, :province, :code_postal,:ville
  belongs_to :profile

  def set_adresse
    # self.adresse = self.[draft_address1, draft_address2, draft_country, draft_region, draft_province draft_code_postal, draft_ville].compact.join(', ')
    self.adresse = "#{self.adresse1}, #{self.adresse2}, #{self.country}, #{self.region} , #{self.province} , #{self.ville },  #{self.code_postal}"
  end
end
