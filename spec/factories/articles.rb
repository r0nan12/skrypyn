FactoryGirl.define do
  factory :article do
    title { Faker::Lorem.sentence(3, false, 4) }
    text { Faker::Lorem.paragraphs.first }
    create_date Date.current
    price { Faker::Number.decimal(2) }
    user
  end
end
