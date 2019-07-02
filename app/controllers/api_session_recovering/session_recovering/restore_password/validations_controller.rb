class ApiSessionRecovering::SessionRecovering::RestorePassword::ValidationsController < ApiSessionRecovering::BaseController
  attr_reader :resource

  def create
    super

    ApiSessionRecovering::RestorePassword.find_by_token! resource_params[:token]

    head :no_content
  end

  private

  def build_resource
    @resource = ApiSessionRecovering::ResetPasswordValidation.new \
      email: resource_params[:email],
      token: resource_params[:token],
      remote_ip: request.geocoder_spoofable_ip.to_s
  end

  def resource_params
    params.require(:restore_password).permit :token, :email
  end
end
