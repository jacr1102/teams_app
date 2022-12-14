require 'rails_helper'

describe AuthenticationTokenService do
  describe '.call' do
    let(:token){ described_class.class(User.first.id) }

    it 'returns an authentication token' do
      decoded_token = JWT.decode token, described_class::HMAC_SECRET, true, {algorithm: described_class::ALGORITHM_TYPE}
      expect(decoded_token).to eq([
        {"user_id" => User.first.id},
        {"alg" => "HS256"}
      ])
    end
  end
end