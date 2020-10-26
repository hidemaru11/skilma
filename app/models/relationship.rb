class Relationship < ApplicationRecord
  belings_to :follower, class_name: "User"
  belings_to :following, class_name: "User"
  validates :follower_id, presence: true
  validates :following_id, presence: true
end
