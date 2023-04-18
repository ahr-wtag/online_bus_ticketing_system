require 'rails_helper'

RSpec.describe Trip, type: :model do
  let(:trip) { FactoryBot.build(:trip) }
  describe 'when creating a trip' do
    it 'has a valid factory' do
      expect(trip).to be_valid
    end
    it { should validate_presence_of(:time) }
    it { should validate_presence_of(:ticket_price) }
    it { should validate_presence_of(:total_booked) }
    it { should validate_presence_of(:date) }
    it { should belong_to(:bus).optional }
    it { should belong_to(:route).optional }
    it { should have_many(:tickets) }
  end
end
