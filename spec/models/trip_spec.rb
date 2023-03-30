require 'rails_helper'

RSpec.describe Trip, type: :model do
  context 'when creating a trip' do
    let(:trip) {FactoryBot.build(:trip)}
    let!(:bus){FactoryBot.build(:bus)}
    let!(:route){FactoryBot.build(:route)}
    let(:ticket1) {FactoryBot.build(:ticket)}
    let(:ticket2) {FactoryBot.build(:ticket)}
    it 'ensure ticket_price presence' do
      trip.ticket_price = nil
      expect(trip.valid?).to eq(false)
    end
    it 'ensure total_booked presence' do
      trip.total_booked = nil
      expect(trip.valid?).to eq(false)
    end
    it 'ensure date presence' do
      trip.date = nil
      expect(trip.valid?).to eq(false)
    end
    it 'ensure time presence' do
      trip.time = nil
      expect(trip.valid?).to eq(false)
    end

    it 'ensure bus presence' do
      trip.bus = nil
      expect(trip.valid?).to eq(false)
    end

    it 'ensure route presence' do
      trip.route = nil
      expect(trip.valid?).to eq(false)
    end

    #association testing
    it 'ensure belongs_to bus' do
      trip.bus = bus
      expect(trip.bus != bus).to eq(false)
    end

    it 'ensure belongs_to route' do
      trip.route = route
      expect(trip.route != route).to eq(false)
    end

    it "ensure has many tickets" do
      trip.tickets << [ticket1, ticket2]
      expect(trip.tickets).to eq([ticket1, ticket2])
  end


  end
end
