FactoryBot.define do
  factory :user do
    first_name { 'Redwan' }
    last_name { 'ahmed' }
    email { Faker::Internet.email }
    user_name { Faker::Name.first_name }
    phone { '+8801900000000' }
    password { Faker::Internet.password(min_length: 10, max_length: 20) }
  end
end
