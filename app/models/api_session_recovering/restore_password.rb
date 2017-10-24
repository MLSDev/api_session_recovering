class ApiSessionRecovering::RestorePassword < ApiSessionRecovering::ApplicationRecord
  has_secure_token

  belongs_to :user

  before_create :setup_expire_at

  validates_with ApiSessionRecovering::RestorePasswordAttemptsValidations

  private

  def setup_expire_at
    self.expire_at = 1.day.from_now.utc
  end
end
