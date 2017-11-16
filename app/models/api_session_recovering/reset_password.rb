class ApiSessionRecovering::ResetPassword < ApiSessionRecovering::ApplicationRecord
  belongs_to :user, optional: true

  validates :token, presence: true

  #
  # Reset Password validations attempts
  #
  has_many :reset_password_validations, primary_key: :token, foreign_key: :token

  validates_with ApiSessionRecovering::ResetPasswordAttemptsValidations
end
