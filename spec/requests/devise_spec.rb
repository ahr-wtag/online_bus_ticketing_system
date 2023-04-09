require 'rails_helper'

RSpec.describe 'UsersAuthentication', type: :request do
  describe 'GET /users/sign_up' do
    it 'should render the new sign up form' do
      get '/users/sign_up'
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /users' do
    let(:valid_params) { { user: attributes_for(:user) } }
    it 'creates a new user' do
      expect do
        post '/users', params: valid_params
      end.to change(User, :count).by(1)
      expect(response).to have_http_status(:see_other)
    end
  end

  describe 'GET /users/sign_in' do
    let(:valid_params) { { user: attributes_for(:user) } }
    it 'should render the new sign in form' do
      get '/users/sign_in'
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /users/sign_in' do
    let!(:users) { create(:user) }
    it 'should render the new sign up form' do
      post '/users/sign_in', params: { user: { email: users.email, password: users.password } }
      expect(controller.current_user).to eq(users)
      expect(response).to have_http_status(:see_other)
    end
  end

  describe 'PUT /users/edit' do
    let(:users) { create :user }
    before(:each) do
      sign_in(users)
    end
    let(:valid_params) { { user: { first_name: 'NewFirstName', password: users.password } } }

    it 'should render the edit users form' do
      get '/users/edit'
      expect(response).to render_template(:edit)
    end

    it 'updates the users' do
      # binding.pry
      put user_registration_path, params: valid_params
      users.reload
      expect(users.first_name).to eq('NewFirstName')
    end
  end

  describe 'DELETE /users/sign_out' do
    it 'should log out' do
      delete '/users/sign_out'
      expect(controller.current_user).to eq(nil)
      expect(response).to have_http_status(:see_other)
    end
  end
end
