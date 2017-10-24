class ApiSessionRecovering::ResetPasswordAttempt < ApiSessionRecovering::ApplicationRecord
  scope :today_by_remote_ip_and_email, -> (remote_ip, email) do
    where('created_at > ?', Time.now.utc.beginning_of_day).
      where(remote_ip: remote_ip).
      where.not(remote_ip: nil).
      where('email = LOWER(?)', email)
  end
end
