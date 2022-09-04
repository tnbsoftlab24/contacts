desc 'Test query'
task test_query: :environment do
  ActiveRecord::Base.transaction do
    profile = current_user.profile
    freetimes = profile.freetimes
    jobs=[]
    freetimes.each do |f|
      jobs = Job.where("start_date >= ? and end_date <= ?",f.start_date, f.end_date)
    end
  end
end