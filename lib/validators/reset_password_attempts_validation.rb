class ApiSessionRecovering::ResetPasswordAttemptsValidations < ::ActiveModel::Validator
  attr_reader :reset_password

  def validate reset_password
    @reset_password = reset_password

    validate_reset_password_attempts_count
  end

  private

  def validate_reset_password_attempts_count
    #
    # dont validate if no `remote_ip`
    #
    unless Rails.env.test?
      return unless reset_password.remote_ip.present?
    end

    #
    # dont allow to create so much `reset_passwords` models per day
    #
    return if reset_password_attempts_amount_today < allowed_password_restore_attempts_per_day_count

    reset_password.errors.add :base, I18n.t('api_session_recovering.errors.reset_password.too_many_attempts')
  end

  def allowed_password_restore_attempts_per_day_count
    if ApiSessionRecovering.configuration.allowed_password_restore_attempts_per_day_count
      ApiSessionRecovering.configuration.allowed_password_restore_attempts_per_day_count
    else
      ApiSessionRecovering::Preference.first_or_create!.allowed_password_restore_attempts_per_day_count
    end
  end

  def reset_password_attempts_amount_today
    @reset_password_attempts_amount_today ||= ApiSessionRecovering::ResetPasswordAttempt.
      today_by_remote_ip_and_email(reset_password.remote_ip, reset_password.email).
      count
  end
end
