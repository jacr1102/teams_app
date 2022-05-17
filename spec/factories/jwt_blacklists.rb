FactoryBot.define do
  factory :jwt_blacklist do
    jti { "MyString" }
    exp { "2022-05-16 18:24:48" }
  end
end
