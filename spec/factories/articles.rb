FactoryGirl.define do
  factory :article do
    association(:user)
    title "tiaaatle"
    text "text"
    user_id 1
    total_coments 0
  end
end