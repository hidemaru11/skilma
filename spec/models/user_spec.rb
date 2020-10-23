require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  describe 'email' do
    it "is invalid without an email" do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "is invalid with a duplicate email" do
      FactoryBot.create(:user, email: "steven@example.com")
      user = FactoryBot.build(:user, email: "steven@example.com")
      user.valid?
      expect(user.errors[:email]).to include("はすでに存在します")
    end
  end

  describe 'username' do
    it "is invalid without a username" do
      user = FactoryBot.build(:user, username: nil)
      user.valid?
      expect(user.errors[:username]).to include("を入力してください")
    end
  end

  describe 'password' do
    it "is invalid without a password" do
      user = FactoryBot.build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "is invalid if length is less than 7" do
      user = FactoryBot.build(:user, password: "a" * 7)
      user.valid?
      expect(user.errors[:password]).to include("は8文字以上で入力してください")
    end

    it "is invalid if length is more than 33" do
      user = FactoryBot.build(:user, password: "a" * 33)
      user.valid?
      expect(user.errors[:password]).to include("は32文字以内で入力してください")
    end

    it "is valid if length is 8 to 32" do
      user = FactoryBot.build(:user, password: "1a" * 4)
      expect(user).to be_valid
    end
  end


end
