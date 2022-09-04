# json.extract! job, :id, :title, :description, :start_date, :end_date, :nbre_pause, :profile_id, :post_category_id, :created_at, :updated_at
# json.url job_url(job, format: :json)
# date_format = job.all_day_job? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'

  json.extract! job, :id, :information_specifique, :description 
  # :poste, :information_specifique, :description, :start_date, :end_date, :nbre_pause, :owner_id, :status, :admin_job_category_id
  json.title "#{job.admin_job_category.title}" 
  json.start job.start_date    
  json.end job.end_date 
  json.status job.status 
  json.owner job.owner.nom_societe
  json.poste job.poste.parameterize
  json.worker job.worker_name
  json.ville job.ville
  json.region job.region
  json.province job.province
  json.allDay false
  json.className 'important'
  json.url job_url(job, format: :html) 
  json.color job.color
