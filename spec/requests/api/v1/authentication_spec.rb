require 'rails_helper'

describe 'Authentication', type: :request do
  describe 'POST /authenticate' do
    let(:user){ create(:user, username: "jcalderon", password: "123213" ) }

    it 'authenticates the user' do
      post '/api/v1/authenticate', params: { username: user.username, password: '123123'}

      expect(response).to have_http_status(:created)
      expect(response_body).to eq({
        'token' => '123'
      })
    end
  end
end