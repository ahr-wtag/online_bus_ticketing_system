FactoryBot.define do
  factory :seat do
    number {[*('A'..'Z')].sample+['1','2'].sample}
    booked {[true,false].sample}
    association :bus
  end
end
