# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

# Client
5.times do |i|
  Client.create!(name: "Client_#{i+1}", address: "District #{i+1}, Ho Chi Minh City", age: 30, private_note: 'Sample data')
end

# Plumber
8.times do |i|
  Plumber.create!(name: "Plumber_#{i+1}",
                  address: "District #{i+3}, Ho Chi Minh City",
                  vehicles: [:walk, :bike, :bus, :car].sample)
end

# Job
Job.create!(description: 'wash basin repair', client: Client.first, plumber: Plumber.first, time_period: '2022-10-10 09:00:00', status: :finished)

Job.create!(description: 'bathtub repair', client: Client.first, plumber: Plumber.first, time_period: '2022-10-31 09:00:00', status: :assigned)
Job.create!(description: 'bathtub repair', client: Client.first, plumber: Plumber.second, time_period: '2022-10-31 09:00:00', status: :assigned)
Job.create!(description: 'wash basin repair', client: Client.second, plumber: Plumber.third, time_period: '2022-11-02 09:00:00', status: :assigned)
