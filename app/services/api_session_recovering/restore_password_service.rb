class ApiSessionRecovering::RestorePasswordService
  include ::ActiveModel::Validations

  attr_reader :email, :remote_ip, :frontend_path

  validates :email, email: true

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
    @user ||= ApiSessionRecovering::User.find_by email: email
  end

  def restore_password
    @restore_password ||= user.restore_passwords.build \
     remote_ip:     remote_ip,
     frontend_path: frontend_path,
     email:         email
  end

  def restore_password_attempt
    @restore_password_attempt ||= ApiSessionRecovering::RestorePasswordAttempt.new remote_ip: remote_ip, email: email
  end

  def user_exists
    return unless email

    errors.add :email, 'email is invalid' unless user
  end
end
