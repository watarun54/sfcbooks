FactoryBot.define do
  factory :user do
    sequence(:name, 1) { |n| "test#{n}" }
    sequence(:email, 1) { |n| "test#{n}@test.com" }
    password { "password" }
  end
end
