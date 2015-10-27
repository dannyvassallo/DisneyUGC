Rails.application.routes.draw do

  devise_for :users
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
