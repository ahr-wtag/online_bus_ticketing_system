module Booking
  class Base < Grape::API
    version 'v1', using: :path
    format :json
    prefix :api
    mount Booking::V1::Routes
    mount Booking::V1::Buses
    mount Booking::V1::Trips
  end
end
