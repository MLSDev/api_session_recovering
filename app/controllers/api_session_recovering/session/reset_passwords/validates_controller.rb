class ApiSessionRecovering::Session::ResetPasswords::ValidatesController < ApiSessionRecovering::BaseController
  attr_reader :resource

  def create
    super

    ApiSessionRecovering::ResetPassword.find_by_token! params[:token]

    head :no_content
  end

  private

  def build_resource
    @resource = ApiSessionRecovering::ResetPasswordValidation.new \
      email: params[:email],
      token: params[:token],
      remote_ip: request.geocoder_spoofable_ip.to_s
  end
end
