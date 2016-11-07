FactoryGirl.define do
  factory :user do
    association(:role)
    sequence(:email) { |n| "email_#{n}@email.ua" }
    password "password"
    role_id 2

  end
end