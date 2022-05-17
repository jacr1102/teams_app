Rails.application.routes.draw do
  get 'app/index'
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :logs
      resources :teams
      resources :accounts
      resources :users

    end
  end

  devise_for :users,
    path: '',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout'
    },
    controllers: {
      sessions: 'api/v1/sessions'
    }

  root to: "app#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
