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
end
