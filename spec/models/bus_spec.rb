require 'rails_helper'

RSpec.describe Bus, type: :model do
  context 'when creating a bus' do
    let(:bus) {FactoryBot.build(:bus)}
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



  end
end
