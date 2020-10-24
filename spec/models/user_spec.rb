require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do

    context 'can save' do
      it "has a valid factory" do
        expect(FactoryBot.build(:user)).to be_valid
      end
    end

    context "can not save" do
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

      it "is invalid without a username" do
        user = FactoryBot.build(:user, username: nil)
        user.valid?
        expect(user.errors[:username]).to include("を入力してください")
      end

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

      it "is invalid without a password confirmation although with a password" do
        user = FactoryBot.build(:user, password_confirmation: "")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("とPasswordの入力が一致しません")
      end
    end
    
  end
end
