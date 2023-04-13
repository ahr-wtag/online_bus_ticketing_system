Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :routes
  resources :buses
  resources :trips

  mount Booking::Base => '/'
  # Defines the root path route ("/")
  root 'tickets#index'
  get 'profile', to: 'users#show', as: 'profile'

  # Booking and Ticketing Routes
  get 'booking', to: 'tickets#index', as: 'booking'
  get 'seat_plan/:id', to: 'tickets#seat_plan', as: 'seat_plan'
  post 'payment', to: 'tickets#payment', as: 'payment'
  get 'process_payment', to: 'tickets#process_payment'
  post 'confirm_payment', to: 'tickets#confirm_payment'
end
