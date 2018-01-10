class ApiSessionRecovering::SessionRecovering::ResetPasswordsController < ApiSessionRecovering::BaseController
  def create
    super

    head :no_content
  end

  private

  def resource
    @resource
  end

  def build_resource
    @resource = ApiSessionRecovering::ResetPasswordService.new request, resource_params
  end

  def resource_params
    params.require(:reset_password).permit :token, :password, :password_confirmation, :email
  end
end
