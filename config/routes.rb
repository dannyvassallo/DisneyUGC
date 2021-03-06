Rails.application.routes.draw do
  root to: 'welcome#index'
  # BEGIN CUSTOM DEVISE ROUTES #
  devise_for :users, :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "8626705366" }
  devise_scope :user do
    get "login", to: "devise/sessions#new"
    get "logout", to: "devise/sessions#destroy"
    get "8626705366", to: "devise/registrations#new"
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

  post 'campaigns/download_selected_posts/:campaign_id' => 'campaigns#download_selected_posts', :as => 'download_selected_posts'
  get 'campaigns/content_review/:campaign_id' => 'campaigns#content_review', :as => 'content_review'
  get 'campaigns/practices_review/:campaign_id' => 'campaigns#practices_review', :as => 'practices_review'
  get 'campaigns/practices_review_index' => 'campaigns#practices_review_index', :as => 'practices_review_index'
  get 'campaigns/approved_content/:campaign_id' => 'campaigns#approved_content', :as => 'approved_content'
  post 'campaigns/download_all_posts/:campaign_id' => 'campaigns#download_all_posts', :as => 'download_all_posts'
  post 'campaigns/posts_for_review/:campaign_id' => 'campaigns#posts_for_review', :as => 'posts_for_review'
  post 'campaigns/approve_posts/:campaign_id' => 'campaigns#approve_posts', :as => 'approve_posts'
  post 'campaigns/unmark_for_review/:campaign_id' => 'campaigns#unmark_for_review', :as => 'unmark_for_review'
  get 'limbo' => 'limbo#index'


  resources :campaigns, only: [:index, :create]
  resources :campaigns, path: '', except: [:index, :create] do
    resources :posts, only: [:create, :destroy]
  end

end
