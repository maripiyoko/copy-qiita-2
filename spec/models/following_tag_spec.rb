require 'rails_helper'

RSpec.describe FollowingTag, type: :model do

  let(:tag) { create(:tag) }
  let(:item) { create(:item) }

  it "should have a valid factory" do
    expect(build(:following_tag)).to be_valid
  end

  it "should access item via tag" do
    tag_name = 'RSpec'
    item.tag_list.add(tag_name)
    item.save

  end
end
