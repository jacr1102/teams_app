Rails.application.routes.draw do
  resources :roles
  resources :logs
  resources :teams
  resources :accounts
  resources :profiles
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
