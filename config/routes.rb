Rails.application.routes.draw do

  get 'posts/index'

  get 'posts/show'

  get 'posts/create'

  get 'posts/destroy'

  get 'posts/edit'

  get 'posts/update'

  resources :campaigns
  root to: 'welcome#index'
end
