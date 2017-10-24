ApiSessionRecovering::Engine.routes.draw do
  namespace :session do
    resource :restore_password, only: :create

    resource :reset_password,   only: :create
  end
end
