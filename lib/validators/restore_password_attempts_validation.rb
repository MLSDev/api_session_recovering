class ApiSessionRecovering::RestorePasswordAttemptsValidations < ::ActiveModel::Validator
  attr_reader :restore_password

  def validate restore_password
    @restore_password = restore_password

    validate_restore_password_attempts_count
  end

  private

  def validate_restore_password_attempts_count
    #
    # dont validate if no `remote_ip` entered
    #
    unless Rails.env.test?
      return unless restore_password.remote_ip.present?
    end

    #
    # dont allow to create so much `restore_passwords` models per day
    #
    return if password_resets_amount_today < allowed_password_reset_per_day_count

    restore_password.errors.add :base, 'too many restore password attempts today'
  end

  def allowed_password_reset_per_day_count
    ApiSessionRecovering::Preference.first_or_create!.allowed_password_reset_per_day_count
  end

  def password_resets_amount_today
    @password_resets_amount_today ||= ApiSessionRecovering::RestorePasswordAttempt.
      today_by_remote_ip_and_email(restore_password.remote_ip, restore_password.email).
      count
  end
end
