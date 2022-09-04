json.extract! review, :id, :comment, :job_id, :profile_id, :rate, :created_at, :updated_at
json.url review_url(review, format: :json)
