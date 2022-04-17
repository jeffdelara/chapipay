Rails.application.routes.draw do

  devise_for :users
  root 'pages#index'
  
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
