class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  
  VALID_EMAIL_REGEX = /\A[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*\z/
  validates :email, presence: true,
            uniqueness: true,
            format: { with: VALID_EMAIL_REGEX }
  VALID_PASSWORD_REGEX =/\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,32}+\z/i
  validates :password, presence: true,
            confirmation: true,
            format: { with: VALID_PASSWORD_REGEX,
            message: "は半角英字と半角数字をどちらも含み、8文字以上32文字以下で入力してください。" }
  validates :username, presence: true
end
