module Booking
  module V1
    class Auth < Grape::API
      format :json
      resources :users do
        desc 'Create a User'
        params do
          requires :first_name, type: String
          requires :last_name, type: String
          requires :email, type: String
          requires :user_name, type: String
          requires :phone, type: String
          requires :password, type: String
        end
        post :sign_up do
          @user = User.new(params)
          return { 'error': @user.errors } unless @user.save

          payload = { data: @user.email }
          @token = JWT.encode payload, ENV['SECRATE_KEY'], 'HS256'
          return @token
        end

        desc 'Login a User'
        params do
          requires :email, type: String
          requires :password, type: String
        end
        post :sign_in do
          @user = User.find_for_database_authentication(email: params[:email])

          if @user && @user.valid_password?(params[:password])

            payload = { data: @user.email }
            @token = JWT.encode payload, ENV['SECRATE_KEY'], 'HS256'
            return @token

          else
            error!('Invalid email or password', 401)
          end
        end

        desc 'Update User'
        params do
          requires :current_password, type: String
        end
        put :update do
          authenticate!
          @user = current_user
          if @user && @user.valid_password?(params[:current_password])
            params.delete(:current_password)
            @user = current_user.update(params)
          else
            error!('old password is not matched', 401)
          end
        end

        desc 'Delete User'

        delete :delete do
          authenticate!
          @user = current_user
          @user.destroy
        end
      end
    end
  end
end
