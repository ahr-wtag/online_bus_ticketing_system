require 'rails_helper'

RSpec.describe Route, type: :model do
  context 'when creating a user' do
    let(:route) {FactoryBot.build(:route)}
    it 'ensure origin presence' do
      route.origin = nil
      expect(route.valid?).to eq(false)
    end

    it 'ensure destination presence' do
      route.destination = nil
      expect(route.valid?).to eq(false)
    end
      
  end
end
