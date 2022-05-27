Rails.application.routes.draw do
  get 'app/index'
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :teams
      resources :accounts do
        get 'accounts_select', on: :collection
      end
      resources :users do
        get 'users_select', on: :collection
      end

      match 'user_logs', to: 'user_logs#index', via: [:get, :post], as: :search_logs
      get 'roles/roles_select'
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
