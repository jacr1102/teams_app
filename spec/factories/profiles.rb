FactoryBot.define do
  factory :profile do
    english_level        { Profile.english_levels.keys.sample }
    technical_experience {Faker::Lorem.paragraphs(number: 2)}
    cv_link              {Faker::Internet.url}
    association :user

  end
end
