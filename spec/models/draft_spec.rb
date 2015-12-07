require 'rails_helper'

RSpec.describe Draft, type: :model do

  it "should have a valid factory" do
    expect(create(:draft)).to be_valid
  end

  it "can select unpublished" do
    10.times { create(:draft) }
    expect(Draft.unpublished.count).to eq 10
  end

  it "can select published" do
    user = create(:user)
    10.times { create(:draft) }
    5.times { create(:draft, {
        user: user,
        item: create(:item, user: user)
    })}
    expect(Draft.unpublished.count).to eq 10
    expect(Draft.published.count).to eq 5
  end

  it "should be invalid if item and draft belongs to different user" do
    item = create(:item, title: "TEST")
    draft = build(:draft, item: item)
    expect(draft.user).not_to eq(item.user)
    expect(draft.valid?).to be_falsey
    expect(draft.errors.messages).to have_key(:item)
  end

  it "publish draft creates new item" do
    draft = create(:draft)
    expect { draft.publish }.to change{ Item.count }.from(0).to(1)
  end

end
