class Mate < ApplicationRecord
  belongs_to :user

  acts_as_taggable_on :tags

  validates :title, length: { in: 3..100 }
  validates :content, length: { in: 3..1000 }
  validates :area, length: { maximum: 255 }

  scope :sorted_desc, -> { order(created_at: :desc) }

  def self.search(search)
    Mate.where(['title LIKE ? OR content LIKE ? OR area LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%"])
  end
end
