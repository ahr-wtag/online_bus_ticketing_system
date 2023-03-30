require 'rails_helper'

RSpec.describe Bus, type: :model do
  context 'when creating a bus' do
    let(:bus) {FactoryBot.build(:bus)}
    let(:ticket1) {FactoryBot.build(:ticket)}
    let(:ticket2) {FactoryBot.build(:ticket)}
    let(:seat1) {FactoryBot.build(:seat)}
    let(:seat2) {FactoryBot.build(:seat)}
    let(:route) {FactoryBot.build(:route)}
    let(:trip) {FactoryBot.build(:trip)}
    it 'ensure name presence' do
      bus.name = nil
      expect(bus.valid?).to eq(false)
    end

    it 'ensure type presence' do
      bus.typed = nil
      expect(bus.valid?).to eq(false)
    end


    it 'ensure brand presence' do
      bus.brand = nil
      expect(bus.valid?).to eq(false)
    end

    it 'ensure capacity presence' do
      bus.capacity = nil
      expect(bus.valid?).to eq(false)
    end


    it 'ensure capacity is greater than 0' do
      bus.capacity = -1
      expect(bus.valid?).to eq(false)
    end


    it 'ensure capacity is less than or equal 45' do
      bus.capacity = 46
      expect(bus.valid?).to eq(false)
    end

    it 'ensure bus name / lisence is unique' do
      Bus.create(name:'ena-123',typed:'ac',brand:'ena',capacity:'45')
      another_bus = 
      Bus.create(name:'ena-123',typed:'non_ac',brand:'ena',capacity:'35')
      expect(another_bus.valid?).to eq(false)
    end



    #association testing

    it "has many tickets" do
        bus.tickets << [ticket1, ticket2]
        expect(bus.tickets).to eq([ticket1, ticket2])
    end

    it "has many seats" do
      bus.seats << [seat1, seat2]
      expect(bus.seats).to eq([seat1, seat2])
    end

    it "has one trip" do
      trip.bus = bus;
      expect(bus.trip).to eq(trip)
    end
  end
end
