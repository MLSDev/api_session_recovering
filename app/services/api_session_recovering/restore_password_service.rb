class ApiSessionRecovering::RestorePasswordService
  include ::ActiveModel::Validations

  attr_reader :email, :remote_ip, :frontend_path

  validates :email, email: true, unless: :phone?

  validate :user_exists

  def initialize request, params
    #
    # gem 'geocoder'
    #
    # https://github.com/alexreisner/geocoder/blob/v1.4.4/lib/geocoder/request.rb#L46
    #
    @remote_ip     = request.geocoder_spoofable_ip.to_s if request

    @frontend_path = params[:frontend_path].presence

    @email         = params[:email].presence

    @phone         = params[:phone].presence
  end

  def save!
    #
    # Log restore password attempt first
    #
    restore_password_attempt.save!

    #
    # validate `ApiSessionRecovering::RestorePasswordService`
    #
    raise ::ActiveModel::StrictValidationFailed unless valid?

    #
    # NOTE: check out `Api::RestorePassword` validations
    #
    unless restore_password.save
      @errors = restore_password.errors

      raise ::ActiveModel::StrictValidationFailed
    end
  end

  def user
    @user ||= ApiSessionRecovering::User.find_by email: email if email?

    @user ||= ApiSessionRecovering::User.find_by phone: phone if phone?
  end

  def restore_password
    @restore_password ||= user.restore_passwords.build restore_password_params
  end

  def restore_password_attempt
    @restore_password_attempt ||= ApiSessionRecovering::RestorePasswordAttempt.new restore_password_attempt_params
  end

  def restore_password_params
    if email?
      {
        remote_ip:     remote_ip,
        frontend_path: frontend_path,
        email:         email
      }
    elsif phone?
      {
        phone:         phone
      }
    end
  end

  def restore_password_attempt_params
    if email?
      {
        remote_ip:     remote_ip,
        email:         email
      }
    elsif phone?
      {
        phone:         phone
      }
    end
  end

  def user_exists
    return unless email

    errors.add :email, 'email is invalid' unless user
  end
end
