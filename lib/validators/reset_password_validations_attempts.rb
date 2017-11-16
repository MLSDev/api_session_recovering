class ApiSessionRecovering::ResetPasswordValidationsAttempts < ::ActiveModel::Validator
  attr_reader :remote_ip, :email

  def validate params
    @remote_ip = params[:remote_ip]

    @email = params[:email]

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

    restore_password.errors.add :base, 'too many reset password validations attempts today'
  end

  def allowed_password_reset_validations_per_day_count
    ApiSessionRecovering.configuration.allowed_password_reset_validations_per_day_count ||
      ApiSessionRecovering::Preference.first_or_create!.allowed_password_reset_validations_per_day_count
  end

  def password_reset_validations_amount_today
    @password_reset_validations_amount_today ||= ApiSessionRecovering::ResetPasswordValidation.
      today_by_remote_ip_and_email(restore_password.remote_ip, restore_password.email).
      count
  end
end
