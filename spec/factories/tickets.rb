FactoryBot.define do
  factory :ticket do
    total_fare {Faker::Number.between(from: 1, to: 1000) }
    association :user
    association :trip
    association :bus
    association :payment
  end
end
