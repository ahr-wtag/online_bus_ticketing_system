require 'rails_helper'

RSpec.describe 'Trips', type: :request do

  let(:user) {create :user}
  before(:each) do 
    sign_in(user)
  end
  

  describe 'GET /trips' do
    it 'returns a success response' do
      get '/trips'
      expect(response).to be_successful
    end
  end

  describe 'POST /trips' do
    let(:valid_params) { { trip: attributes_for(:trip) } }
    it 'should render the new trip form' do
      get '/trips/new'
      expect(response).to render_template(:new)
    end
    it 'creates a new trip' do
      expect do
        post '/trips', params: valid_params
      end.to change(Trip, :count).by(1)
    end

    it 'returns a success response' do
      post '/trips', params: valid_params
      expect(response).to have_http_status(:created)
    end
  end

  describe 'PUT /trips' do
    let!(:trip) { create(:trip) }
    let(:valid_params) { { trip: { ticket_price: 900 } } }

    it 'should render the edit trip form' do
      get "/trips/#{trip.id}/edit"
      expect(response).to render_template(:edit)
    end

    it 'updates the trip' do
      patch "/trips/#{trip.id}", params: valid_params
      trip.reload
      expect(trip.ticket_price).to eq(900)
    end

    it 'returns a success response' do
      put "/trips/#{trip.id}", params: valid_params
      expect(response).to have_http_status(:see_other)
    end
  end

  describe 'DELETE /trips/:id' do
    let!(:trip) { create(:trip) }

    it 'destroys the requested trip' do
      expect do
        delete "/trips/#{trip.id}"
      end.to change(Trip, :count).by(-1)
    end

    it 'returns a success response' do
      delete "/trips/#{trip.id}"
      expect(response).to have_http_status(:see_other)
    end
  end
end
