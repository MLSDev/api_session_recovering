ApiSessionRecovering::Engine.routes.draw do
  namespace :session_recovering do
    resource :restore_password, only: :create

    namespace :reset_passwords do
      resource :validate, only: :create
    end

    resource :reset_password,   only: :create
  end
end
