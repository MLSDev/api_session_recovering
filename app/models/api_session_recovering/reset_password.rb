class ApiSessionRecovering::ResetPassword < ApiSessionRecovering::ApplicationRecord
  belongs_to :user, optional: true

  validates :token, presence: true

  validates_with ApiSessionRecovering::ResetPasswordAttemptsValidations
end
