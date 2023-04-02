require 'rails_helper'

RSpec.describe Route, type: :model do
  let(:route) { FactoryBot.create(:route) }
  describe 'when creating a route' do
    it 'has a valid factory' do
      expect(route).to be_valid
    end
    it { should validate_presence_of(:origin) }
    it { should validate_presence_of(:destination) }
    end
end
