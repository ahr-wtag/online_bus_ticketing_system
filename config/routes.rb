Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :routes
  resources :buses
  resources :trips
  # Defines the root path route ("/")
  root 'tickets#index'

  #Booking and Ticketing Routes
  get 'booking', to: 'tickets#index' ,as: 'booking'
  get 'seatPlan/:id', to: 'tickets#seatPlan', as: 'seat_plan'
  post 'payment', to: 'tickets#payment', as: 'payment'
  get 'process_payment', to: 'tickets#process_payment'
  post 'confirm_payment', to: 'tickets#confirm_payment'
end
