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
  get 'seatPlan/:id', to: 'tickets#seatPlan', as: 'seat_plan'
  post 'payment', to: 'tickets#payment', as: 'payment'
  get 'confirm_payment', to: 'tickets#confirm_payment'
end
