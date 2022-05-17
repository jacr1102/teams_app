require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /api/v1/users" do

    it "returns http success" do
      FactoryBot.create_list(:user, 10)
      get '/api/v1/users'
      expect(response).to have_http_status(:success)
    end
  end
  describe "POST /api/v1/users" do
    let(:params){
      {user: {
        first_name: Faker::Name.unique.first_name, last_name:  Faker::Name.unique.last_name, email:      Faker::Internet.unique.email, username:   Faker::Internet.unique.username, password:   "123123",
        profile_attributes: {
          english_level: Profile.english_levels.keys.sample, technical_experience: Faker::Lorem.paragraphs(number: 2), cv_link: Faker::Internet.url
        }
      }}
    }

    it "returns http return code 201" do
      FactoryBot.create_list(:user, 10)
      post '/api/v1/users', params: params
      expect(response).to have_http_status(:success)
    end

    it "Returns Unprocessable Entity code" do
      params[:user].delete(:email)
      post '/api/v1/users', params: params
      expect(response.code).to eq("422")
    end
  end
end