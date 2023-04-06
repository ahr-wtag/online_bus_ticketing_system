require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /user' do
    let(:valid_params) { { user: attributes_for(:user) } }

    let(:invalid_params) do
      {
        user: {
          first_name: 'Redwan',
          last_name: 'Ahmed',
          email: 'wrongemail.com',
          user_name: 'redwan',
          password: 'password',
          phone: '01965555555'
        }
      }
    end

    it 'should render the new user form' do
      get '/users/new'
      expect(response).to render_template(:new)
    end

    context 'when the request is valid' do
      it 'creates a new user' do
        expect do
          post '/users', params: valid_params
        end.to change(User, :count).by(1)
      end
    end

    context 'when the request is invalid' do
      it 'does not create a new user' do
        expect do
          post '/users', params: invalid_params
        end.to_not change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /users' do
    let!(:users) { create(:user) }
    let(:valid_params) { { user: { first_name: 'NewFirstName' } } }

    it 'should render the edit users form' do
      get "/users/#{users.id}/edit"
      expect(response).to render_template(:edit)
    end

    it 'updates the users' do
      patch "/users/#{users.id}", params: valid_params
      users.reload
      expect(users.first_name).to eq('NewFirstName')
    end

    it 'returns a success response' do
      put "/users/#{users.id}", params: valid_params
      expect(response).to have_http_status(:see_other)
    end
  end

  describe 'POST /sign_in' do
    let!(:users) { create(:user) }
    let(:valid_params) {  { email: users.email, password: users.password } }
    it 'should render the login form' do
      get '/sign_in'
      expect(response).to render_template('sessions/new')
    end

    it 'should logged In user' do
      post '/sign_in', params: valid_params
      expect(session[:user_id]).to eq(users.id)
      expect(response).to have_http_status(:see_other)
    end
  end

  describe 'DELETE /logout' do
    it 'should log out' do
      delete '/logout'
      expect(session[:user_id]).to eq(nil)
      expect(response).to have_http_status(:see_other)
    end
  end
end
