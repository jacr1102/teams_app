# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'




Role.create [{name: :super}, {name: :admin}, {name: :user}]
User.create first_name: "Super", email: "super@test.com", username: "Super", password: "ZRS@Ax!$CSxJ", role: Role.where(name: :super).first

def generate_user(role)
  user_role = Role.where(name: role).first

  user = User.create
    first_name: Faker::Name.first_name,
    last_name:  Faker::Name.last_name,
    email:      Faker::Internet.email,
    username:   Faker::Internet.username,
    password:   "123123"
    role:       user_role

    user.profile.create
      english_level: [:none, :a2, :b1, :b2, :c1, :c2].sample,
      technical_experience: Faker::Lorem.paragraphs(number: 2),
      cv_link: Faker::Internet.url
end

3.times do
  generate_user(:admin)
end

10.times do

  account = Account.create
    name: Faker:Company.name,
    client_name: Faker:Company.name,
    user: generate_user(:user)

  5.times do
    account.teams <<  generate_user(:user)
  end
end

10.times do
  User.create
    first_name: Faker::Name.first_name,
    last_name:  Faker::Name.last_name,
    email:      Faker::Internet.email,
    password:   "123123"
    role:       generate_user(:user)
end