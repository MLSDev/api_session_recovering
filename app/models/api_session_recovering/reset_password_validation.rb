class ApiSessionRecovering::ResetPasswordValidation < ApiSessionRecovering::ApplicationRecord
  validates :token, presence: true

  validates :email, presence: true

  validates_with ApiSessionRecovering::ResetPasswordValidationsAttempts

  scope :today_by_remote_ip_and_email, -> (remote_ip, email) do
    where('created_at > ?', Time.zone.now.utc.beginning_of_day).
      where(remote_ip: remote_ip).
      where.not(remote_ip: nil).
      where('email = LOWER(?)', email)
  end
end
