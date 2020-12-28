require 'rails_helper'

RSpec.describe Job, type: :model do
  it "Jobの投稿が保存されること" do
    expect(FactoryBot.create(:job)).to be_valid
  end

  describe "タイトルの文字数について" do
    context "3文字以上の時" do
      it "投稿が保存されること" do
        job = FactoryBot.build(:job, title: "ギター")
        expect(job).to be_valid
      end
    end
    context "100文字以下の時" do
      it "投稿が保存されること" do
        job = FactoryBot.build(:job, title: "a" * 100)
        expect(job).to be_valid
      end
    end
    context "2文字以下の時" do
      it "投稿が保存されないこと" do
        job = FactoryBot.build(:job, title: "GT")
        expect(job).to be_invalid
      end
    end
    context "101文字以上の時" do
      it "投稿が保存されないこと" do
        job = FactoryBot.build(:job, title: "a" * 101)
        expect(job).to be_invalid
      end
    end
  end

  describe "本文の文字数について" do
    context "3文字以上の時" do
      it "投稿が保存されること" do
        job = FactoryBot.build(:job, content: "ギター")
        expect(job).to be_valid
      end
    end
    context "1000文字以下の時" do
      it "投稿が保存されること" do
        job = FactoryBot.build(:job, content: "a" * 1000)
        expect(job).to be_valid
      end
    end
    context "2文字以下の時" do
      it "投稿が保存されないこと" do
        job = FactoryBot.build(:job, content: "演奏")
        expect(job).to be_invalid
      end
    end
    context "1001文字以上の時" do
      it "投稿が保存されないこと" do
        job = FactoryBot.build(:job, content: "a" * 1001)
        expect(job).to be_invalid
      end
    end
  end
  
  describe "地域の文字数について" do
    context "256文字以上の時" do
      it "投稿が保存されないこと" do
        job = FactoryBot.build(:job, area: "a" * 256)
        expect(job).to be_invalid
      end
    end
  end

  describe "予算の金額について" do
    context "500円以上の時" do
      it "投稿が保存されること" do
        job = FactoryBot.build(:job, budget: 500)
        expect(job).to be_valid
      end
    end
    context "300000円以下の時" do
      it "投稿が保存されること" do
        job = FactoryBot.build(:job, budget: 300000)
        expect(job).to be_valid
      end
    end
    context "500円未満の時" do
      it "投稿が保存されないこと" do
        job = FactoryBot.build(:job, budget: 400)
        expect(job).to be_invalid
      end
    end
    context "300000円より大きい時" do
      it "投稿が保存されないこと" do
        job = FactoryBot.build(:job, budget: 300100)
        expect(job).to be_invalid
      end
    end
  end
end
