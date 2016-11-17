FactoryGirl.define do
  factory :article do
    title { Faker::Lorem.sentence(3, false, 4) }
    text { Faker::Lorem.paragraphs }
    create_date { Faker::Date.backward(100) }
    total_coments 0
    user
  end
end