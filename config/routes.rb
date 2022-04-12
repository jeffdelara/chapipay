Rails.application.routes.draw do

  devise_for :users
  root 'pages#index'
  
  namespace :admin do 
    get '/', to: 'dashboard#index'
    get '/dashboard', to: 'dashboard#index'
    resources :categories
    resources :users
    resources :products
  end

  namespace :customer do 
    get '/', to: 'dashboard#index'
    get '/dashboard', to: 'dashboard#index'
  end

end
