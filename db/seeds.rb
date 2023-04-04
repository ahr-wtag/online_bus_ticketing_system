# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

10.times do
  first_name = Faker::Name.last_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email
  user_name = Faker::Name.first_name
  role = [0, 1].sample
  phone = Faker::PhoneNumber.cell_phone_in_e164
  encrypted_password = Faker::Internet.password(min_length: 10, max_length: 20)

  User.create(first_name:, last_name:, email:, user_name:, role:, phone:,
              encrypted_password:)
end
