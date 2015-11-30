require 'rails_helper'

RSpec.describe User, type: :model do

  it "should have a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "should be invalid if no user name" do
    expect(build(:user, { name: "" })).not_to be_valid
  end

  it "should be invalid if no email" do
    expect(build(:user, { email: "" })).not_to be_valid
  end

  it "should respond items" do
    expect(build(:user).items).to be_empty
  end

  describe "stock" do
    let(:user) { create(:user) }
    let(:item) { create(:item) }

    it "should respond stock_items" do
      expect(user.stock_items).to be_empty
    end

    it "can access stock_items" do
      user.stock(item)
      expect(user.stocks.count).to eq(1)
      expect(user.stock_items.first).to eq(item)
    end

    it "should be invalid if duplicate item stock" do
      user.stock(item)
      user.stock(item)
      expect(user).not_to be_valid
      expect(user.stocks.count).to eq(1)
    end

    it "can be unstock" do
      user.stock(item)
      expect(user.stocks.count).to eq(1)
      user.unstock(item)
      expect(user.stocks.count).to eq(0)
    end

    it "should be destroyed with user destroy" do
      user.stock(item)
      expect(Stock.count).to eq(1)
      user.destroy
      expect(Stock.count).to eq(0)
    end
  end

  describe "follow" do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    it "can follow other user" do
      user.follow_user(other_user)
      expect(user.following.count).to eq(1)
      expect(user.follower.count).to eq(0)
      expect(other_user.follower.count).to eq(1)
      expect(other_user.following.count).to eq(0)
    end

    it "should be invalid if follow duplicate user" do
      user.follow_user(other_user)
      user.follow_user(other_user)
      expect(user).not_to be_valid
      expect(user.following.count).to eq(1)
    end

    it "can unfollow followed user" do
      user.follow_user(other_user)
      expect(user.following.count).to eq(1)
      expect(other_user.follower.count).to eq(1)
      user.unfollow_user(other_user)
      expect(user.following.count).to eq(0)
      expect(other_user.follower.count).to eq(0)
    end
  end

end
