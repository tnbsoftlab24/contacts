class NotifyStartingJob < ApplicationJob
  queue_as :default

  def perform(profiles, job)
    # Do something later
    @profiles = profiles
    @job = job

    # if @job.proposal.blank?
    #   @profiles.each do |profile| 
    #     message = "Bonjour #{ profile.prenom} ! Un nouveau job est disponible dans la categorie #{@job.poste}"
    #     NexmoTextMessenger.new(message, profile.num_tel).call
    #   end
    # end
  end
end
