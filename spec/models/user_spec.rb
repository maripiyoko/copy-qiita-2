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
    let(:user) { build(:user) }
    let(:item) { build(:item) }

    it "should respond stock_items" do
      expect(user.stock_items).to be_empty
    end

    it "can access stock_items" do
      user.stock(item).save
      expect(user.stocks.count).to eq(1)
      expect(user.stock_items.first).to eq(item)
    end

    it "should be invalid if duplicate item stock" do
      user.stock(item).save
      user.stock(item).save
      expect(user.stocks.count).to eq(1)
    end

    it "can be unstock" do
      user.stock(item).save
      expect(user.stocks.count).to eq(1)
      user.unstock(item).save
      expect(user.stocks.count).to eq(0)
    end

    it "should be destroyed with user destroy" do
      user.stock(item).save
      expect(Stock.count).to eq(1)
      user.destroy
      expect(Stock.count).to eq(0)
    end
  end
end
