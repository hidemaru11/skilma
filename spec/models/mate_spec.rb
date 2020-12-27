require 'rails_helper'

RSpec.describe Mate, type: :model do
  it "Mateの投稿が保存されること" do
    expect(FactoryBot.create(:mate)).to be_valid
  end

  describe "タイトルの文字数について" do
    context "3文字以上の時" do
      it "投稿が保存されること" do
        mate = FactoryBot.build(:mate, title: "R&B")
        expect(mate).to be_valid
      end
    end
    context "100文字以下の時" do
      it "投稿が保存されること" do
        mate = FactoryBot.build(:mate, title: "a" * 100)
        expect(mate).to be_valid
      end
    end
    context "2文字以下の時" do
      it "投稿が保存されないこと" do
        mate = FactoryBot.build(:mate, title: "RB")
        expect(mate).to be_invalid
      end
    end
    context "101文字以上の時" do
      it "投稿が保存されないこと" do
        mate = FactoryBot.build(:mate, title: "a" * 101)
        expect(mate).to be_invalid
      end
    end
  end

  describe "本文の文字数について" do
    context "3文字以上の時" do
      it "投稿が保存されること" do
        mate = FactoryBot.build(:mate, content: "教えて")
        expect(mate).to be_valid
      end
    end
    context "1000文字以下の時" do
      it "投稿が保存されること" do
        mate = FactoryBot.build(:mate, content: "a" * 1000)
        expect(mate).to be_valid
      end
    end
    context "2文字以下の時" do
      it "投稿が保存されないこと" do
        mate = FactoryBot.build(:mate, content: "曲を")
        expect(mate).to be_invalid
      end
    end
    context "1001文字以上の時" do
      it "投稿が保存されないこと" do
        mate = FactoryBot.build(:mate, content: "a" * 1001)
        expect(mate).to be_invalid
      end
    end
  end
  
  describe "地域の文字数について" do
    context "256文字以上の時" do
      it "投稿が保存されないこと" do
        mate = FactoryBot.build(:mate, area: "a" * 256)
        expect(mate).to be_invalid
      end
    end
  end
end
