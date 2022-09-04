class TestMailerJob < ApplicationJob
  queue_as :default

  def perform(user)
    TestMailer.test(user).deliver
  end
end