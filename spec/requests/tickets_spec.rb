require 'rails_helper'

RSpec.describe 'Tickets', type: :request do
  let(:user) { create :user }
  let!(:trip) { create :trip }
  let!(:seat) { create(:seat, bus: trip.bus) }

  before(:each) do
    user.role = :admin
    sign_in(user)
  end
  describe 'GET /booking' do
    it 'returns a success response' do
      get '/booking'
      expect(response).to be_successful
    end
    it 'expect rendering index page' do
      get '/booking'
      expect(response).to render_template('tickets/index')
    end
  end

  describe 'GET /seat_plan/:id' do
    it 'expect rendering index page' do
      get "/seat_plan/#{trip.id}"
      expect(response).to render_template('tickets/seat_plan')
    end

    it 'expect returned bus is assiciated with trip' do
      get "/seat_plan/#{trip.id}"
      expect(assigns(:bus)).to eq(trip.bus)
    end
  end

  describe 'POST /payment' do
    let(:valid_params) { { trip_id: trip.id, "#{seat.id}": seat.id } }
    it 'should update session' do
      post '/payment', params: valid_params
      expect(session[:seats].last).to eq(seat.id.to_s)
      expect(session[:trip]).to eq(trip.id.to_s)
      expect(response).to have_http_status(:see_other)
    end
    it 'should redirect session' do
      post '/payment', params: valid_params
      expect(response).to redirect_to(:process_payment)
    end
  end

  describe 'GET /process_payment' do
    let(:valid_params) { { trip_id: trip.id, "#{seat.id}": seat.id } }
    let(:invalid_params) { { trip_id: trip.id } }

    it 'expect rendering process_payment page' do
      post '/payment', params: valid_params
      get '/process_payment'
      expect(response).to render_template('tickets/process_payment')
    end

    it 'expect redirect to seat plan page for not selecting any seat' do
      post '/payment', params: invalid_params
      get '/process_payment'
      expect(response).to redirect_to(seat_plan_path(session[:trip]))
    end
  end

  describe 'POST /confirm_payment' do
    let(:valid_params) { { trip_id: trip.id, "#{seat.id}": seat.id } }
    let!(:seat1) { create(:seat, bus: trip.bus, booked: true) }
    let(:invalid_params) { { trip_id: trip.id, "#{seat1.id}": seat1.id } }

    it 'expect redirect to booking_path after complete payment with success message' do
      post '/payment', params: valid_params
      get '/process_payment'
      post '/confirm_payment'
      expect(response).to have_http_status(:see_other)
    end

    it 'expect redirect to booking_path after complete payment with failed message' do
      post '/payment', params: invalid_params
      get '/process_payment'
      post '/confirm_payment'
      expect(response).to have_http_status(:see_other)
    end
  end
end
