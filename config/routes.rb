Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  post '/login', to: 'authentication#login'
  resources :doctors
  resources :receptionists
  resources :welcomes
  resources :nurses
  
  post 'nurses/:id/restore', to: 'nurses#restore', as: 'restore_nurse'
  post 'receptionists/:id/restore', to: 'receptionists#restore', as: 'restore_receptionist'
  post 'doctors/:id/restore', to: 'doctors#restore', as: 'restore_doctor'
end
