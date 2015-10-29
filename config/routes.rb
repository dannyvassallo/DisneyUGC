Rails.application.routes.draw do
  # BEGIN CUSTOM DEVISE ROUTES #
  devise_for :users, :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" } 
  devise_scope :user do
    get "login", to: "devise/sessions#new"
    get "logout", to: "devise/sessions#destroy"
    get "register", to: "devise/registrations#new"
  end
  # END CUSTOM DEVISE ROUTES #
  resources :campaigns, except: [:show]

  resources :campaigns, only: [:show] do
    resources :posts, only: [:create, :destroy]
  end

  resources :posts, only: [:show]

  namespace :api do
    namespace :v1 do
      resources :campaigns do
        resources :posts, only: [:show]
      end
    end
  end

  root to: 'welcome#index'
end
