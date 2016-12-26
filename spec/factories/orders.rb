FactoryGirl.define do
  factory :order do
    amount { Faker::Number.decimal(6, 2) }
    service 'paypal'
    article
    user
  end
end
