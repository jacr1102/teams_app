require 'rails_helper'

RSpec.describe User, type: :model do
  it "Full name should be first_name concatenated with Last name" do
    user = build(:user, {first_name: "Jonathan", last_name: "Calderon"})
    expect(user.full_name).to eq( "Jonathan Calderon")
  end

  it "User should be created successfully" do
    expect{create(:user)}.to change{ User.count }
  end

  it "Sould fails if user is created without email" do
    expect{create(:user, email: nil )}.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "User should be created with role User as default" do
    expect( create(:user).role).to eq(Role.find_by_name(:user))
  end

  it "Profile should be created when attributes included in data provided" do
    params = {
      user: {
        first_name: Faker::Name.unique.first_name, last_name:  Faker::Name.unique.last_name, email:      Faker::Internet.unique.email, username:   Faker::Internet.unique.username, password:   "123123",
        profile_attributes: {
          english_level: Profile.english_levels.keys.sample, technical_experience: Faker::Lorem.paragraphs(number: 2), cv_link: Faker::Internet.url
        }
      }
    }

    expect{ create( :user, params[:user] ) }.to change{ Profile.count }
  end
end
user = User.create(  )