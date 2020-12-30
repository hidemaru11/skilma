require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user) { FactoryBot.build(:user) }
  let(:other_user) { FactoryBot.build(:other_user) }
  before do
    user.save
    other_user.save
    user.follow(other_user)
  end
  describe "フォロー" do
    it "相手をフォローできている" do
      expect(user.following).to include other_user
    end
  end
end
