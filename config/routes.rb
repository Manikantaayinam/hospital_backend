Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  post '/login', to: 'authentication#login'
  resources :doctors
  resources :receptionists

end
