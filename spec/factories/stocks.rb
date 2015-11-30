FactoryGirl.define do
  factory :stock do
    association :item
    association :user
  end

end
