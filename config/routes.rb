Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'
  
  namespace :admin do 
    get '/dashboard', to: 'dashboard#index'
    resources :categories
    resources :users
    resources :orders
  end

  namespace :customer do 
    get '/dashboard', to: 'dashboard#index'
  end
end
