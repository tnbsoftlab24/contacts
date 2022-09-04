# == Schema Information
#
# Table Name :profiles 
  # t.string :nom
  # t.string :prenom
  # t.string :num_tel
  # t.string :nationalite
  # t.string :adresse1
  # t.string :adresse2
  # t.string :ville
  # t.string :region
  # t.string :province
  # t.string :pays
  # t.string :code_postal
  # t.string :secteur_activite
  # t.string :post_souhaite
  # t.string :nom_contact
  # t.string :tel_contact
  # t.string :email_contact
  # t.string :sondage
  # t.string :nom_societe
  # t.string :num_entreprise_quebec
  # t.string :statut_juridique
  # t.string :nom_actionnaire_principal
  # t.string :actionnaire_tel
  # t.string :actionnaire_email
  # # t.string :nom_gestionnaire
  # # t.string :num_gesttionnaire
  # t.string :photo
  # t.string :cv
  # t.reference,
  # t.references :user, null: false, foreign_key: true

class Profile < ApplicationRecord
  before_save :set_adresse_principal

  belongs_to :user
  belongs_to :paiement, class_name: '::Admin::Paiement', :optional => true
  has_many :tarifs
  has_many :multi_profiles
  has_many :admin_job_categories, class_name: 'Admin::JobCategory', through: :multi_profiles
  has_many :admin_job_categories, class_name: 'Admin::JobCategory', through: :tarifs
  has_many :jobs, dependent: :destroy, foreign_key: :owner_id
  has_many :proposals, class_name: 'Proposal', dependent: :destroy, foreign_key: :owner_id
  has_many :experiences
  has_many :multi_places
  has_many :freetimes
  has_many :invitations


  def set_adresse_principal
    self.adresse = "#{self.adresse1}, #{self.adresse2}, #{self.pays}, #{self.region} , #{self.province} , #{self.ville },  #{self.code_postal}"
  end

  accepts_nested_attributes_for :experiences, allow_destroy: true,reject_if: proc { |att| att['description'].blank? }
  accepts_nested_attributes_for :multi_profiles, allow_destroy: true,reject_if: proc { |att| att['admin_job_category_id'].blank? }
  accepts_nested_attributes_for :tarifs, allow_destroy: true,reject_if: proc { |att| att['admin_job_category_id'].blank? }
  accepts_nested_attributes_for :multi_places, allow_destroy: true,reject_if: proc { |att| (att['adresse1'].blank? && att['province'].blank? && att['ville'].blank?) }
  accepts_nested_attributes_for :freetimes, allow_destroy: true,reject_if: proc { |att| att['start_date'].blank? }

  has_many :reviews

  enum pricing_plan: %i[premium free]
  has_one_attached :photo
  # mount_uploader :photo, ImageUploader 
  has_one_attached :cv # Tells rails to use this uploader for this model.

  def photo_url
    if self.photo.attached?
      Rails.application.routes.url_helpers.rails_blob_path(self.photo, only_path: true)
    else
      nil
    end
  end

  def cv_url
    if self.cv.attached?
      Rails.application.routes.url_helpers.rails_blob_path(self.cv, only_path: true)
    else
      nil
    end
  end

  # validate :picture_size_validation

  # def validate_minimum_image_size
  #   image = MiniMagick::Image.open(picture.path)
  #   unless image[:width] > 400 && image[:height] > 400
  #     errors.add :image, "should be 400x400px minimum!" 
  #   end
  # end

  # validates :photo, image_size: { width: 150, height: 150 }, presence: true
  # validates :photo, :presence => true, size_range: 1..3.megabytes
  # validates_size_of :photo,:cv, maximum: 4.megabytes, message: "doit etre inferieur a 4MB"
  validates  :num_tel, presence:true, if: :worker?, on: [:update ]
  validates  :tel_contact, :actionnaire_tel,presence: {:message=> "Les champs contacts sont obligatoire"}, if: :enterprise?, on: [:update ]
  validates  :adresse1,:sondage,:pays, :ville, :region,:code_postal, presence: true, on: [:update ]
  validates  :pricing_plan, presence: {:message=> "Vous Devez choisir obligatoirement un plan"}, on: [:update ]

  validates :nationalite,:nom, :prenom,:post_souhaite, presence: true, if: :worker?, on: [:update]
  
  validates :nom_societe,:num_entreprise_quebec, :statut_juridique, :nom_actionnaire_principal,:actionnaire_tel,
             :nom_actionnaire_principal, :statut_juridique, :nom_actionnaire_principal, 
            :actionnaire_email,:nom_contact,:email_contact,  presence: true, if: :enterprise?, on: [:update ]


  def self.search(search)
    if search
      # p "coco"
      # find(:all, :conditions => ['lower(nom) LIKE ? OR lower(prenom) LIKE ? lower(nom_societe) LIKE ?', "%#{search}%"])
      Profile.where('lower(nom) LIKE  :search OR lower(prenom) LIKE  :search OR lower(nom_societe) LIKE  :search', search: "%#{search}%")
    else
      all
    end
  end     

  # validates :state, presence: true, if: :has_country?

  

  def enterprise?
    user.enterprise?
  end

  def worker?
    user.worker?
  end

  private

  def total_remuneration
    Profile.all.each do |prof|
      self.remuneration =  Job.where(owner_id: prof.id).sum("job_money")
    end
  end
  
end
