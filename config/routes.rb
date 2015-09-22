Rails.application.routes.draw do

  resources :campaigns
  root to: 'welcome#index'
end
