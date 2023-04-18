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
    it { should validate_numericality_of(:capacity).is_greater_than(0).is_less_than_or_equal_to(45) }
    it { should allow_value('ena-wi7jog4h').for(:name) }
    it { should_not allow_value('with white space').for(:name) }
    it { should have_many(:tickets) }
    it { should have_many(:seats) }
    it { should have_many(:trip) }
  end
end
