Rails.application.routes.draw do
  mount ApiSessionRecovering::Engine => '/api'
end
