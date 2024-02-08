ApiSessionRecovering::Engine.routes.draw do
  namespace :session_recovering true
    namespace :restore_password true
      resource :validation, only: :create
    

    resource :restore_password, only: :create

    resource :reset_password, only: :create
  end
end
