# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# seed for user
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

# seed for bus
10.times do
  name = Faker::Vehicle.singapore_license_plate
  typed = %w[ac non_ac].sample
  brand = Faker::Vehicle.manufacture
  capacity = Faker::Number.between(from: 0, to: 45)
  Bus.create(name:, typed:, brand:, capacity:)
end

# seed for route
10.times do
  origin = Faker::Travel::Airport.iata(size: 'large', region: 'united_states')
  destination = Faker::Travel::Airport.iata(size: 'large', region: 'united_states')
  Route.create(origin:, destination:)
end

# seed for seat
10.times do
  number = [*('A'..'Z')].sample + %w[1 2].sample
  booked = [true, false].sample
  Seat.create!(number:, booked:, bus: Bus.last)
end

# seed for trip
10.times do
  ticket_price = Faker::Number.between(from: 1, to: 1000)
  total_booked = Faker::Number.between(from: 1, to: 45)
  date = Faker::Date.between(from: '2023-02-23', to: '2023-09-25')
  time = Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default)
  Trip.create!(ticket_price:, total_booked:, date:, time:, bus: Bus.last, route: Route.last)
end

# seed for payment
10.times do
  Payment.create
end

# seed for ticket
10.times do
  total_fare = Faker::Number.between(from: 1, to: 1000)
  Ticket.create(total_fare:, user: User.last, trip: Trip.last, bus: Bus.last, payment: Payment.last)
end
