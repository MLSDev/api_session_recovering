# These configuration options can be used to customise the behaviour of ApiSessionRecovering
ApiSessionRecovering.configure do |config|
  #
  # => Table name for `User` entity. Change it if U want to use some different one. Default is `users`
  #
  # config.users_table_name = 'users'

  #
  # => Add this if You want to use hardcoded amount of allowed password restore attempts (per day)
  #
  # config.allowed_password_restore_attempts_per_day_count = 20

  #
  # => Restore Password Token will expire in `8` hours by default. Change it if U need some other value.
  #
  # config.hours_for_restore_password_token_to_be_expired = 8
end
