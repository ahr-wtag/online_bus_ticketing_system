require 'rails_helper'

RSpec.describe Seat, type: :model do
  context 'when creating a Seat' do
    let(:seat) {FactoryBot.build(:seat)}
    let(:bus) {FactoryBot.build(:bus)}
    let(:ticket) {FactoryBot.build(:ticket)}

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

    #association testing

    it 'ensure belongs to bus' do
      seat.bus = bus
      expect(seat.bus != bus).to eq(false)
    end
    
    it 'ensure belongs to ticket' do
      seat.ticket = ticket
      expect(seat.ticket != ticket).to eq(false)
    end


  end
end
