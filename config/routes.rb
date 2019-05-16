ApiSessionRecovering::Engine.routes.draw do
  namespace :session_recovering do
    resource :restore_password, only: :create

    resource :token_validation, only: :create

    resource :reset_password,   only: :create
  end
end
