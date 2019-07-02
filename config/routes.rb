ApiSessionRecovering::Engine.routes.draw do
  namespace :session_recovering do
    namespace :restore_password do
      resource :validation, only: :create
    end

    resource :restore_password, only: :create

    resource :reset_password, only: :create
  end
end
