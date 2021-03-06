# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Booking.destroy_all
Plant.destroy_all
User.destroy_all
user = User.create!(email: 'test@test.com', password: 123123)
10.times do
  plant = Plant.new(name: 'Ficus', address: 'London', price: 30)
  plant.user = user
  plant.save!
end
