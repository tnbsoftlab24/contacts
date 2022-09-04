class User < ApplicationRecord
  before_save :user_default_status
  after_create :init_profile

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable,
         :omniauthable, omniauth_providers: %i[facebook]

  validates_acceptance_of :terms_conditions


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
        
  enum role: %i[admin enterprise worker assistant comptable]
  has_one :profile, dependent: :destroy
  has_one :souscription, dependent: :destroy
  


  def self.search(search)
    if search
      # p "coco"
      # find(:all, :conditions => ['lower(nom) LIKE ? OR lower(prenom) LIKE ? lower(nom_societe) LIKE ?', "%#{search}%"])
      User.where('lower(email) LIKE  :search', search: "%#{search}%")
    else
      all
    end
  end 

  def init_profile
    if self.id != 1
      self.create_profile!
      self.create_souscription!
    end
  end

  private
    def user_default_status
      self.is_new ||= false
      self.is_validate ||= false
    end
end
