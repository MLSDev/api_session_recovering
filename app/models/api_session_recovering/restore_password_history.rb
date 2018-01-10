class ApiSessionRecovering::RestorePasswordHistory < ApiSessionRecovering::ApplicationRecord
  belongs_to :user
end
