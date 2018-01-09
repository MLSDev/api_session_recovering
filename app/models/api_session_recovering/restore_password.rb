class ApiSessionRecovering::RestorePassword < ApiSessionRecovering::ApplicationRecord
  has_secure_token

  belongs_to :user

  validates :email, :frontend_path, presence: true

  before_create :setup_expire_at

  after_commit :send_email_instructions, on: :create

  after_commit :create_restore_password_history, on: :destroy

  validates_with ApiSessionRecovering::RestorePasswordAttemptsValidations

  private

  def setup_expire_at
    self.expire_at = ApiSessionRecovering.configuration.hours_for_restore_password_token_to_be_expired.hours.from_now.utc
  end

  def send_email_instructions
    RestorePasswordMailer.email(email, token, frontend_path).deliver_later
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
end
