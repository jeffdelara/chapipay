Rails.application.routes.draw do

  root 'store/store#index'
  devise_for :users
  
  resources :cart, controller: 'store/cart', except: [:index]
  get '/cart', to: 'store/cart#show'

  get '/checkout', to: 'store/checkout#show'
  resources :checkout, controller: 'store/checkout', except: [:index]
  resources :payments, controller: 'store/payments'
  
  resources :store, controller: 'store/store'
  
  namespace :admin do 
    get '/', to: 'dashboard#index'
    get '/dashboard', to: 'dashboard#index'
    get 'addresses', to: 'addresses#index'
    get 'orders', to: 'orders#index'
    resources :categories
    resources :products
    # resources :orders do
    #   resources :order_lines
    # end
    resources :customers do
      resources :addresses, except: :index
      resources :orders, except: :index
    end
    
  end

  namespace :customer do 
    get '/', to: 'dashboard#index'
    get '/dashboard', to: 'dashboard#index'
  end

end
