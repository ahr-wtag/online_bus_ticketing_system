require 'faker'
FactoryBot.define do
  factory :bus do
    name {Faker::Vehicle.singapore_license_plate}
    typed {['ac','non_ac'].sample}
    brand {Faker::Vehicle.manufacture}
    capacity {Faker::Number.between(from: 0, to: 45)}
  end
end
