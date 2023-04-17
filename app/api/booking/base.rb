module Booking
  class Base < Grape::API
    version 'v1', using: :path
    format :json
    prefix :api

    helpers do
      def authenticate!
        error!('Unauthorized', 401) unless authenticated?
      end

      def authenticated?
        token = headers['Authorization'].split(' ').last
        email = headers['Email'].split(' ').last
        decoded_token = JWT.decode(token, ENV['SECRATE_KEY'], true, { algorithm: 'HS256' })

        @validate_email = email if decoded_token[0]['data'] === email
        true
      rescue JWT::DecodeError, NoMethodError => e
        false
      end

      def current_user
        User.where(email: @validate_email)[0]
      end

      def admin?
        current_user.admin?
      end
    end
    mount Booking::V1::Routes
    mount Booking::V1::Buses
    mount Booking::V1::Trips
    mount Booking::V1::Auth
    mount Booking::V1::Booking
  end
end
