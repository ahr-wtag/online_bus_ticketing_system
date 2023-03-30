require 'rails_helper'

RSpec.describe Route, type: :model do
  context 'when creating a user' do
    let(:route) {FactoryBot.build(:route)}
    let(:trip1) {FactoryBot.build(:trip)}
    let(:trip2) {FactoryBot.build(:trip)}
    it 'ensure origin presence' do
      route.origin = nil
      expect(route.valid?).to eq(false)
    end

    it 'ensure destination presence' do
      route.destination = nil
      expect(route.valid?).to eq(false)
    end

    #association testing
    it "has many trips" do
      route.trips << [trip1, trip2]
      expect(route.trips).to eq([trip1, trip2])
  end
      
  end
end
