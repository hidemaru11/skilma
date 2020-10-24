class Mate < ApplicationRecord
  belongs_to :user
  validates :title, length: { in: 3..100 }
  validates :content, length: { in: 3..1000 }
  validates :area, length: { maximum: 255 }

  scope :sorted_desc, -> { order(created_at: :desc) }
end
