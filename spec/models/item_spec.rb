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
end
