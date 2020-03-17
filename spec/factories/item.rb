FactoryBot.define do
  factory :item do
    sequence(:title) { |n| "title#{n}" }
    status { 2 }
    price { 1000 }
    sequence(:lecture) { |n| "lecture#{n}" }
    sequence(:teacher) { |n| "teacher#{n}" }
    sequence(:memo) { |n| "memo#{n}" }

    user
  end
end
