FactoryBot.define do
  factory :trip do
    ticket_price {Faker::Number.between(from: 1, to: 1000) }
    total_booked {Faker::Number.between(from: 1, to: 45)}
    date {Faker::Date.between(from: '2023-02-23', to: '2023-09-25') }
    time {Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default)}
  end
end
