Rails.application.routes.draw do
  root to: 'welcome#index'
  # BEGIN CUSTOM DEVISE ROUTES #
  devise_for :users, :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" } 
  devise_scope :user do
    get "login", to: "devise/sessions#new"
    get "logout", to: "devise/sessions#destroy"
    get "register", to: "devise/registrations#new"
  end  
  # END CUSTOM DEVISE ROUTES #
  scope "/admin" do
    resources :users, except: [:show]
  end

  resources :posts, only: [:show]
  resources :admin, only: [:index]

  get 'get_posts' => 'posts#get_posts', :as => :get_posts
  get 'slideshow' => 'posts#slideshow', :as => :slideshow
  get 'random_winner' => 'posts#random_winner', :as => :random_winner

  namespace :api do
    namespace :v1 do
      resources :campaigns do
        resources :posts, only: [:show]
      end
    end
  end
  
  resources :campaigns, only: [:index, :create]
  resources :campaigns, path: '', except: [:index, :create] do
    resources :posts, only: [:create, :destroy]    
  end

end
