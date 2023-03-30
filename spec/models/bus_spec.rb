require 'rails_helper'

RSpec.describe Bus, type: :model do
  let(:bus) { FactoryBot.create(:bus) }
  describe 'when creating a bus' do
    it 'has a valid factory' do
      expect(bus).to be_valid
    end
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:typed) }
    it { should validate_presence_of(:brand) }
    it { should validate_presence_of(:capacity) }
    it { should validate_numericality_of(:capacity).is_greater_than(0).is_less_than(46) }
    it { should validate_uniqueness_of(:name).case_insensitive  }
  end
end
