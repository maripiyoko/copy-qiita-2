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
end
