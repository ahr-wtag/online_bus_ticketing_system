require 'rails_helper'

RSpec.describe Seat, type: :model do
  let(:seat) { FactoryBot.build(:seat) }
  describe 'when creating a seat' do
    it 'has a valid factory' do
      expect(seat).to be_valid
    end
    it { should validate_presence_of(:number) }
    it { should belong_to(:bus).optional }
    it { should belong_to(:ticket).optional }
  end
end
