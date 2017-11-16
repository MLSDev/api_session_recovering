class ApiSessionRecovering::ResetPasswordService
  include ActiveModel::Validations

  attr_reader :remote_ip, :token, :password, :password_confirmation, :email

  validate :token_is_valid

  validate :restore_password_is_valid

  validates :password,              presence: true, confirmation: { if: :password_confirmation }

  validates :password_confirmation, presence: true

  validates :token,                 presence: true

  def initialize request, params
    #
    # gem 'geocoder'
    #
    # https://github.com/alexreisner/geocoder/blob/v1.4.4/lib/geocoder/request.rb#L46
    #
    @remote_ip             = request.geocoder_spoofable_ip.to_s if request

    @token                 = params[:token]

    @password              = params[:password]

    @password_confirmation = params[:password_confirmation]

    @email                 = params[:email]
  end

  def save!
    #
    # Save every password reset request.
    # We allow certain amount of reqeusts per day.
    # NOTE: check out validations inside `ApiSessionRecovering::ResetPassword` model
    #
    unless reset_password.save
      @errors = reset_password.errors

      raise ActiveModel::StrictValidationFailed
    end

    #
    # validate `ApiSessionRecovering::ResetPasswordService`
    #
    raise ::ActiveModel::StrictValidationFailed unless valid?

    #
    # log ApiSessionRecovering::`ApiSessionRecovering::ResetPasswordAttempt`
    #
    reset_password_attempt.save!

    #
    # Remove `ApiSessionRecovering::RestorePassword` record
    # that triggers `ApiSessionRecovering::ResetPasswordHistory` creating
    #
    restore_password.destroy!

    unless user.update password: password
      @errors = user.errors

      raise ::ActiveModel::StrictValidationFailed
    end
  end

  def reset_password
    @reset_password ||= ApiSessionRecovering::ResetPassword.new \
      remote_ip:      remote_ip,
      token:          token,
      token_is_valid: restore_password.present?,
      user:           user
  end

  def reset_password_attempt
    @reset_password_attempt ||= ApiSessionRecovering::ResetPasswordAttempt.new remote_ip: remote_ip, email: email
  end

  def restore_password
    @restore_password ||= ApiSessionRecovering::RestorePassword.find_by_token token
  end

  def user
    @user ||= restore_password&.user
  end

  #
  # validations
  #
  def token_is_valid
    errors.add :token, 'is invalid' unless restore_password
  end

  #
  # validations
  #
  def restore_password_is_valid
    return unless restore_password

    return unless restore_password.expire_at

    errors.add :base, 'token was expired' if Time.zone.now.utc > restore_password.expire_at
  end
end

