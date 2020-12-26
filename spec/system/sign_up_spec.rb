require "rails_helper"

describe "新規ユーザー登録のシステムテスト", type: :system do
  before do
    visit new_user_registration_path
  end

  describe "有効なユーザーの場合" do
    before do
      fill_in "メールアドレス", with: "takumi@example.com"
      fill_in "ユーザー名", with: "タクミ"
      fill_in "8文字以上のパスワード", with: "abcd1234"
      fill_in "確認用パスワード", with: "abcd1234"
      click_button "登録する"
    end
    it "ルートにリダイレクトされること" do
      expect(current_path).to eq root_path
    end
    it "アカウント登録成功メッセージが表示されること" do
      expect(page).to have_content "アカウント登録が完了しました"
    end
  end
  describe "無効なユーザーの場合" do
    before do
      click_button "登録する"
    end
    it "ルートにリダイレクトされないこと" do
      expect(current_path).to_not eq root_path
    end
    it "メールアドレスのエラーメッセージが表示されること" do
      expect(page).to have_content "メールアドレスを入力してください"
    end
    it "名前のエラーメッセージが表示されること" do
      expect(page).to have_content "ユーザー名を入力してください"
    end
    it "パスワードのエラーメッセージが表示されること" do
      expect(page).to have_content "パスワードを入力してください"
    end
  end
end