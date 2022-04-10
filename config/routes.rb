Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'
  
  namespace :admin do 
    get '/dashboard', to: 'dashboard#index'
    resources :users
  end

  namespace :customer do 
    get '/dashboard', to: 'dashboard#index'
  end
end
