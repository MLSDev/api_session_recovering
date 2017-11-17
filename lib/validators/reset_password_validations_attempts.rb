class ApiSessionRecovering::ResetPasswordValidationsAttempts < ::ActiveModel::Validator
  attr_reader :remote_ip, :email

  def validate restore_password_validation
    @remote_ip = restore_password_validation

    @email = restore_password_validation

    validate_attempts
  end

  private

  def validate_attempts
    #
    # dont validate if no `remote_ip` entered
    #
    unless Rails.env.test?
      return unless remote_ip.present?
    end

    #
    # dont allow to create so much `reset_password_validation`s models per day
    #
    return if password_reset_validations_amount_today < allowed_password_reset_validations_per_day_count

    restore_password_validation.errors.add :base, 'too many reset password validations attempts today'
  end

  def allowed_password_reset_validations_per_day_count
    ApiSessionRecovering.configuration.allowed_password_reset_validations_per_day_count ||
      ApiSessionRecovering::Preference.first_or_create!.allowed_password_reset_validations_per_day_count
  end

  def password_reset_validations_amount_today
    @password_reset_validations_amount_today ||= ApiSessionRecovering::ResetPasswordValidation.
      today_by_remote_ip_and_email(remote_ip, email).
      count
  end
end
