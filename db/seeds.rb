# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

def generate_user(role)
  User.create( {
      first_name: Faker::Name.unique.first_name,
      last_name:  Faker::Name.unique.last_name,
      email:      Faker::Internet.unique.email,
      username:   Faker::Internet.unique.username,
      password:   "123123",
      role:       Role.find_by_name(role),
      profile_attributes: {
        english_level: Profile.english_levels.keys.sample,
        technical_experience: Faker::Lorem.paragraphs(number: 2),
        cv_link: Faker::Internet.url
      }
    }
  )
end

ActiveRecord::Base.transaction do
  Role.create [{name: :super}, {name: :admin}, {name: :user}]
  User.create(
    first_name: "Super",
    email: "super@test.com",
    username: "Super",
    password: "ZRS@Ax!$CSxJ",
    role: Role.find_by_name(:super),
    profile_attributes: {
        english_level: :c1,
        technical_experience: '',
        cv_link: ''
      }
    )

  3.times do
    generate_user(:admin)
  end

  10.times do
    company_name = Faker::Company.unique.name
    account = Account.create(
      name: company_name.underscore,
      client_name: company_name,
      user: generate_user(:user) )

    5.times do
      account.team <<  generate_user(:user)
    end
  end

  10.times do
    generate_user(:user)
  end

end

accounts = Account.includes(:team).all

accounts.each do |account|
  account.team.each do |user|
    start_date = rand(5..10)
    end_date = rand(1..4)

    UserLog.create( user_id: user.id, account_id: account.id, action: "start" ).update created_at: (Time.now - start_date.years), updated_at: (Time.now - start_date.years)
    UserLog.create( user_id: user.id, account_id: account.id, action: "end" ).update created_at: (Time.now - end_date.years), updated_at: (Time.now - end_date.years)

    UserLog.create( user_id: user.id, account_id: account.id, action: "start" )
  end
end

#logs
# action start_date
# action end_date

#team where teams in single selected
#name by like in first and last names