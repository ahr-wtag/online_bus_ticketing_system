Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :routes
  resources :buses
  resources :trips
  # Defines the root path route ("/")
  root "users#new"

  #Authentication
 
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create', as: 'log_in'
  delete 'logout', to: 'sessions#destroy', as: 'log_out'
end
