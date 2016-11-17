FactoryGirl.define do
  factory :coment do
    text { Faker::Lorem.sentence(3, false, 1) }
    user
    article
  end
end