require 'rails_helper'

RSpec.describe Api::V1::Users, type: :controller do
  describe "GET /api/v1/users" do
    it "returns http success" do
      get :index
      response.should be_success
    end

    it "Create user sending user attributes" do
    end
  end
end