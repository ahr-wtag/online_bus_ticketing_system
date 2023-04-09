FactoryBot.define do
  factory :user do
    first_name { Faker::Name.last_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    user_name { Faker::Name.first_name }
    phone { Faker::PhoneNumber.cell_phone_in_e164 }
    password { Faker::Internet.password(min_length: 10, max_length: 20) }
  end
end
