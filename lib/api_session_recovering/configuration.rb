module ApiSessionRecovering
  class Configuration
    include ActiveSupport::Configurable

    #
    # => Table name of User model, default is `users`
    #
    config_accessor(:users_table_name) { 'users' }

    #
    # => Count that shows how many password restore attempts do we allow (per day)
    # => There will be used value from ApiSessionRecovering::Preference if here was specified no value
    #
    config_accessor(:allowed_password_restore_attempts_per_day_count) { nil }

    #
    # => Restore Password Token will expire in `8` hours by default. Change it if U need some other value.
    #
    config_accessor(:hours_for_restore_password_token_to_be_expired) { 8 }

    #
    # => Restore password validation attempts per day
    #
    config_accessor(:allowed_password_reset_validations_per_day_count) { nil }
  end
end
