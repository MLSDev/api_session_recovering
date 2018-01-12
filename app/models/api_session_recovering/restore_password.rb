class ApiSessionRecovering::RestorePassword < ApiSessionRecovering::ApplicationRecord

  belongs_to :user

  validates :email, :frontend_path, presence: true, unless: :phone?

  validates :phone, presence: true, unless: :email?

  before_create :setup_expire_at

  after_commit :send_token, on: :create

  before_create :generate_token

  after_commit :create_restore_password_history, on: :destroy

  validates_with ApiSessionRecovering::RestorePasswordAttemptsValidations

  private

  def setup_expire_at
    self.expire_at = ApiSessionRecovering.configuration.hours_for_restore_password_token_to_be_expired.hours.from_now.utc
  end

  def send_token
    restore_password_methods = ApiSessionRecovering.configuration.restore_password_methods

    ApiSessionRecovering::RestorePasswordMailer.email(self).deliver_later if restore_password_methods.include? :email

    ApiSessionRecovering::TwilioService.new(self).send_sms if restore_password_methods.include? :sms
  end

  def generate_token
    self.token = SecureRandom.random_number(999999)

    generate_token if ApiSessionRecovering::RestorePassword.exists?(token: self.token, user: self.user)
  end

  def create_restore_password_history
    ApiSessionRecovering::RestorePasswordHistory.create! \
      remote_ip: remote_ip,
      token: token,
      email: email,
      expire_at: expire_at,
      recovered_at: Time.zone.now,
      user: user,
      frontend_path: frontend_path
  end

  def restore_password_history_params
    if self.email?
      {
        remote_ip: remote_ip,
        token: token,
        email: email,
        expire_at: expire_at,
        recovered_at: Time.zone.now,
        user: user,
        frontend_path: frontend_path
      }
    elsif self.phone?
      {
        token: token,
        expire_at: expire_at,
        recovered_at: Time.zone.now,
        user: user,
        phone: phone
      }
    end
  end
end
