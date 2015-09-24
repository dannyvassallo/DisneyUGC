Rails.application.routes.draw do

	resources :campaigns, except: [:show]

	resources :campaigns, only: [:show] do
		resources :posts, only: [:create, :destroy]
	end

	resources :posts, only: [:show]

	root to: 'welcome#index'
end
