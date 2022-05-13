Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :logs
      resources :teams
      resources :accounts
      resources :users

      #devise_for :users , path: 'auths'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
