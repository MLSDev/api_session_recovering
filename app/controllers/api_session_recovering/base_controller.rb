class ApiSessionRecovering::BaseController < ApiSessionRecovering::ApplicationController
  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  attr_reader :build_resource, :resource

  helper_method :resource, :collection

  rescue_from ActionController::ParameterMissing do |exception|
    @exception = exception

    render :exception, status: :unprocessable_entity
  end

  rescue_from ActiveRecord::RecordInvalid, ActiveModel::StrictValidationFailed do
    render :errors, status: :unprocessable_entity
  end

  rescue_from ActiveRecord::RecordNotFound do
    head :not_found
  end

  def create
    build_resource

    resource.save!
  end
end
