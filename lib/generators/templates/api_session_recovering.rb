# These configuration options can be used to customise the behaviour of ApiSessionRecovering
ApiSessionRecovering.configure do |config|
  #
  # => Controller that should be inherited by engine's ApplicationController, default is 'ActionController::Base'
  #
  # config.controller_to_inherit_from = 'ActionController::Base'

  #
  # => Layout that should be used for mailers
  #
  # config.mailer_layout = 'mailer'

  #
  # => Table name for `User` entity. Change it if U want to use some different one. Default is `users`
  #
  # config.users_table_name = 'users'

  #
  # => Restore Password Token will expire in `8` hours by default. Change it if You need some other value.
  #
  # config.hours_for_restore_password_token_to_be_expired = 8

  #
  # => Add this if You want to use hardcoded amount of allowed password restore attempts (per day)
  #
  # config.allowed_password_restore_attempts_per_day_count = 20

  #
  # => Add this if You want to use hardcoded amount of allowed password restore validation attempts (per day)
  #
  # config.hours_for_restore_password_token_to_be_expired = 8

  #
  # => Restore password method (:email, :sms)
  #
  # config.restore_password_methods = [:email]

  #
  # => Phone for sending sms (For recovering password via sms uncomment line below)
  #
  # config.phone_from { '+1**********' }

  # config.allowed_password_reset_validations_per_day_count = 20

end
