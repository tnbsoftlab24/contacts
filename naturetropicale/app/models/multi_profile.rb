class MultiProfile < ApplicationRecord
  belongs_to :admin_job_category, :class_name => "Admin::JobCategory"
  belongs_to :profile
end
