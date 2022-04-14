Rails.application.routes.draw do

  root 'store/store#index'
  devise_for :users
  
  resources :cart, controller: 'store/cart', except: [:index]
  get '/cart', to: 'store/cart#show'
  resources :checkout, controller: 'store/checkout'
  
  namespace :store do
    get '/', to: 'store#index'
  end
  
  namespace :admin do 
    get '/', to: 'dashboard#index'
    get '/dashboard', to: 'dashboard#index'
    
    resources :categories
    resources :products
    resources :customers
    
  end

  namespace :customer do 
    get '/', to: 'dashboard#index'
    get '/dashboard', to: 'dashboard#index'
  end

end
