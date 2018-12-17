class ApiSessionRecovering::ResetPasswordAttemptsValidations < ::ActiveModel::Validator
  attr_reader :reset_password

  def validate reset_password
    @reset_password = reset_password

    validate_reset_password_attempts_via_email_count

    validate_reset_password_attempts_via_phone_count
  end

  private

  def validate_reset_password_attempts_via_email_count
    #
    # dont validate if no `remote_ip`
    #
    unless Rails.env.test?
      return unless reset_password.remote_ip.present?
    end

    return unless reset_password.email.present?

    #
    # dont allow to create so much `reset_passwords` models per day
    #
    return unless reset_password_attempts_amount_today_via_phone

    return if reset_password_attempts_amount_today_via_phone < allowed_password_restore_attempts_per_day_count

    reset_password.errors.add :base, I18n.t('api_session_recovering.errors.reset_password.too_many_attempts')
  end

  def validate_reset_password_attempts_via_phone_count
    #
    # dont validate if no `remote_ip`
    #
    unless Rails.env.test?
      return unless reset_password.remote_ip.present?
    end

    return unless reset_password.phone.present?

    #
    # dont allow to create so much `reset_passwords` models per day
    #
    return unless reset_password_attempts_amount_today_via_email

    return if reset_password_attempts_amount_today_via_email < allowed_password_restore_attempts_per_day_count

    reset_password.errors.add :base, I18n.t('api_session_recovering.errors.reset_password.too_many_attempts')
  end

  def allowed_password_restore_attempts_per_day_count
    if ApiSessionRecovering.configuration.allowed_password_restore_attempts_per_day_count
      ApiSessionRecovering.configuration.allowed_password_restore_attempts_per_day_count
    else
      ApiSessionRecovering::Preference.first_or_create!.allowed_password_restore_attempts_per_day_count
    end
  end

  def reset_password_attempts_amount_today_via_email
    return unless reset_password.email.present?

    @reset_password_attempts_amount_today_via_email ||= ApiSessionRecovering::ResetPasswordAttempt.
      today_by_remote_ip_and_email(reset_password.remote_ip, reset_password.email).
      count
  end

  def reset_password_attempts_amount_today_via_phone
    return unless reset_password.phone.present?

    @reset_password_attempts_amount_today_via_phone ||= ApiSessionRecovering::ResetPasswordAttempt.
      today_by_remote_ip_and_phone(reset_password.remote_ip, reset_password.phone).
      count
  end
end
