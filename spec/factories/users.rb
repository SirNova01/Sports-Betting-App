FactoryBot.define do
  factory :user do
    name { "John Doe" }
    email { Faker::Internet.unique.email }
    password { "password" }
  end
end
