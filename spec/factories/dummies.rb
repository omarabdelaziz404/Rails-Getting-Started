FactoryBot.define do
  factory :dummy do
    name { "MyString" }
    age { rand(1..100) }
    born_at { "2025-11-20 19:52:41" } 
    sequence(:email) { |n| "test+#{n}@gmail.com" }
  end
end
