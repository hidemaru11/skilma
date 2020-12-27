require 'rails_helper'

RSpec.describe Skill, type: :model do
  it "Skillの投稿が保存されること" do
    expect(FactoryBot.create(:skill)).to be_valid
  end

  describe "タイトルの文字数について" do
    context "3文字以上の時" do
      it "投稿が保存されること" do
        skill = FactoryBot.build(:skill, title: "ピアノ")
        expect(skill).to be_valid
      end
    end
    context "100文字以下の時" do
      it "投稿が保存されること" do
        skill = FactoryBot.build(:skill, title: "a" * 100)
        expect(skill).to be_valid
      end
    end
    context "2文字以下の時" do
      it "投稿が保存されないこと" do
        skill = FactoryBot.build(:skill, title: "pf")
        expect(skill).to be_invalid
      end
    end
    context "101文字以上の時" do
      it "投稿が保存されないこと" do
        skill = FactoryBot.build(:skill, title: "a" * 101)
        expect(skill).to be_invalid
      end
    end
  end

  describe "スキルの内容の文字数について" do
    context "3文字以上の時" do
      it "投稿が保存されること" do
        skill = FactoryBot.build(:skill, content: "弾ける")
        expect(skill).to be_valid
      end
    end
    context "2000文字以下の時" do
      it "投稿が保存されること" do
        skill = FactoryBot.build(:skill, content: "a" * 2000)
        expect(skill).to be_valid
      end
    end
    context "2文字以下の時" do
      it "投稿が保存されないこと" do
        skill = FactoryBot.build(:skill, content: "弾く")
        expect(skill).to be_invalid
      end
    end
    context "2001文字以上の時" do
      it "投稿が保存されないこと" do
        skill = FactoryBot.build(:skill, content: "a" * 2001)
        expect(skill).to be_invalid
      end
    end
  end  
end
