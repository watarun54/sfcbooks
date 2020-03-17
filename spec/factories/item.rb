FactoryBot.define do
  factory :item do
    sequence(:title, 1) { |n| "title#{n}" }
    status { 2 }
    price { 1000 }
    sequence(:lecture, 1) { |n| "lecture#{n}" }
    sequence(:teacher, 1) { |n| "teacher#{n}" }
    sequence(:memo, 1) { |n| "memo#{n}" }

    user
  end
end
