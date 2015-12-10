require 'rails_helper'

RSpec.describe Item, type: :model do

  it "should have a valid factory" do
    expect(build(:item)).to be_valid
  end

  it "should be invalid if empty title" do
    expect(build(:item, { title: "" })).not_to be_valid
  end

  it "should be invalid if no user" do
    expect(build(:item, { user: nil })).not_to be_valid
  end

  describe "tags" do
    let(:item) { create(:item) }
    it "can be added" do
      item.tag_list.add("RSpec")
      expect(item.tag_list.count).to eq(1)
    end
  end

  describe "public item" do
    it "should have published_at if the item is public" do
      item = create(:item)
      item.publish
      expect(item.published_at).to_not be_nil
    end
  end

  describe "draft" do
    it "created item is private(draft)" do
      10.times { create(:item) }
      expect(Item.drafts.count).to eq(10)
    end
  end
end
