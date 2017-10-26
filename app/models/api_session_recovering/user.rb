class ApiSessionRecovering::User < ApiSessionRecovering::ApplicationRecord
  self.table_name = ApiSessionRecovering.configuration.users_table_name

  has_secure_password

  has_many :restore_passwords

  has_many :restore_password_attempts, foreign_key: :email
end
