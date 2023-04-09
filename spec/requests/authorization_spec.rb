require 'rails_helper'
require 'cancan/matchers'

RSpec.describe 'Authorizations', type: :request do
  describe 'User abilities' do
    let(:user) { create(:user, role: 0) }
    let(:ability) { Ability.new(user) }
    let(:route) { create(:route) }
    let(:bus) { create(:bus) }
    let(:trip) { create(:route) }
    let(:route) { create(:route) }

    context 'when user is not admin' do
      it 'does not allow the user to manage bus' do
        expect(ability).not_to be_able_to(:manage, bus)
      end
      it 'does not allow the user to manage route' do
        expect(ability).not_to be_able_to(:manage, route)
      end
      it 'does not allow the user to manage trip' do
        expect(ability).not_to be_able_to(:manage, trip)
      end

      it 'does allow the user to see trips' do
        expect(ability).to be_able_to(:read, trip)
      end
      it 'does allow the user to see buses' do
        expect(ability).to be_able_to(:read, bus)
      end
      it 'does allow the user to see route' do
        expect(ability).to be_able_to(:read, route)
      end
    end

    context 'when user is admin' do
      let(:user) { create(:user, role: 1) }
      it 'does allow the user to manage bus' do
        expect(ability).to be_able_to(:manage, bus)
      end
      it 'does allow the user to manage route' do
        expect(ability).to be_able_to(:manage, route)
      end
      it 'does allow the user to manage trip' do
        expect(ability).to be_able_to(:manage, trip)
      end
    end
  end
end
