class Job < ApplicationRecord
  after_initialize :job_default_values
  before_save :set_end_date, :set_color, :set_post_name
  # after_validation :set_color
  attr_accessor :draft_end_date, :draft_job_mins
  # attr_accessible :poste

  belongs_to :owner, class_name: 'Profile', optional: true
  # belongs_to :profile_id
  belongs_to :admin_job_category, :class_name => "Admin::JobCategory"
  enum status: %i[draft posted in_progress finished archived]
  enum type_adress: %i[0 1]
  has_one :proposal
  has_many :extras
  has_many :reviews
  has_many :invitations
  accepts_nested_attributes_for :extras, allow_destroy: true,reject_if: proc { |att| att['prix_entreprise'].blank? }

  validates :admin_job_category_id, :start_date, presence: true
  
  def set_end_date
    self.end_date = Time.at(self.start_date + self.draft_end_date.to_i*3600 + self.draft_job_mins.to_i*60)  
    @profile = Profile.find(self.owner_id)
    if self.job_adress.empty?
      @adress = @profile.adresse
    else
      @adress = self.job_adress
    end
    @table_adresse = @adress.split(", ").last(4)
    self.province =  @table_adresse[1].to_s
    self.ville =  @table_adresse[2].to_s
    self.region =  @table_adresse[0].to_s
    @profile = Profile.find(self.owner_id)
  end

  def self.search(search)
    if search
      Job.where('lower(poste) LIKE  :search OR lower(job_adress) LIKE  :search', search: "%#{search}%")
    else
      all
    end
  end

  def set_post_name
    @job = Admin::JobCategory.find(self.admin_job_category_id).title
    self.poste = @job 
  end
  
  def set_color
    if self.factor == 1 && self.taux == false
      self.color = "green"
    elsif self.factor == 1 && self.taux == true
      self.color = "yellow"
    elsif self.factor == 2 && self.taux == false
      self.color = "orange"
    elsif self.factor == 2 && self.taux == true
      self.color = "red"
    end
  end

  private
    def job_default_values
      self.status ||= "draft"
      self.new_proposal ||= false
    end
end
