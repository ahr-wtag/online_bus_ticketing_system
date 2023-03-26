Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :routes
  resources :buses
  resources :trips
  # Defines the root path route ("/")
  root 'buses#new'

  #Booking and Ticketing Routes
  get 'booking', to: 'tickets#index'
  
end
