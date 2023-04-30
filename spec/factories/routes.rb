FactoryBot.define do
  factory :route do
    origin {Faker::Travel::Airport.iata(size: 'large', region: 'united_states')}
    destination {Faker::Travel::Airport.iata(size: 'large', region: 'united_states') }
  end
end
