FactoryBot.define do
  factory :seat do
    number { [*('A'..'Z')].sample + %w[1 2].sample }
    booked { [true, false].sample }
    bus_id { create(:bus).id }
  end
end
