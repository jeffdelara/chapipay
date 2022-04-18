Rails.application.routes.draw do

  root 'store/store#index'
  devise_for :users
  
  resources :cart, controller: 'store/cart', except: [:index]
  get '/cart', to: 'store/cart#show'
  resources :checkout, controller: 'store/checkout'
  
  resources :store, controller: 'store/store'
  
  namespace :admin do 
    get '/', to: 'dashboard#index'
    get '/dashboard', to: 'dashboard#index'
    get 'addresses', to: 'addresses#index'
    resources :categories
    resources :products
    resources :customers do
      resources :addresses, except: :index 
    end
    
  end

  namespace :customer do 
    get '/', to: 'dashboard#index'
    get '/dashboard', to: 'dashboard#index'
  end

end
