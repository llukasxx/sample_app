# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name:                  "lukasx",
             email:                 "llukasxx@gmail.com",
             password:              "password",
             password_confirmation: "password",
             admin:                 true,
             activated:             true,
             activated_at:          Time.zone.now)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  User.create!(name:                  name,
               email:                 email,
               password:              "password",
               password_confirmation: "password",
               activated:             true,
               activated_at:          Time.zone.now)
end

users = User.order(:created_at).take(6)

50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

# Following relationships

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |f| user.follow(f) }
followers.each { |f| f.follow(user) }