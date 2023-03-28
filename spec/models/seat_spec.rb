require 'rails_helper'

RSpec.describe Seat, type: :model do
  context 'when Seat a user' do
    let(:seat) {FactoryBot.build(:seat)}
    let(:bus) {FactoryBot.build(:bus)}

    it 'ensure seat number presence' do
      seat.number = nil
      expect(seat.valid?).to eq(false)
    end

    it 'ensure booked presence' do
      seat.booked = nil
      expect(seat.valid?).to eq(false)
    end
    it 'ensure belongs_to bus' do
      seat.bus = bus
      expect(seat.bus != bus).to eq(false)
    end
  end
end
