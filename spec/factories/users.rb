FactoryGirl.define do
  factory :user do
    user_name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(6) }
  end
end
