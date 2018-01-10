module ApiSessionRecovering
  class Configuration
    include ActiveSupport::Configurable

    #
    # => Controller that should be inherited by engine ApplicationController, default is 'ActionController::Base'
    #
    config_accessor(:controller_to_inherit_from) { 'ActionController::Base' }

    #
    # => Layout that should be used for mailers
    #
    config_accessor(:mailer_layout) { nil }

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

    #
    # => Restore password method (:email, :sms)
    #
    config_accessor(:restore_password_methods) { [:email] }

    #
    # => Restore password phone for twilio sms
    #
    config_accessor(:phone_from) { '+380555555555' }

    #
    # => Name of column with user phone number
    #
    config_accessor(:name_phone_column) { :phone }
  end
end
