require "rails_helper"

describe User do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "is valid with an email and password" do
    user = User.new(
      name: 'test',
      email: 'test@example.com',
      password: 'testtest')
      expect(user).to be_valid
  end
  it "is invalid without an email" do
    expect(build(:user, email: nil).errors_on(:email).size).to eq(2)
  end
  it "is invalid without a password" do
    expect(build(:user, password: nil).errors_on(:password).size).to eq(2)
  end
  it "is invalid with a duplicate email address" do
    create(:user, email: 'test@example.com')
    expect(build(:user, email: 'test@example.com').errors_on(:email).size).to eq(1)
  end
end
