require "rails_helper"

describe "ログインのシステムテスト", type: :system do
  before do
    visit new_user_session_path
  end

  describe "有効なログインの場合" do
    before do
      user = FactoryBot.create(:user)
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_button "ログイン"
    end
    it "ルートにリダイレクトされること" do
      expect(current_path).to eq root_path
    end
    it "ログイン後のメニュー一覧が表示されること" do
      expect(page).to have_content "スキルを探す"
      expect(page).to have_content "音楽仲間を探す"
      expect(page).to have_content "仕事を依頼する"
      expect(page).to have_content "ログアウト"
    end
    it "ログイン成功メッセージが表示されること" do
      expect(page).to have_content "ログインしました"
    end
  end
  describe "無効なログインの場合" do
    before do
      fill_in "メールアドレス", with: "a"
      fill_in "パスワード", with: "a"
      click_button "ログイン"
    end
    it "ルートにリダイレクトされないこと" do
      expect(current_path).to_not eq root_path
    end
    it "エラーメッセージが表示されること" do
      expect(page).to have_content "メールアドレスまたはパスワードが違います。"
    end
  end
end