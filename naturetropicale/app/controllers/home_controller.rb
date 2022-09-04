class HomeController < ApplicationController
  before_action :approved, unless: :devise_controller?, except: [:welcome_to_naturetropicale]
  # layout 'page_without_header',  :only => :waiting_for_validation
  def index
     if current_user.enterprise?
        @jobs = Job.search(params[:search]).where("(owner_id =?) AND (status =?)",current_user.id, 1 ).order(sort_column + " " + sort_direction).paginate(:per_page => 20, :page => params[:page])
        @final_jobs = Job.where('admin_job_category_id IN (?) OR poste = ? AND status !=? AND end_date >=?', @job_b,current_user.profile.post_souhaite, 0, Date.today).order('id desc')
     elsif current_user.admin?
        @jobs = Job.search(params[:search]).where("(status =?) ", 1 ).order(sort_column + " " + sort_direction).paginate(:per_page => 20, :page => params[:page])
        @final_jobs = Job.where('admin_job_category_id IN (?) OR poste = ? AND status !=?', @job_b,current_user.profile.post_souhaite, 0).order('id desc')
     else

      @job_b ||= []
      @profile_job = current_user.profile.multi_profiles.each do |test|
        @job_b << test.admin_job_category_id
      end
      @profile_jobs = Job.where('admin_job_category_id IN (?) OR poste = ?', @job_b,current_user.profile.post_souhaite)
      @final_jobs =  @profile_jobs.where("status !=? AND end_date >=?", 0,Date.today).order('id desc')
      @jobs = @profile_jobs.where("status = ?AND end_date >=?", 1 ,Date.today).search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 20, :page => params[:page])
      # @available_jobs =  @profile_jobs.where("status = ?AND end_date >=?", 1 ,Date.today)
     end

     @provinces = Admin::Location::Province.order("name")
     @regions = Admin::Location::Region.order('name')
     @villes = Admin::Location::Ville.order("name")

    #  TestMailer.test(@user).deliver_now
    # client = Twilio::REST::Client.new
    # client.messages.create({
    #   from: "+15815006464",
    #   to: "+13024762673",
    #   body: 'Hello there! This is a test'
    # })

    # first_time = Time.now
    # second_time = (first_time + 10.seconds)

    # p second_time

    # p "dcdc"
    # p Time.now
    # p "lolololololo"
    # p  Time.at(Time.now)
    # p "gggg"
    # message = "Bonjour Aymar"
    # p  current_user.profile.tel_contact
    # phone = "+22966181285"
    # phone2 = "+13024762673"
  
    # NexmoTextMessenger.new(message, phone).call
    # NexmoTextMessenger.new(message, phone2).call
 

    # NotifyJobMailer.notify_me(current_user).deliver_later!(wait: 10.seconds)

    
    # message = "final sms test ... yo Aymar"
    # phone = 3024762673

    
    # NexmoTextMessenger.new(message,phone).call
    # client.sms.send(
    #   from: "5163206068",
    #   to: "4182625857",
    #   text: 'Hello Test For SMS On NatureTropicale... Hi Aymar ça va ?'
    # )

    # NotifyStartingJob.set(wait: Date.today.to_formatted_s.to_i.seconds).perform_later(current_user)
    # p Date.today.to_formatted_s.to_i.seconds
    # p Time.now.to_formatted_s
    # p Time.now.to_formatted_s(:time)
  end

  def welcome_to_naturetropicale; end

  def remuneration;end
end
