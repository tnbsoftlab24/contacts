class NexmoTextMessenger
  attr_reader :message, :phone

  def initialize(message,phone)
    @message = message
    @phone = phone
  end

  def call

    # client = Vonage::Client.new(
    #   api_key: ENV['NEXMO_API_KEY'],
    #   api_secret: ENV['NEXMO_API_SECRET_KEY']
    # )

    # client.sms.send(
    #   from:"15163206068",
    #   to: phone,
    #   text: message
    # )

    # Telnyx.api_key = "KEY017BC8153C0924D019FE5917C6908E05_o7CUPyJgGnWLkM5xOvDMBu"
    # from_number = "+15802001664"
    # to_number = "#{phone}"

    # response = Telnyx::Message.create(
    #     from: from_number,
    #     to: to_number,
    #     text: message+".Plus de details sur https://app.naturetropicale.ca"
    # )
  end
end