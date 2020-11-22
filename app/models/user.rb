class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include ImageUploader[:image]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :mates, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :skills, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :following
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

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

  def create_notification_follow(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ?", current_user.id, id, "follow"])
    if temp.blank?
      notification = current_user.active_notifications.build(
        visited_id: id,
        action: "follow"
      )
      notification.save if notification.valid?
    end
  end

  def self.guest
    find_or_create_by!(email: "guest@example.com", username: "ゲストユーザー") do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
