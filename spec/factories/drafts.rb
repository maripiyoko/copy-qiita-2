FactoryGirl.define do
  factory :draft do
    title { Faker::Lorem::character }
    content { Faker::Lorem::paragraph }
    association :user
    item nil
  end

end
