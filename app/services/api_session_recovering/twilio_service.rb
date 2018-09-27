class ApiSessionRecovering::TwilioService
  require 'twilio-ruby'

  attr_accessor :phone_to, :phone_from

  def initialize restore_password
    @restore_password = restore_password

    @phone_to         = restore_password.user.send ApiSessionRecovering.configuration.name_of_users_phone_column

    @phone_from       = ApiSessionRecovering.configuration.phone_from
  end

  def send_sms
    twilio_client.api.account.messages.create(from: phone_from, to: phone_to, body: restore_password_text)
  end

  private

  def restore_password_text
    @restore_password_text ||= ApiSessionRecovering.configuration.restore_password_text.to_s.gsub('restore_password_token', @restore_password.token)
  end

  def twilio_client
    @twilio_client ||= ::Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_TOKEN']
  end
end
