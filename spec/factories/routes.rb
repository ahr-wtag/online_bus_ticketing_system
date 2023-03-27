FactoryBot.define do
  factory :route do
    origin {Faker::Travel::Airport.name(size: 'large', region: 'united_states') }
    destination {Faker::Travel::Airport.name(size: 'large', region: 'united_states') }
  end
end
