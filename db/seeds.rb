# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               )
end

5.times do |num|
  num = 1
  20.times do |n|
    name = Faker::Book.title
    contents = Faker::Quote.famous_last_words
    deadline = Faker::Date.between(Date.today, 2.days.since)
    status = Faker::Number.between(0, 2)
    priority = Faker::Number.between(0, 2)
    Task.create!(name: name,
                user_id: num
                )       
    num += 1                 
  end
end
