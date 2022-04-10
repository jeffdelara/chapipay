Rails.application.routes.draw do
  namespace :customer do
    get 'dashboard/index'
  end
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
