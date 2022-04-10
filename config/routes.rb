Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'
  
  namespace :admin do 
    get '/dashboard', to: 'dashboard#index'
    resources :users
  end
end
