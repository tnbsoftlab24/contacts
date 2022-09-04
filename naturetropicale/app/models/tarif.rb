class Tarif < ApplicationRecord
  belongs_to :admin_job_category, class_name: "Admin::JobCategory"
  belongs_to :profile

  # validates  :prix, presence: true
end
