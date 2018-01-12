class ApiSessionRecovering::TwilioService
  require 'twilio-ruby'

  attr_accessor :phone_to, :phone_from, :text

  def initialize restore_password
    @restore_password = restore_password

    @phone_to = restore_password.user.send(ApiSessionRecovering.configuration.name_phone_column)

    @phone_from = ApiSessionRecovering.configuration.phone_from
  end

  def send_sms
    twilio_client.api.account.messages.create(from: phone_from, to: phone_to, body: restore_password_text)
  end

  private

  def restore_password_text
    @restore_password_text ||= "To restore password enter your verification code #{@restore_password.token}"
  end

  def twilio_client
    @twilio_client ||= ::Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_TOKEN']
  end

  def user
    @user ||= User.find_by(phone: phone_to)
  end
end
