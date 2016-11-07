FactoryGirl.define do
  factory :coment do
    association(:article)
    text "text"
    user_id 1
    article_id 1

  end
end