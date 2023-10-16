class SMSService
  def initialize(municipe)
    @municipe = municipe
  end

  def enviar_sms(message)
    client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    client.messages.create(
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: @municipe.telefone,
      body: message
    )
  end
end