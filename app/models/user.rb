class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :mates, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_one :skill, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :following
  has_many :followers, through: :passive_relationships, source: :follower

  validates :username, presence: true
  validates :profile, length: { maximum: 1000 }

  def follow(other_user)
    following << other_user
  end
  
  def unfollow(other_user)
    active_relationships.find_by(following_id: other_user.id).destroy
  end
  
  def following?(other_user)
    following.include?(other_user)
  end
end
