class Skill < ApplicationRecord
  belongs_to :user

  acts_as_taggable_on :tags

  validates :title, length: { in: 3..100 }
  validates :content, length: { in: 3..2000 }

  scope :sorted_desc, -> { order(created_at: :desc) }

  def self.search(search)
    Skill.where(['title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%"])
  end
end
