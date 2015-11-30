FactoryGirl.define do

  factory :following_tag do
    association :user
    association :tag
  end

end
