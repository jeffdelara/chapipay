Rails.application.routes.draw do

  root 'store/store#index'

  namespace :store do
    get '/', to: 'store#index'
  end
  devise_for :users
  
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
