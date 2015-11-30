FactoryGirl.define do

  factory :tag, class: ActsAsTaggableOn::Tag do
    name { Faker::Lorem::word }
    taggings_count 0
  end

end
