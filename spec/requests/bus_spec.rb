require 'rails_helper'

RSpec.describe 'Buses', type: :request do
  describe 'GET /buses' do
    it 'returns a success response' do
      get '/buses'
      expect(response).to be_successful
    end
  end

  describe 'POST /buses' do
    let(:valid_params) { { bus: attributes_for(:bus) } }
    it 'should render the new bus form' do
      get '/buses/new'
      expect(response).to render_template(:new)
    end
    it 'creates a new bus' do
      expect do
        post '/buses', params: valid_params
      end.to change(Bus, :count).by(1)
    end

    it 'returns a success response' do
      post '/buses', params: valid_params
      expect(response).to have_http_status(:created)
    end
  end

  describe 'PUT /buses' do
    let(:bus) { create(:bus) }
    let(:valid_params) { { bus: { capacity: 25 } } }

    it 'should render the edit bus form' do
      get "/buses/#{bus.id}/edit"
      expect(response).to render_template(:edit)
    end

    it 'updates the bus' do
      put "/buses/#{bus.id}", params: valid_params
      bus.reload
      expect(bus.capacity).to eq(25)
    end

    it 'returns a success response' do
      put "/buses/#{bus.id}", params: valid_params
      expect(response).to have_http_status(:see_other)
    end
  end

  describe 'DELETE /buses/:id' do
    let!(:bus) { create(:bus) }

    it 'destroys the requested bus' do
      expect do
        delete "/buses/#{bus.id}"
      end.to change(Bus, :count).by(-1)
    end

    it 'returns a success response' do
      delete "/buses/#{bus.id}"
      expect(response).to have_http_status(:see_other)
    end
  end
end
