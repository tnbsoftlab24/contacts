class Review < ApplicationRecord
  # after_save :set_reviews_average, set_reviews_count
  belongs_to :job
  belongs_to :profile

  

  # Note: update_column won't trigger callbacks

  # def set_reviews_average
  #   update_column(:reviews_average, reviews.average(:rate)) 
  # end

  # def set_reviews_count
  #   update_column(:reviews_count, reviews.count) 
  # end
end
