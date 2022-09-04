class Experience < ApplicationRecord
  belongs_to :profile
  belongs_to :admin_job_category, :class_name => "Admin::JobCategory"
end
