ApiSessionRecovering::Engine.routes.draw do
  namespace :session do
    resource :restore_password, only: :create

    resource :reset_password,   only: :create

    namespace :recovering do
      resource :validate
    end
  end
end
