class ApiSessionRecovering::SessionRecovering::RestorePasswordsController < ApiSessionRecovering::BaseController
  def show
    super

    head :no_content
  end

  def create
    super

    head :no_content
  end

  private

  def resource
    @resource ||= ApiSessionRecovering::RestorePassword.find_by_token_and_email! params[:token], params[:email]
  end

  def build_resource
    @resource = ApiSessionRecovering::RestorePasswordService.new request, resource_params
  end

  def resource_params
    params.require(:restore_password).permit :frontend_path, :email, :phone
  end
end
