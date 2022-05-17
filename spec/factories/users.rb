FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "Name #{n}" }
    sequence(:last_name)  { |n| "LastName #{n}" }
    username              { |n| "Name#{n}LastName#{n}" }
    sequence(:email)      { |n| "test#{n}@email.com" }
    password              { "123456" }

    trait :admin do
      admin_role
    end

    trait :super do
      super_role
    end

    factory :admin_user, traits: [:admin]
    factory :super_user, traits: [:super]
  end
end
