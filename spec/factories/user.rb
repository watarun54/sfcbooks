FactoryBot.define do
  factory :user do
    sequence(:name, 1) { |n| "test#{n}" }
    sequence(:email, 1) { |n| "test#{n}@test.com" }
    password { "password" }

    before(:create) do |user|
      user.skip_confirmation_notification!
      user.skip_confirmation!
    end
  end
end
