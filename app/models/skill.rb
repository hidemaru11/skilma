class Skill < ApplicationRecord
  belongs_to :user

  validates :title, length: { in: 3..100 }
  validates :content, length: { in: 3..2000 }

  scope :sorted_desc, -> { order(created_at: :desc) }
end
