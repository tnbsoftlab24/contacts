class Admin::JobCategory < ApplicationRecord
  has_many :children, :class_name => "Admin::JobCategory", :foreign_key => "parent_id", :dependent => :destroy
  belongs_to :parent, :class_name => "Admin::JobCategory",:optional => true
  has_many :multi_profiles
  has_many :profiles, through: :multi_profiles
  # has_many :admin_job_categories, :through => :admin_job_categories
  has_many :tarifs
  has_many :jobs
  has_many :experiences
end
