# These configuration options can be used to customise the behaviour of ApiSessionRecovering
ApiSessionRecovering.configure do |config|
  #
  #
  #
  config.users_table_name = 'users'

  #
  # => Add this if You want to use hardcoded amount of allowed password restore attempts (per day)
  #
  # config.allowed_password_restore_attempts_per_day_count = 20
end
