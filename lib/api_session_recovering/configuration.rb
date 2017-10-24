class ApiSessionRecovering::Configuration
  include ActiveSupport::Configurable

  #
  # Table name of User model, default is `users`
  #
  config_accessor(:users_table_name) { 'users' }

  config_accessor(:allowed_password_restore_attempts_per_day_count) { nil }
end
