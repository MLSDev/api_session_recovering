class ApiSessionRecovering::BaseController < ApplicationController
  protect_from_forgery with: :exception, unless: -> { request.format.json? }

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
